extends Node2D

@onready var bird = preload("res://scenes/Bird.tscn")

@onready var scoreNode = get_node("cameraplayer/scoreNum")
@onready var startLabel = get_node("start")
@onready var scoreLabel = get_node("cameraplayer/Score")
@onready var scoreNum = get_node("cameraplayer/scoreNum")
@onready var camera = get_node("cameraplayer")

@onready var defeatTxt = get_node("cameraplayer/defeatTxt")
@onready var restartBtn = get_node("cameraplayer/restartBtn")
@onready var menuBtn = get_node("cameraplayer/menuBtn")

@onready var caneLow = preload("res://scenes/Cans/CanLow.tscn")
@onready var caneMid = preload("res://scenes/Cans/CanMid.tscn")
@onready var caneHigh = preload("res://scenes/Cans/CanHigh.tscn")

@export var isInitialized = false
@export var isDead = false
@export var player : Node2D
@export var score = 0

var caneTemplates
var lastCanePos
var generationTimer = 0.0
var deleteTimer = 0.0
var Canes : Array
var canesIndex = 0

func _ready():
	initGame()

func _process(delta):
	scoreNum.text = String.num(score)
	if(isInitialized == false && isDead == false):
		if(Input.is_action_just_pressed("Space")):
			isInitialized = true
			startLabel.visible = false
			scoreLabel.visible = true
			scoreNode.visible = true
	if(isInitialized):
		if(isDead):
			isInitialized = false
			defeatTxt.visible = true
			restartBtn.visible = true
			menuBtn.visible = true
		else:
			camera.position.x += (player.position.x)*delta
			if(deleteTimer >= 6.0):
				var cane = Canes[canesIndex]
				cane.queue_free()
				Canes.remove_at(canesIndex)
				deleteTimer = 0.0
				canesIndex += 1
			else:
				deleteTimer += delta
				
			if(generationTimer >= 2.0):
				generateCane()
				generationTimer = 0.0
			else:
				generationTimer += delta
		
func initGame():
	var birdInstance = bird.instantiate()
	birdInstance.position = Vector2(100, 400)
	add_child(birdInstance)
	player = birdInstance
	caneTemplates = [caneLow, caneMid, caneHigh]
	
	for n in 2:
		var randomCane = randi() % 3
		if(n == 0):
			var cane = caneTemplates[randomCane]
			var ins = cane.instantiate()
			ins.position = Vector2(325, 224)
			add_child(ins)
			Canes.append(ins)
		else:
			var cane = caneTemplates[randomCane]
			var ins = cane.instantiate()
			ins.position = Vector2(585, 224)
			add_child(ins)
			Canes.append(ins)
			lastCanePos = ins.position.x


func _on_menu_btn_pressed():
	get_tree().change_scene_to_file(Menu.scene_file_path)


func _on_restart_btn_pressed():
	get_tree().reload_current_scene()

func generateCane():
	var randomCane = randi() % 3
	var cane = caneTemplates[randomCane]
	var ins = cane.instantiate()
	ins.position = Vector2(lastCanePos+260, 224)
	add_child(ins)
	lastCanePos = ins.position.x
	Canes.append(ins)
