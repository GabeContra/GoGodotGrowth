extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal moveDone(pos)
var lastDirection
var sliding = false

var tile_size = 32
var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}

# Called when the node enters the scene tree for the first time.
func _ready():
	$RayCast2D.enabled = true
	 # Replace with function body.

func _input(event):
	if !$Tween.is_active():
		if event.is_action_pressed("ui_right"):
			move(inputs["right"])
		elif event.is_action_pressed("ui_left"):
			move(inputs["left"])
		elif event.is_action_pressed("ui_up"):
			move(inputs["up"])
		elif event.is_action_pressed("ui_down"):
			move(inputs["down"])
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func move(direction):
	lastDirection = direction
	$RayCast2D.cast_to = direction * tile_size
	$RayCast2D.force_raycast_update()
	if !$RayCast2D.is_colliding():
		$Tween.interpolate_property(self, "position", position, position + direction * tile_size, 0.4, Tween.TRANS_LINEAR)
		$Tween.start()
	else:
		print("hit something")
		var objectHit = $RayCast2D.get_collider()
		if(objectHit.has_method("pushback")):
			if sliding:
				sliding = false
				return
			if(objectHit.pushback(direction)):
				$Tween.interpolate_property(self, "position", position, position + direction * tile_size, 0.4, Tween.TRANS_LINEAR)
				$Tween.start()
	

func keepControl():
	print("keeping")
	sliding = false
	if Input.is_action_pressed("ui_right"):
		move(inputs["right"])
	elif Input.is_action_pressed("ui_left"):
		move(inputs["left"])
	elif Input.is_action_pressed("ui_up"):
		move(inputs["up"])
	elif Input.is_action_pressed("ui_down"):
		move(inputs["down"])
	
func slide():
	sliding = true
	move(lastDirection)

func _on_Tween_tween_completed(object, key):
		emit_signal("moveDone", position)
