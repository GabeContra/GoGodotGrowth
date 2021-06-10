extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
signal moveDone(pos, obj)
signal moving(pos, dir, obj)
var lastDirection
var sliding = false
var leftFootForward = true

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
	updateAnimDirection()
	if !$RayCast2D.is_colliding():
		emit_signal("moving", position, direction, self)
		$Tween.interpolate_property(self, "position", position, position + direction * tile_size, 0.4, Tween.TRANS_LINEAR)
		$Tween.start()
		$Sprite.frame = 1 + int(leftFootForward)
		if (!sliding):
			leftFootForward = !leftFootForward
	else:
		var objectHit = $RayCast2D.get_collider()
		if(objectHit.has_method("pushback")):
			if sliding:
				sliding = false
				$Sprite.frame = 0
				return
			if(objectHit.pushback(direction, true)):
				$Tween.interpolate_property(self, "position", position, position + direction * tile_size, 0.4, Tween.TRANS_LINEAR)
				$Tween.start()
				$Sprite.frame = 1 + int(leftFootForward)
				print(leftFootForward)
				if (!sliding):
					leftFootForward = !leftFootForward
		sliding = false
		if!(objectHit.has_method("pushback")):
			if (!sliding):
				$Sprite.frame = 0

func keepControl():
	sliding = false
	if Input.is_action_pressed("ui_right"):
		move(inputs["right"])
	elif Input.is_action_pressed("ui_left"):
		move(inputs["left"])
	elif Input.is_action_pressed("ui_up"):
		move(inputs["up"])
	elif Input.is_action_pressed("ui_down"):
		move(inputs["down"])

func updateAnimDirection():
	var newDirection = $RayCast2D.cast_to.normalized()
	if newDirection == Vector2.UP:
		$Sprite.animation = "Up"
	if newDirection == Vector2.DOWN:
		$Sprite.animation = "Down"
	if newDirection == Vector2.LEFT:
		$Sprite.animation = "Left"
	if newDirection == Vector2.RIGHT:
		$Sprite.animation = "Right"

func slide():
	sliding = true
	move(lastDirection)

func _on_Tween_tween_completed(object, key):
		if (!sliding):
			$Sprite.frame = 0
		emit_signal("moveDone", position, self)


func _on_Tween_tween_step(object, key, elapsed, value):
	if (elapsed > 0.3 && !sliding):
		$Sprite.frame = 0
