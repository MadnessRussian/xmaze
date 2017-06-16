extends Node

var player
var map 
var cameraAndLight
var isMove = false;
var type = 0;
var deltasumm = 0;

#Переменные для поворота камеры
#флаг поворота
var cameraRotate = false;
#дельта поворота
var deltaAngle = 0;
#скорость поворота
var cameraSpeed = 140;
#окончательный угол на который нам нужно повернуть
var currentAngle;

#переменные для движения
#флаг движения
var movement = false;
#дельта движения
var movementDelta = 0;
#скорость движения
var movementSpeed = 5;
#окончательная позиция куда нужно попасть
var movementFinishPosition;
#направление перемешения
var currentPos;
#дельта перемещения
var deltaPoint;


#направления движений
var moveDirs = [
				Vector2(0,-1),
				Vector2(1,0),
				Vector2(0,1),
				Vector2(-1,0)
				]
#типы движений(по часовой стрелке) верх-вправо-вниз-влево
var types = [0,1,2,3];


func _ready():
	player = get_node("map/player");
	map = get_node("map").level; 
	cameraAndLight = get_node("map/player/cameraAndLight")
	
	set_process(true)
	pass
	
func _process(delta):
	if(deltasumm<0.5):
		deltasumm+=delta

	if(isMove == true && movement == false && cameraRotate == false && deltasumm>0.3):
		deltasumm = 0;
		if (map[Global.getPlayerPos().x][Global.getPlayerPos().y].getDirections()[type] ==0):
			Global.setPlayerPos(Global.getPlayerPos()+moveDirs[type]);
			currentPos = Vector3(moveDirs[type].x*2,0,moveDirs[type].y*2)
			movementFinishPosition = player.get_translation() + currentPos;
			deltaPoint = Vector3(0,0,0);
			movement = true;

	if(movement == true):
		move(delta)
	
	if(cameraRotate == true):
		rotate(delta)
	pass
func rotate(delta):
	deltaAngle+=delta*cameraSpeed;
	if(deltaAngle<90):
		cameraAndLight.set_rotation_deg(cameraAndLight.get_rotation_deg()+Vector3(0,delta*cameraSpeed,0));
	else:
		cameraRotate = false;
		cameraAndLight.set_rotation_deg(currentAngle)
		deltaAngle = 0;

func move(delta):
	movementDelta+=delta*movementSpeed;
	if(currentPos.x<0):
		deltaPoint.x=-delta*movementSpeed;
	if(currentPos.x>0):
		deltaPoint.x=delta*movementSpeed;
	if(currentPos.z<0):
		deltaPoint.z=-delta*movementSpeed;
	if(currentPos.z>0):
		deltaPoint.z=delta*movementSpeed;
	if(movementDelta<2):
			player.set_translation(player.get_translation()+deltaPoint);
	else:
			player.set_translation(movementFinishPosition);
			movementDelta = 0;
			movement = false;
	pass

func movement(move_type):
	if isMove == false :
		isMove = true;
		type = types[move_type];
	pass

func _on_top_button_down():
	movement(0)
	pass 
func _on_right_button_down():
	movement(1)
	pass 
func _on_bottom_button_down():
	movement(2)
	pass 
func _on_left_button_down():
	movement(3)
	pass 

func _on_top_button_up():
	isMove = false;
	pass
func _on_bottom_button_up():
	isMove = false;
	pass 

func _on_right_button_up():
	isMove = false;
	pass
func _on_left_button_up():
	isMove = false;
	pass 



func _on_Button_pressed():
	get_tree().change_scene("res://Scenes/Menu.tscn")
	pass # replace with function body


func _on_rotate_pressed():
	if(cameraRotate == false):
		var temp = [];
		for i in range(types.size()-1):
			temp.append(types[i]);
		temp.push_front(types[types.size()-1]);
		types = temp;
		currentAngle = cameraAndLight.get_rotation_deg()+Vector3(0,90,0);
		cameraRotate = true;
	pass # replace with function body
