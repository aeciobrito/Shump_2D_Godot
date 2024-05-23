extends Area2D

@export var speed = 150
@export var cooldown = 0.25
@export var bullet_scene: PackedScene
var can_shoot = true

@onready var screensize = get_viewport_rect().size

func  _ready():
	start()

func start():
	position = Vector2(screensize.x / 2, screensize.y -128)
	$GunCooldown.wait_time = cooldown

func _process(delta):
	var input = Input.get_vector("left","right","up","down")
	
	animation_handler(input)
		
	position += input.normalized() * speed * delta
	position = position.clamp(Vector2(8, 8), screensize - Vector2(8, 8))
	
	if Input.is_action_just_pressed("shoot"):
		shoot()

func shoot():
	if not can_shoot:
		return
	can_shoot = false
	$GunCooldown.start()
	var bullet = bullet_scene.instantiate()
	get_tree().root.add_child(bullet)
	bullet.start(position + Vector2(0, -9))

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

func _on_gun_cooldown_timeout():
	can_shoot = true
