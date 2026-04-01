class_name AudioLoader extends AudioStreamPlayer

var should_play = false

func get_should_play():
	return should_play

func load_audio(load_filepath, file_ext, result_text):
	var new_result = {
		SpinResultGenerator.FILETYPE : SpinResultGenerator.AUDIO,
		SpinResultGenerator.FILEPATH: load_filepath,
		SpinResultGenerator.FILEEXT: file_ext,
		SpinResultGenerator.TEXT: result_text
	}
	
	var file_audio_stream
	
	if(file_ext == "ogg"):
		file_audio_stream = AudioStreamOggVorbis.load_from_file(load_filepath)
	elif(file_ext == "mp3"):
		file_audio_stream = AudioStreamMP3.load_from_file(load_filepath)
	elif(file_ext == "wav"):
		file_audio_stream = AudioStreamWAV.load_from_file(load_filepath)
		
	if (file_audio_stream == null):
		return null
		
	return new_result

func load_audio_preview(file_data):
	var audio_ext = file_data[SpinResultGenerator.FILEEXT]
	var audio_filepath = file_data[SpinResultGenerator.FILEPATH]
	var file_audio_stream
	
	if(audio_ext == "ogg"):
		file_audio_stream = AudioStreamOggVorbis.new()
		file_audio_stream.set_loop(true)
		file_audio_stream = AudioStreamOggVorbis.load_from_file(audio_filepath)
	elif(audio_ext == "mp3"):
		file_audio_stream = AudioStreamMP3.new()
		file_audio_stream.set_loop(true)
		file_audio_stream = AudioStreamMP3.load_from_file(audio_filepath)
	elif(audio_ext == "wav"):
		file_audio_stream = AudioStreamWAV.new()
		file_audio_stream.set_loop_mode(AudioStreamWAV.LOOP_FORWARD)
		file_audio_stream = AudioStreamWAV.load_from_file(audio_filepath)
		#No, I don't know why WAV doesn't have a default loop like the other two either.
	
	set_stream(file_audio_stream)
	
	should_play = true
	play(0.0)
	
