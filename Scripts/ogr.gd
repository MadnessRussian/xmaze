extends KinematicBody



var currentPos = Vector2(0,0);
var nextPos  = Vector2(0,0);
var deltaPoint = Vector3(0,0,0);


var type = 0;
var oldtype;
var deltasumm = 0;
var deltaTime = 0.4;
var movement = false;
#дельта движения
var movementDelta = 0;
#скорость движения

#окончательная позиция куда нужно попасть
var movementFinishPosition;

var ugol=0;

func _ready():
	randomize();
	
	#случайно выбираем позицию и ставим персонажа
	var randRange = round(rand_range(0,Global.map.size()-1));
	set_translation(Vector3(-Global.map.size()+randRange*2,0,-Global.map.size()+randRange*2))
	currentPos = Vector2(randRange,randRange);

	set_process(true);
	pass
func _process(delta):
	#счетчик действий. не можем сделать что либо чаще утановленного промежутка времени
	if(deltasumm<deltaTime):
		deltasumm+=delta
	#запуск движения
	if(movement == false && deltasumm>deltaTime/2 ):
		deltasumm = 0;
		#проверяем. свободен ли путь и не обратно ли мы идем
		if (Global.map[currentPos.x][currentPos.y].getDirections()[type] ==0 &&  (oldtype!=type || ugol==1)):
			#запоминаем откуда пришли
			if(type==0): oldtype = 2;
			if(type==1): oldtype = 3;
			if(type==2): oldtype = 0;
			if(type==3): oldtype = 1;
			
			currentPos+=Global.moveDirs[type];
			nextPos = Vector3(Global.moveDirs[type].x*2,0,Global.moveDirs[type].y*2)
			movementFinishPosition = get_translation() + nextPos;
			deltaPoint = Vector3(0,0,0);
			movement = true;
		else:
			#метод для определения тупиков.
			ugol = 0;
			for point in Global.map[currentPos.x][currentPos.y].getDirections():
				if(point == 0):ugol+=1;
			randomize();
			type = round(rand_range(0,Global.types.size()-1));
	if(movement == true):
		move(delta)
	pass
	
func move(delta):
	movementDelta+=delta*Global.movementSpeed;
	if(nextPos.x<0):
		deltaPoint.x=-delta*Global.movementSpeed;
	if(nextPos.x>0):
		deltaPoint.x=delta*Global.movementSpeed;
	if(nextPos.z<0):
		deltaPoint.z=-delta*Global.movementSpeed;
	if(nextPos.z>0):
		deltaPoint.z=delta*Global.movementSpeed;
	if(movementDelta<2):
			set_translation(get_translation()+deltaPoint);
	else:
			set_translation(movementFinishPosition);
			movementDelta = 0;
			movement = false;
	pass