# capcin

# TODO: -before playing captures make sure to pretty code with a formatr
#       -simple static analysis - 2 make sure commmands are split correctly
#       -layout data structure for transmission

setup <- function() {
  
}

capture <- function(name) {
  stopifnot(isTruthyChr(name))
  # setup
  on.exit(try(unlink('csh.Rhistory')))
  # regex 4 simple static analysis - matches common operators when line trailr
  rexop <- paste0('(?:(?:<?<-)|(?:==?)|(?:&&?)|(?:\\|\\|?)|(?:%.*%?)|', 
                  '\\+|-|/|(?:\\*\\*?)|\\<|\\>|\\^)\\s*\\n$')
  # write current session's history (csh) to disc
  savehistory('csh.Rhistory')
  # read back into memory
  rl <- readLines('csh.Rhistory', warn=FALSE)
  # collapse lines
  csh <- paste0(rl, collapse='\n')
### format commands for safer split - FAILS with typos in command - unsafe !!!
##fmt <- formatR::tidy_source(text=csh, indent=2)$text.tidy
  # separate commands thru split on unclosed '\n'
  spl <- splitOnUnclosedChar(csh, '\n', keep=FALSE)
  # TODO: static analysis
  print(any(grepl(rexop, spl, perl=TRUE)))
  # stringify to JSON
  xyz <- jsonlite::toJSON(spl)
  xyz
}

push <- function() {
  
}

pull <- function() {
  
}

play <- function() {
  
}
