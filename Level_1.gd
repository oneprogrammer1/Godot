extends Node2D

var level = Global.level_number

func _ready():
	add_to_group("Level_Reset")


func _process(delta):
	change_Level()
	set_Levels()

func change_Level():
	if level == 1:
		if Global.points == 7:
			level = 2
			Global.level_number = 2
			print("Level 2 opened!")
			print(Global.level_number)
			

func set_Levels():
	
	var collision_shape = get_node("Level_01_02_divider/CollisionShape2D")
	
	if level == 1:
		$Levels/Level01.visible = true
		$Levels/Level02.visible = false
		$L_01_Jewels.visible = true
		$L_02_Jewels.visible = false
		
		collision_shape.set_deferred("disabled", true)

		
	elif level == 2:
		$Levels/Level01.visible = true
		$Levels/Level02.visible = true
		$L_01_Jewels.visible = false
		$L_02_Jewels.visible = true
		
		
		collision_shape.set_deferred("disabled", false)

func player_pos():
	if Global.level_number == 1:
		$Player.position = $Level_01_Start_Pos.position
	if Global.level_number == 2:
		$Player.position = $Level_02_Start_Pos.position
