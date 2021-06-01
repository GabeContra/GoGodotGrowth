extends AudioStreamPlayer



func _ready():
	play()
	$Tween.interpolate_property(self, "volume_db", -12, 0, 2, Tween.TRANS_LINEAR)
	$Tween.start()
