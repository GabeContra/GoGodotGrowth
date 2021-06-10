extends Area2D
class_name Goal

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var numOfBalls = 1
export(PackedScene) var NextLevel
signal failed
signal wonLevel(next)

var Balls = []
var lastBallAdded = null
var initPosition
var failing = false
# Called when the node enters the scene tree for the first time.
func _ready():
	var nextBallPos = position
	nextBallPos.x += 16
	nextBallPos.y += 16
	nextBallPos += $Sprite.offset
	initPosition = nextBallPos
	if self.has_node("ballHolder"):
		var holder = self.get_node("ballHolder")
		numOfBalls = holder.get_child_count()

func addBall(ball):
	if Balls.size() > 0:
		lastBallAdded = Balls[-1]
	Balls.append(ball)
	moveBall(ball)
	

func moveBall(ball):
	ball.z_index = 1 + Balls.size()
	var nextBallPos = initPosition
	if Balls.size() > 1:
		for obj in Balls:
			if obj == ball:
				break
			nextBallPos.y -= 16 * (0.2+0.1*obj.scaleLevel)
	$Tween.interpolate_property(ball, "position", ball.position, nextBallPos, 1, Tween.TRANS_LINEAR)
	$Tween.start()

func checkFail():
	if lastBallAdded != null:
		if Balls[-1].scaleLevel > lastBallAdded.scaleLevel:
			fail()
	if !failing and Balls.size() == numOfBalls:
		emit_signal("wonLevel", NextLevel)


func fail():
	failing = true
	for i in range(0, Balls.size() - 1):
		Balls[i].visible = false
	$Tween.interpolate_property(Balls[-1], "position", Balls[-1].position, initPosition, 1.5, Tween.TRANS_EXPO, Tween.EASE_IN)
	$Tween.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Tween_tween_completed(object, key):
	if !failing:
		checkFail()
	else:
		emit_signal("failed")
