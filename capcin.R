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
  rexop <- paste0('((?:<?<-)|(?:==?)|(?:&&?)|(?:\\|\\|?)|(?:%.*%?)|', 
                  '\\+|-|/|(?:\\*\\*?)|\\!|\\<|\\>|\\^)\\s*(?:\\n|$)')
  chkop <- paste0('((?:<?<-)|(?:==?)|(?:&&?)|(?:\\|\\|?)|(?:%.*%?)|', 
                  '\\+|-|/|(?:\\*\\*?)|\\!|\\<|\\>|\\^)\\s*$')
  # write current session's history (csh) to disc
  savehistory('csh.Rhistory')
  # read back into memory
  rl <- readLines('csh.Rhistory', warn=FALSE)
  # collapse lines
  csh <- paste0(rl, collapse='\n')
##return(csh)
### format commands for safer split - FAILS with typos in command - unsafe !!!
##fmt <- formatR::tidy_source(text=csh, indent=2)$text.tidy
  # separate commands thru split on unclosed '\n'
  spl <- splitOnUnclosedChar(csh, '\n', keep=FALSE)
  # TODO: NO: static analysis - check 4 trailing ops except 4 brackets
  #       DO: warn people !!!
  print(any(grepl(rexop, spl, perl=TRUE)))
  
  
  return(spl)
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

#  sta <- octostep::octostep(as.list(spl), function(pre, cur, nxt) {
#if (grepl(rexop, cur, perl=TRUE) && !is.null(nxt)) {
#  paste0(cur, nxt)
#} else if (!is.null(pre) &&
#           grepl(rexop, pre, perl=TRUE) &&
#           grepl(paste0(cur, '$'), pre, fixed=TRUE)) {
#  ''
#} else {
#  cur
#}
#}, transform.previous=TRUE)

