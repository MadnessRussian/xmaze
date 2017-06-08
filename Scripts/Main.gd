extends Node

var player
var map 

var moveDirs = [
				Vector2(0,-1),
				Vector2(1,0),
				Vector2(0,1),
				Vector2(-1,0)
				]

func _ready():
	player = get_node("map/player");
	map = get_node("map").level;
	pass

func move(type):
	if(map[Global.getPlayerPos().x][Global.getPlayerPos().y].getDirections()[type] ==0):
		Global.setPlayerPos(Global.getPlayerPos()+moveDirs[type]);
		player.set_translation(player.get_translation()+Vector3(moveDirs[type].x*2,0,moveDirs[type].y*2))
	pass

func _on_top_pressed():
	move(0)
	pass 
func _on_bottom_pressed():
	move(2)
	pass 
func _on_right_pressed():
	move(1)
	pass #
func _on_left_pressed():
	move(3)
	pass 
