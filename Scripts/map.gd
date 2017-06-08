extends Node

const size = 15;

var level  = [];
var map = [];

func _ready():
	generate();
	pass
	
func drawToDisplay(array):
		map = [];
		for i in range(size):
			var line = []
			for j in range(size):
				var tile = getElement(array[i][j].getType())
				tile.set_translation(Vector3(-size+i*2,0,-size+j*2))
				line.append(tile);
			map.append(line)
		var player =  get_node("player");
		player.set_translation(map[8][8].get_translation())
		Global.setPlayerPos(Vector2(8,8));
		pass
#метод обработки типа элемента для его отображения
func getElement(type):
	var element
	
	var urlsToTiles =[
	"res://Resources/tugol.tscn",
	"res://Resources/ugol.tscn",
	"res://Resources/tupik.tscn",
	"res://Resources/ugol.tscn",
	"res://Resources/center.tscn",
	"res://Resources/tugol.tscn",
	"res://Resources/tugol.tscn",
	"res://Resources/tonel.tscn",
	"res://Resources/ugol.tscn",
	"res://Resources/ugol.tscn",
	"res://Resources/tupik.tscn",
	"res://Resources/tugol.tscn",
	"res://Resources/tupik.tscn",
	"res://Resources/tonel.tscn",
	"res://Resources/tupik.tscn"
	];
	var tilesRotation = [
	Vector3(0,90,0),
	Vector3(0,90,0),
	Vector3(0,0,0),
	Vector3(0,180,0),
	Vector3(0,0,0),
	Vector3(0,0,0),
	Vector3(0,-90,0),
	Vector3(0,0,0),
	Vector3(0,0,0),
	Vector3(0,-90,0),
	Vector3(0,180,0),
	Vector3(0,180,0),
	Vector3(0,90,0),
	Vector3(0,90,0),
	Vector3(0,-90,0)
	];
	
	element = load(urlsToTiles[type]).instance();
	element.set_rotation_deg(tilesRotation[type])
	element.add_to_group("level")
	add_child(element)
	return element;
	pass

#основной метод генерации
func generate():
	level = [];
	#создаем массив с пустыми обьектами
	for i in range(size):
		var line = []
		for j in range(size):
			line.append(Global.Cell.new(i,j,false));
		level.append(line)
	randomize();
	# выбираем случайную точку и отмечаем как помеченую
	var startx = round(rand_range(0,size-1));
	var starty = round(rand_range(0,size-1));
	level[startx][starty].visited = true;
	var map = [];
	#map -  основной массив. вносим стартовую клетку
	map.append(level[startx][starty])
	while(!map.empty()):
		#выбираем клетку из открытого списка
		var currentCell = map[map.size()-1];
		var nextstep = [];
		#создаем список соседей и добавляем близжайших
		if (currentCell.x > 0 && (level[currentCell.x - 1][currentCell.y].visited  == false)):
		           nextstep.append(level[currentCell.x - 1][currentCell.y]);
		if (currentCell.x < size-1 && (level[currentCell.x + 1][currentCell.y].visited  == false)):
		           nextstep.append(level[currentCell.x + 1][currentCell.y]);
		if (currentCell.y > 0 && (level[currentCell.x ][currentCell.y-1].visited  == false)):
		           nextstep.append(level[currentCell.x][currentCell.y-1]);
		if (currentCell.y < size-1 && (level[currentCell.x][currentCell.y+1].visited  == false)):
		           nextstep.append(level[currentCell.x ][currentCell.y+1]);
		if(!nextstep.empty()):
			randomize();
			#для следующего шага выбираем случайную
			var next = nextstep[round(rand_range(0,nextstep.size()-1))];
			#открываем путь из прошлой ячейки
			if(next.x !=currentCell.x):
				if (currentCell.x - next.x > 0):           
					level[currentCell.x][currentCell.y].directions[3] = 0
					level[next.x][next.y].directions[1] = 0
				else:
					level[currentCell.x][currentCell.y].directions[1] = 0;
					level[next.x][next.y].directions[3] = 0;
			if(next.y !=currentCell.y):
				if (currentCell.y - next.y > 0):           
					level[currentCell.x][currentCell.y].directions[0] = 0
					level[next.x][next.y].directions[2] = 0
				else:
					level[currentCell.x][currentCell.y].directions[2] = 0;
					level[next.x][next.y].directions[0] = 0;
			#ставим необходимые флаги что мы тут были и добавляем в открытый список как узел
			next.visited = true;
			level[next.x][next.y].visited = true;
			map.append(next);
		else:
			#если соседей нет. идем назад по открытому списку к свободному узлу
			map.remove(map.size()-1)
	drawToDisplay(level)
	pass

func _on_Button_pressed():
	var enemies = get_tree().get_nodes_in_group("level")
	for enemy in enemies:
    	enemy.queue_free()
	generate()
	pass 


