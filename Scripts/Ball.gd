tool
extends Area2D


signal moving(pos, dir)
signal moveDone(pos)

var lastDirection
var tile_size = 32

export(int) var scaleLevel = 1 setget setScale, getScale

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func pushback(direction):
	lastDirection = direction
	if scaleLevel == 12:
		return false
	$RayCast2D.cast_to = direction * tile_size
	$RayCast2D.force_raycast_update()
	if !$RayCast2D.is_colliding():
		emit_signal("moving", position, direction)
		$Tween.interpolate_property(self, "position", position, position + direction * tile_size, 0.4, Tween.TRANS_LINEAR)
		$Tween.start()
		return true
	return false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func slide():
	pushback(lastDirection)

func getScale():
	return scaleLevel
	
func setScale(scale):
	scaleLevel = scale
	$Sprite.scale = Vector2(0.2+0.1*scaleLevel,0.2+0.1*scaleLevel)


func _on_Tween_tween_completed(object, key):
	emit_signal("moveDone", position)
