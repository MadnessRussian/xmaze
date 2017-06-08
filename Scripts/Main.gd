extends Node

var player
var map 
var isMove = false;
var type = 0;
var deltasumm = 0;

var moveDirs = [
				Vector2(0,-1),
				Vector2(1,0),
				Vector2(0,1),
				Vector2(-1,0)
				]

func _ready():
	player = get_node("map/player");
	map = get_node("map").level;
	
	set_process(true)
	pass
	
func _process(delta):
	if(deltasumm<0.5):
		deltasumm+=delta

	if(isMove == true && deltasumm>0.3):
		deltasumm = 0;
		move(type)
	pass

func move(type):
	if(map[Global.getPlayerPos().x][Global.getPlayerPos().y].getDirections()[type] ==0):
		Global.setPlayerPos(Global.getPlayerPos()+moveDirs[type]);
		player.set_translation(player.get_translation()+Vector3(moveDirs[type].x*2,0,moveDirs[type].y*2));
	pass



func _on_top_button_down():
	if isMove == false :
		isMove = true;
		type = 0;
	pass 

func _on_top_button_up():
	isMove = false;
	pass


func _on_bottom_button_down():
	if isMove == false :
		isMove = true;
		type = 2;
	pass 


func _on_bottom_button_up():
	isMove = false;
	pass 


func _on_right_button_down():
	if isMove == false :
		isMove = true;
		type = 1;
	pass # replace with function body


func _on_right_button_up():
	isMove = false;
	pass # replace with function body


func _on_left_button_down():
	if isMove == false :
		isMove = true;
		type = 3;
	pass # replace with function body


func _on_left_button_up():
	isMove = false;
	pass # replace with function body


func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
	pass # replace with function body
