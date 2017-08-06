# vlcRecScreen

#' Checks if vlc is available on path
#' 
#' @return logical.
#'
#' @keywords internal
vlcAvailable <- function() grepl('vlc', Sys.getenv('PATH'), TRUE, TRUE)

#' Start a screen recording with vlc media player
#' 
#' @param fname character. Ouput filename without extension.
#' @param fps integer. Frames per second.
#' @param scale double. Scale factor to be applied to output video file.
#' @return integer. Exit code, invisible. \code{127} if OS shell could not be 
#' started. Otherwise exit code of vlc executable: \code{0} for success, 
#' \code{1} for failure.
#' 
#' @details VLC media player must be available on the system and the
#' system's PATH environment variable. This piece of code will neither
#' install VLC media player nor alter your PATH, you need to do this manually.
#' 
#' This func allows saving recordings to disk only, no streaming support. 
#' The video format is mp4 by design rule. Recording audio is not suppported.
#' 
#' @export
vlcRecScreen <- function(fname='rec', scale=1., fps=15L) {
  stopifnot(is.character(fname), length(fname) == 1L, nchar(fname) > 0L,
            is.numeric(fps), length(fps) == 1L, fps > 0L, fps %% 1L == 0L, 
            is.numeric(scale), length(scale) == 1L, scale >= 0L)
  # check
  if (!vlcAvailable()) {
    stop('Please install VLC media player and add its ',
         'home directory to your system\'s PATH\n',
         '4 downloads: https://www.videolan.org/vlc/')
  }
  # shell stuff
  OS_SHELL <- ifelse(grepl('win', .Platform$OS.type, TRUE, TRUE), 
                     'cmd.exe', 'sh')
  cmdline <- sprintf(paste0('vlc screen:// -I rc ',
                            ':sout=#transcode{vcodec=h264,vb=800,',
                            'fps=%d,scale=%f}',
                            ':std{access=file,dst=%s.mp4}'), 
                     fps, scale, fname)
  # info
  message('Recording...\nType "quit" in vlc\'s command line to stop recording')
  # start recording
  return(system2(command=OS_SHELL, input=cmdline, stdout=FALSE, stderr=FALSE))
}
