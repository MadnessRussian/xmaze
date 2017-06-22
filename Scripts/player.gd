extends KinematicBody

var isMove = false;
var type = 0;
var deltasumm = 0;

var cameraAndLight
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
#окончательная позиция куда нужно попасть
var movementFinishPosition;
#направление перемешения
var currentPos;
#дельта перемещения
var deltaPoint;
#типы движений(по часовой стрелке) верх-вправо-вниз-влево
var types = [0,1,2,3];
var deltaTime = 0.5;

func _ready():
	cameraAndLight = get_node("cameraAndLight");
	set_process(true)
	pass
func _process(delta):
	#счетчик действий. не можем сделать что либо чаще утановленного промежутка времени
	if(deltasumm<deltaTime):
		deltasumm+=delta
	
	#проверка на движение. если мы уже не двигаемся. камеру не двигаем и время позволяет то выполняем движение
	if(isMove == true && movement == false && cameraRotate == false && deltasumm>deltaTime/2):
		deltasumm = 0;
		#проверяем. открыт ли нам путь
		if (Global.map[Global.getPlayerPos().x][Global.getPlayerPos().y].getDirections()[type] ==0):
			#путь открыт - меняем координату персонажа
			Global.setPlayerPos(Global.getPlayerPos()+Global.moveDirs[type]);
			#для перемешения задаем ему позицию в которую он должен прийти и вектор
			currentPos = Vector3(Global.moveDirs[type].x*2,0,Global.moveDirs[type].y*2)
			movementFinishPosition = get_translation() + currentPos;
			#ставим флаг движения и обнуляем дельту позиции
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
	movementDelta+=delta*Global.movementSpeed;
	if(currentPos.x<0):
		deltaPoint.x=-delta*Global.movementSpeed;
	if(currentPos.x>0):
		deltaPoint.x=delta*Global.movementSpeed;
	if(currentPos.z<0):
		deltaPoint.z=-delta*Global.movementSpeed;
	if(currentPos.z>0):
		deltaPoint.z=delta*Global.movementSpeed;
	if(movementDelta<2):
			set_translation(get_translation()+deltaPoint);
	else:
			set_translation(movementFinishPosition);
			movementDelta = 0;
			movement = false;
	pass

func movement(move_type):
	if isMove == false :
		isMove = true;
		type = types[move_type];
	pass
	
func cameraRotate():
	if(cameraRotate == false):
		var temp = [];
		for i in range(types.size()-1):
			temp.append(types[i]);
		temp.push_front(types[types.size()-1]);
		types = temp;
		currentAngle = cameraAndLight.get_rotation_deg()+Vector3(0,90,0);
		cameraRotate = true;
	pass
