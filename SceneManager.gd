extends Node

const SCENES = {
	MAIN_MENU = "res://main_menu.tscn",
	MAIN_GAME = "res://main.tscn",
	SETTINGS = "res://settings.tscn"
}

func change_scene(scene_key: String):
	if scene_key in SCENES:
		get_tree().change_scene_to_file(SCENES[scene_key])

func quit_game():
	get_tree().quit()
