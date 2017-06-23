extends Node

var player
var map 



func _ready():
	player = get_node("map/player");
	map = get_node("map").level; 
	
	get_node("start").show_modal();
	
	var moveButtons = get_node("buttons");
	moveButtons.set_pos(Global.getGlobalSize()-moveButtons.get_size()*1.1)
	var rotateButton = get_node("rotate");
	rotateButton.set_pos(Vector2(0,Global.getGlobalSize().y)-rotateButton.get_size()*Vector2(-0.7,2))
	
	
	var ogr = preload("res://Scenes/ogr.tscn").instance();
	ogr.movement_type = 0;
	add_child(ogr)
	var ogr = preload("res://Scenes/ogr.tscn").instance();
	ogr.movement_type = 0;
	add_child(ogr)
	var ogr = preload("res://Scenes/ogr.tscn").instance();
	ogr.movement_type = 1;
	add_child(ogr)
	var ogr = preload("res://Scenes/ogr.tscn").instance();
	ogr.movement_type = 1;
	add_child(ogr)

	pass
	


func _on_top_button_down():
	player.movement(0)
	pass 
func _on_right_button_down():
	player.movement(1)
	pass 
func _on_bottom_button_down():
	player.movement(2)
	pass 
func _on_left_button_down():
	player.movement(3)
	pass 

func _on_top_button_up():
	player.isMove = false;
	pass
func _on_bottom_button_up():
	player.isMove = false;
	pass 

func _on_right_button_up():
	player.isMove = false;
	pass
func _on_left_button_up():
	player.isMove = false;
	pass 

func _on_rotate_pressed():
	player.cameraRotate()
	pass # replace with function body

func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
	pass # replace with function body



