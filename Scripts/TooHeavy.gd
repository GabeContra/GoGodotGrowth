extends Popup




func _on_Ball_tooHeavy():
	popup()
	$Tween.interpolate_property(self, "anchor_top", anchor_top, 0.8, 0.2, Tween.TRANS_LINEAR)
	$Tween.stop_all()
	$Tween.start()
	$Tween.interpolate_property(self, "anchor_top", anchor_top, 1, 0.2, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, 1)
