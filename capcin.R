# capcin

# TODO: -rewrite splitOnUnclosedChar 2 splitOnUnclosedDuo [\n] and use it!
#       -before playing captures make sure to pretty code with a formatr

setup <- function() {
  
}

capture <- function(name) {
  stopifnot(is.character(name), nchar(name) > 0L)
  # setup
  on.exit({try(unlink('csh.Rhistory'))})
  # write current session's history (csh) to disc
  savehistory('csh.Rhistory')
  # read back into memory
  rl <- readLines('csh.Rhistory', warn=FALSE)
  # check for validity
  if (any(grepl('§', rl, perl=TRUE))) stop('u used a reserved character "§"')
  # collapse lines with special delimiter
  csh <- paste0(rl, collapse='§')
  # separate commands thru split on unclosed "§"
  spl <- splitOnUnclosedChar(csh, '§', keep=FALSE)
  # clean splits
  cln <- gsub('§', '\n', spl, perl=TRUE)
  xyz <- paste0(cln, collapse='\n')

##csh_json <- jsonlite::toJSON(readLines('csh.Rhistory', warn=FALSE))

  xyz
}

push <- function() {
  
}


pull <- function() {
  
}

play <- function() {
  
}
