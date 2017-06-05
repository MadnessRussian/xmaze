extends Node

const size = 15;

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

enum CellState{
	Open,
	Close
}


func generate():
	level = [];
	for i in range(size):
		var line = []
		for j in range(size):
			line.append(Global.Cell.new(i,j,false));
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
	pass 


