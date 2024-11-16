extends CharacterBody2D

var timeHolding = 0.0
var lastPosY
var animationTimer = 0.0

func _ready():
	velocity = Vector2(100, 0)
	lastPosY = position.y

func _process(delta):
	if(get_parent().get_parent().isInitialized == true):
		if(position.y <= -390):
			if(Input.is_action_pressed("Space")):
				velocity.y = 0
			else:
				velocity.y = lerp(100, 250, 0.55)
				
		else:
			if(get_slide_collision_count() > 0):
				get_parent().get_parent().isDead = true
			if(Input.is_action_pressed("Space")):
				if(timeHolding < 0.15):
					velocity.y = -350
				else:
					velocity.y = lerp(100, 400, 0.55)
				timeHolding += delta
			elif(!Input.is_action_just_pressed("Space")):
				velocity.y = lerp(100, 250, 0.55)
				timeHolding = 0.0
		move_and_slide()
		if(animationTimer >= 0.3):
			checkMovement()
			animationTimer = 0.0
		else:
			animationTimer += delta
		
func calculateAnimation(state):
	if(state == "up"):
		rotation_degrees = lerp(0, -25, 2)
	elif(state == "down"):
		rotation_degrees = lerp(0, 25, 2)
		
func checkMovement():
	if(position.y < lastPosY):
		calculateAnimation("up")
	else:
		calculateAnimation("down")
	lastPosY = position.y
