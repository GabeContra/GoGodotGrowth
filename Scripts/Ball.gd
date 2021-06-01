extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var tile_size = 32

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func pushback(direction):
	$RayCast2D.cast_to = direction * tile_size
	$RayCast2D.force_raycast_update()
	if !$RayCast2D.is_colliding():
		$Tween.interpolate_property(self, "position", position, position + direction * tile_size, 0.5, Tween.TRANS_LINEAR)
		$Tween.start()
		return true
	return false
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
