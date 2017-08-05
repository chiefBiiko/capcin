# vlcRecScreen

#' Checks if vlc is available on path
#' 
#' @return logical.
#'
#' @keywords internal
vlcAvailable <- function() {
  return(grepl('vlc', Sys.getenv('PATH'), TRUE, TRUE))
}

#' Start a screen recording with vlc media player
#' 
#' @param fname character. Ouput filename without extension.
#' @param fps integer. Frames per second.
#' @param scale double. Scale factor to be applied to output video file.
#' @return integer. Exit code, invisible. \code{127} if OS shell could not be 
#' started. Otherwise exit code of vlc executable: \code{0} for success, \code{1} for 
#' failure.
#' 
#' @export
vlcRecScreen <- function(fname='rec', fps=30L, scale=1.) {
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
  message('Type "quit" within vlc\'s command line to stop recording\n',
          'Note: the last seconds of this recording will be cutoff by vlc\n', 
          'so make sure not to quit right after you are done showcasing\n',
          'rather hang tight for another ~20 seconds at the end, then quit!')
  # start recording
  return(system2(command=OS_SHELL, stdout=FALSE, stderr=FALSE, input=cmdline, 
                 wait=TRUE, minimized=FALSE, invisible=TRUE))
}
