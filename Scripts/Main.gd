extends Node

func _ready():
	pass

#детектор свайпа
func _on_SwipeDetector_swiped( gesture ):
	print(gesture.get_direction())
	pass
