extends Control

func _on_back_button_pressed():
	SceneManager.change_scene("MAIN_GAME")

func _on_main_menu_button_pressed():
	SceneManager.change_scene("MAIN_MENU")
