extends Area2D

@export var speed = 150

@onready var screensize = get_viewport_rect().size

func _process(delta):
	var input = Input.get_vector("left","right","up","down")
	
	animation_handler(input)
		
	position += input.normalized() * speed * delta
	position = position.clamp(Vector2(8, 8), screensize - Vector2(8, 8))

func animation_handler(input):
	if input.x > 0:
		$Ship.frame = 2
		$Ship/Boosters.animation  = "right"
	elif  input.x < 0:
		$Ship.frame = 0
		$Ship/Boosters.animation  = "left"
	else:
		$Ship.frame = 1
		$Ship/Boosters.animation = "forward"
