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


func _on_Ball_moving(pos, dir):
	var currentPos = $TileMap.world_to_map(pos)
	var tileIndex = $TileMap.get_cellv(currentPos)
	var nextTileIndex = $TileMap.get_cellv(currentPos + dir)
	if tileIndex == 1 and nextTileIndex == 1:
		$Ball.scaleLevel += 1
		


func _on_Ball_moveDone(pos):
	var tileIndex = $TileMap.get_cellv($TileMap.world_to_map(pos))
	if tileIndex == 0:
		$Ball.slide()
