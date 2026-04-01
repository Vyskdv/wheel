class_name SpriteLoader extends TextureRect

func load_sprite(load_filepath, file_ext, result_text):
	var new_result = {
		SpinResultGenerator.FILETYPE : SpinResultGenerator.IMAGE,
		SpinResultGenerator.FILEPATH: load_filepath,
		SpinResultGenerator.FILEEXT: file_ext,
		SpinResultGenerator.TEXT: result_text
	}
	
	var new_image = Image.load_from_file(load_filepath)
	var new_texture = ImageTexture.create_from_image(new_image)
	
	if (new_texture == null):
		return null
		
	return new_result

func load_sprite_preview(file_data):
	var img = Image.load_from_file(file_data[SpinResultGenerator.FILEPATH])
	var img_texture = ImageTexture.create_from_image(img)
	set_texture(img_texture)
	show()
