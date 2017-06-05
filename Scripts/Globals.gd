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