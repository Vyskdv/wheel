class_name VideoLoader extends VideoStreamPlayer

@onready var GREENSCREEN_SHADER = preload("res://Assets/Shader/GreenScreenShader.gdshader")

func load_video(load_filepath, file_ext, result_text):
	var new_result = {
		SpinResultGenerator.FILETYPE : SpinResultGenerator.VIDEO,
		SpinResultGenerator.FILEPATH: load_filepath,
		SpinResultGenerator.FILEEXT: file_ext,
		SpinResultGenerator.TEXT: result_text,
		SpinResultGenerator.COLOR: SpinResultGenerator.NOGREENSCREEN,
		SpinResultGenerator.PICKUP: SpinResultGenerator.DEFAULTGREENSCREENVALUE,
		SpinResultGenerator.FADE: SpinResultGenerator.DEFAULTGREENSCREENVALUE
	}
	
	return new_result

#Unfortunately, I can't really adjust the video player very much.
#It's the size that it is, and that's it.
#I suggest making it 480p? Maybe 720p. I haven't done much testing, it's not like
#I have a lot of videos laying around.
func load_video_preview(file_data):
	var video_stream = VideoStreamTheora.new()
	var color = SpinResultGenerator.parse_color_vector_string(file_data[SpinResultGenerator.COLOR])
	
	if (color != SpinResultGenerator.NOGREENSCREEN):
		material.set_shader(GREENSCREEN_SHADER)
		material.set(SpinResultGenerator.CHROMA_COLOR, color)
		material.set(SpinResultGenerator.PICKUP_RANGE, file_data[SpinResultGenerator.PICKUP])
		material.set(SpinResultGenerator.FADE_AMOUNT, file_data[SpinResultGenerator.FADE])
	else:
		material.set_shader(null)
	
	video_stream.file = file_data[SpinResultGenerator.FILEPATH]
	stream = video_stream
	show()
	play()
