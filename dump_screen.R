# dump_screen

vlcAvailable <- function() {
  return(ifelse(grepl('vlc', Sys.getenv('PATH'), TRUE, TRUE), TRUE, FALSE))
}

dumpScreen <- function() {
  if (!vlcAvailable()) {
    stop('Please install VLC media player and add its ',
         'home directory to your system\'s PATH\n',
         '4 downloads: https://www.videolan.org/vlc/')
  }
  system2(command=ifelse(grepl('win', .Platform$OS.type, TRUE, TRUE), 
                         'cmd.exe', 'sh'), 
          input='vlc version', 
          wait=FALSE)
}
