extends Node

var buttonSize = Vector2(144,40) setget ,getButtonSize
var screenSize = Vector2(800,600) setget ,getScreenSize
var globalSize = Vector2(Globals.get("display/width"),Globals.get("display/height")) setget ,getGlobalSize
var scaleParam = Vector2(globalSize.x/screenSize.x, 
						 globalSize.y/screenSize.y) setget ,getScaleParam


func ready():
	
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

enum CellState{
	Open,
	Close
}

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