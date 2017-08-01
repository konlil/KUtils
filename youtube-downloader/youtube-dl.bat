@REM Usage: youtube-dl-dash.bat https://www.youtube.com/watch?v=xxxxxxxxxxx
@REM Get the URL from the command line
SET YOUTUBE_URL=%1

@REM Set tools
SET YOUTUBEDL_EXE=D:\Tools\youtube-dl.exe
SET FFMPEG_EXE=D:\Tools\ffmpeg.exe

@REM List avaliable formats for viewo and audio
"%YOUTUBEDL_EXE%" --list-formats "%YOUTUBE_URL%"

@REM Set DASH best quality for video and audio
SET /p VIDEO_Q=Input VIDEO format:
SET /p AUDIO_Q=Input AUDIO format:

@REM Get video and audio filename
"%YOUTUBEDL_EXE%" --get-filename -f %VIDEO_Q% "%YOUTUBE_URL%" > youtube-dl-dash-temp.txt
SET /p VIDEO_FILENAME=<youtube-dl-dash-temp.txt
"%YOUTUBEDL_EXE%" --get-filename -f %AUDIO_Q% "%YOUTUBE_URL%" > youtube-dl-dash-temp.txt
SET /p AUDIO_FILENAME=<youtube-dl-dash-temp.txt
del youtube-dl-dash-temp.txt

@REM Download video and audio files
"%YOUTUBEDL_EXE%" -f %VIDEO_Q% "%YOUTUBE_URL%"
"%YOUTUBEDL_EXE%" -f %AUDIO_Q% "%YOUTUBE_URL%"

@REM Recombine video and audio
SET FILEOUT=NEW-%VIDEO_FILENAME%
"%FFMPEG_EXE%" -i "%VIDEO_FILENAME%" -i "%AUDIO_FILENAME%" -acodec copy -vcodec copy -threads 0 "%FILEOUT%"

@REM Clean up
del "%VIDEO_FILENAME%"
del "%AUDIO_FILENAME%"
ren "%FILEOUT%" "%VIDEO_FILENAME%"
