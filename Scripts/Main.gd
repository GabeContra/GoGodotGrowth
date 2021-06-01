extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_moveDone(pos):
	var tileIndex = $TileMap.get_cellv($TileMap.world_to_map(pos))
	if tileIndex == 0:
		$TileMap/Player.slide()
	else:
		$TileMap/Player.keepControl()
