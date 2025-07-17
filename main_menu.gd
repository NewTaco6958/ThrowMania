extends Control

func _on_start_button_pressed():
	SceneManager.change_scene("MAIN_GAME")

func _on_exit_button_pressed():
	SceneManager.quit_game()
