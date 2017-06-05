extends Node

const size = 15;
enum CellState{
	Open,
	Close
}

var endX = 18;
var endy = 18;

var level  = [];


func _ready():
	generate();
	pass
	
func drawToDisplay(array):
		var map = [];
		for i in range(size):
			var line = []
			for j in range(size):
				var tile = getElement(array[i][j].getType())
				tile.set_translation(Vector3(-size*2/2+2*i,0,-size*2/2+2*j))
				line.append(tile);
			map.append(line)
		pass

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

	
class Cell:
	var x = 0;
	var y = 0;
	var left = CellState;
	var right = CellState;
	var top = CellState;
	var bottom = CellState;
	
	var visited ;
	
	func _init(objx,objy,visit):
		x = objx
		y = objy
		visited = visit;
		left = Close;
		right = Close;
		top = Close;
		bottom = Close;
		pass
	
	func getType():

		var type;
		if(bottom == Close && top == Open && right == Open && left == Open):
			type = 0;
		if(bottom == Close && top == Open && right == Open && left == Close):
			type = 1;
		if(bottom == Close && top == Close && right == Open && left == Close):
			type = 2;
		if(bottom == Close && top == Open && right == Close && left == Open):
			type = 3;
		if(bottom == Open && top == Open && right == Open && left == Open):
			type = 4;
		if(bottom == Open && top == Open  && right == Open && left == Close):
			type = 5;
		if(bottom == Open && top == Close && right == Open && left == Open):
			type = 6;
		if(bottom == Close && top == Close && right == Open && left == Open):
			type = 7;
		if(bottom == Open && top == Close && right == Open && left == Close):
			type = 8;
		if(bottom == Open && top == Close && right == Close && left == Open):
			type = 9;
		if(bottom == Close && top == Close && right == Close && left == Open):
			type = 10;
		if(bottom == Open && top == Open && right == Close && left == Open):
			type = 11;
		if(bottom == Close && top == Open && right == Close && left == Close):
			type = 12;
		if(bottom == Open && top == Open && right == Close && left == Close):
			type = 13;
		if(bottom == Open && top == Close && right == Close && left == Close):
			type = 14;
		return type;
		
		pass

func generate():
	level = [];
	var total = 0;
	for i in range(size):
		var line = []
		for j in range(size):
			line.append(Cell.new(i,j,false));
			total+=1;
		level.append(line)
	randomize();
	var startx = round(rand_range(0,size-1));
	var starty = round(rand_range(0,size-1));
	level[startx][starty].visited = true;
	var map = [];
	map.append(level[startx][starty])
	while(!map.empty()):
		var currentCell = map[map.size()-1];
		var nextstep = [];
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
			var next = nextstep[round(rand_range(0,nextstep.size()-1))];
			
			if(next.x !=currentCell.x):
				if (currentCell.x - next.x > 0):           
					level[currentCell.x][currentCell.y].left = Open
					level[next.x][next.y].right = Open
				else:
					level[currentCell.x][currentCell.y].right = Open;
					level[next.x][next.y].left = Open;
			if(next.y !=currentCell.y):
				if (currentCell.y - next.y > 0):           
					level[currentCell.x][currentCell.y].top = Open
					level[next.x][next.y].bottom = Open
				else:
					level[currentCell.x][currentCell.y].bottom = Open;
					level[next.x][next.y].top = Open;
			next.visited = true;
			level[next.x][next.y].visited = true;
			map.append(next);
		else:
			map.remove(map.size()-1)
	drawToDisplay(level)
	pass

func _on_Button_pressed():
	var enemies = get_tree().get_nodes_in_group("level")
	for enemy in enemies:
    	enemy.queue_free()
	generate()
	pass # replace with function body


