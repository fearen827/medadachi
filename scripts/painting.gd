extends Node3D

@onready var area = $Plane_001/Area3D
@onready var inspect_camera = $InspectionCamera

var player
var player_in_range = false
var inspecting = false


func _ready():
	area.body_entered.connect(_on_body_entered)
	area.body_exited.connect(_on_body_exited)


func _process(delta):
	if player_in_range and !inspecting:
		if Input.is_action_just_pressed("interact"):
			start_inspection()


func _input(event):
	if inspecting and event.is_action_pressed("ui_cancel"):
		stop_inspection()


func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		print("Press E to Inspect")


func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = true
		player = body

func start_inspection():
	if player == null:
		print("Player not detected!")
		return
	inspecting = true
	player.visible = false   # 👈 hide bean
	inspect_camera.current = true
	get_tree().paused = true
	inspect_camera.process_mode = Node.PROCESS_MODE_ALWAYS
	
	
func stop_inspection():
	inspecting = false
	player.visible = true   # 👈 show again
	inspect_camera.current = false
	get_tree().paused = false
