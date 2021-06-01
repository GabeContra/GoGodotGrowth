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
	var tileIndex = $Floor.get_cellv($Floor.world_to_map(pos))
	if tileIndex == 0:
		$Floor/Objects/Player.slide()
		return
	else:
		$Floor/Objects/Player.keepControl()
		return
	print("headadd")


func _on_Ball_moving(pos, dir):
	var currentPos = $Floor.world_to_map(pos)
	var tileIndex = $Floor.get_cellv(currentPos)
	var nextTileIndex = $Floor.get_cellv(currentPos + dir)
	if tileIndex == 1 and nextTileIndex == 1:
		$Floor/Objects/Ball.scaleLevel += 1
		


func _on_Ball_moveDone(pos):
	var tileIndex = $Floor.get_cellv($Floor.world_to_map(pos))
	if tileIndex == 0:
		$Floor/Objects/Ball.slide()


func _on_Player_moving(pos, dir):
	var currentPos = $Floor.world_to_map(pos)
	var tileIndex = $Floor.get_cellv(currentPos)
	var nextTileIndex = $Floor.get_cellv(currentPos + dir)
	if nextTileIndex == 0:
		$Floor/Objects/Player.sliding = true
	if nextTileIndex == 1:
		$Floor/Objects/Player.sliding = false
