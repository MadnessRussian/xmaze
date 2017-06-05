extends Node

func _ready():
	var GlobalSize = Global.getGlobalSize();
	var buttonSize = Global.getButtonSize();
	var buttons = get_node("buttons");
	buttons.set_pos(Vector2(GlobalSize.x/2-buttonSize.x/2,
							GlobalSize.y/2-buttonSize.y/2))
	
	pass


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Main.tscn")
	pass # replace with function body
