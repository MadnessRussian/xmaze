extends Node

#глобальный класс новый

var buttonSize = Vector2(144,40) setget ,getButtonSize
var screenSize = Vector2(800,600) setget ,getScreenSize
var globalSize = Vector2(Globals.get("display/width"),Globals.get("display/height")) setget ,getGlobalSize
var scaleParam = Vector2(globalSize.x/screenSize.x, 
						 globalSize.y/screenSize.y) setget ,getScaleParam
var playerPos = Vector2(0,0) setget  setPlayerPos,getPlayerPos

var map = [] setget setMap,getMap



var movementSpeed = 5;
#направления движений
var moveDirs = [
				Vector2(0,-1),
				Vector2(1,0),
				Vector2(0,1),
				Vector2(-1,0)
				]
#типы движений(по часовой стрелке) верх-вправо-вниз-влево
var types = [0,1,2,3];


func ready():
	#берем разрешение по экрану. 
	globalSize =  get_viewport().get_rect().size;
	pass
	
func getMap():
	return map;
	pass
func setMap(newmap):
	map = newmap;
	pass
func getButtonSize():
	return buttonSize;
	pass
func getScreenSize():
	return screenSize;
	pass
func getGlobalSize():
	return globalSize;
	pass
func getScaleParam():
	return scaleParam;
	pass
	
func getPlayerPos():
	return playerPos;
	pass
func setPlayerPos(pos):
	playerPos = pos;
	pass


#класс для тайла лабиринта
class Cell:
	var x = 0;
	var y = 0;
	#флаги открытых/закрытых направлений клетки. по часовой стрелке начиная с верхней
	var directions = [1,1,1,1] setget ,getDirections;
	
	var visited ;
	
	func _init(objx,objy,visit):
		x = objx
		y = objy
		visited = visit;
		pass
	func getDirections():
		return directions;
		pass
	func getType():
		var mytype = 0;
		var newtypes = [
			[0,0,1,0], #b
			[0,0,1,1], #bl
			[1,0,1,1], #blt
			[0,1,1,0], #rb
			[0,0,0,0], #empty 
			[0,0,0,1], #l
			[1,0,0,0], #top
			[1,0,1,0], #tb
			[1,0,0,1], #lt
			[1,1,0,0], #tr
			[1,1,1,0], #trb
			[0,1,0,0], #r
			[0,1,1,1], #rbl
			[0,1,0,1], #rl
			[1,1,0,1] #ltr
		]
		for i in range(newtypes.size()):
			if(newtypes[i] == directions):
				mytype = i;
		return mytype;
		
		pass