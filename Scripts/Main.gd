extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var nextLevel

# Called when the node enters the scene tree for the first time.
func _ready():
	$Floor/Objects/Level1/Player/Camera2D.current = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Player_moveDone(pos, obj):
	var tileIndex = $Floor.get_cellv($Floor.world_to_map(pos))
	if tileIndex == 0:
		obj.slide()
		return
	else:
		obj.keepControl()
		return


func _on_Ball_moving(obj, pos, dir):
	var currentPos = $Floor.world_to_map(pos)
	var tileIndex = $Floor.get_cellv(currentPos)
	var nextTileIndex = $Floor.get_cellv(currentPos + dir)
	if tileIndex == 1 and nextTileIndex == 1:
		obj.scaleLevel += 1
		


func _on_Ball_moveDone(obj, pos):
	var tileIndex = $Floor.get_cellv($Floor.world_to_map(pos))
	if tileIndex == 0:
		obj.slide()


func _on_Player_moving(pos, dir, obj):
	var currentPos = $Floor.world_to_map(pos)
	var tileIndex = $Floor.get_cellv(currentPos)
	var nextTileIndex = $Floor.get_cellv(currentPos + dir)
	if nextTileIndex == 0:
		obj.sliding = true
	if nextTileIndex == 1:
		obj.sliding = false


func _on_Goal_failed():
	$UI/LossPopup.popup_centered()


func _on_Button_pressed():
	get_tree().reload_current_scene()


func _on_Goal_wonLevel(next):
	nextLevel = next
	$UI/WinPopop.popup_centered()


func _on_WinPopop_confirmed():
	get_tree().change_scene_to(nextLevel)


func _on_LossPopup_confirmed():
	get_tree().reload_current_scene()
