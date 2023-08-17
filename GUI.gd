extends CanvasLayer


func _ready():
	add_to_group("GUI")
	
func _input(event):
	if event.is_action_pressed("Pause"):
		var pause_status = not get_tree().paused
		get_tree().paused = pause_status
		$Pause.visible = pause_status

func update_gui(lives):
	if lives <= 0:
		game_restart()
		
func _on_Play_Again_pressed():
	get_tree().paused = false
	get_tree().reload_current_scene()
	get_tree().call_group("Level_Reset", "player_pos")

func _on_Quit_pressed():
	get_tree().quit()

func game_restart():
	$PopupDialog.show()
	get_tree().paused = true
	if Global.level_number == 1:
		Global.points = 0
	elif Global.level_number == 2:
		Global.points = 8
