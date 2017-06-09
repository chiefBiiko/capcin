# capcin utils

#' Is character vector with number of characters >= 1?
#'
#' @param x R object.
#' @return Logical.
#'
#' @keywords internal
isTruthyChr <- function(x) {
  if (is.character(x) && nchar(x) > 0L) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

#' Splits a string on given character neither enclosed in brackets, 
#' parentheses nor double quotes
#'
#' @param string Character vector of length 1L.
#' @param character Single character to split on.
#' @return Chr vector.
#'
#' @keywords internal
splitOnUnclosedChar <- function(string, char, keep=FALSE) {
  stopifnot(is.character(string), is.character(char), nchar(char) == 1L,
            is.logical(keep))
  # split to single characters
  chars <- strsplit(string, '', fixed=TRUE)[[1L]]
  # setup
  opbr <- 0L        # if opbr is zero we r not in a struct
  opqt <- 2L        # counts double quotes
  nsqt <- list(2L)  # counts nested double quotes
  last.cut <- 0L    # tracks last slice index
  accu <- vector('character')
  # peep through
  for (i in seq(length(chars))) {
    if (chars[i] %in% c('[', '{', '(')) opbr <- opbr + 1L
    if (chars[i] %in% c(']', '}', ')')) opbr <- opbr - 1L
    if (chars[i] == '"') opqt <- opqt + 1L
    if (grepl('\\\\+', chars[i], perl=TRUE) && chars[i + 1L] == '"') {
      if (!chars[i] %in% names(nsqt)) {
        nsqt[[chars[i]]] <- 2L + 1L
      } else if (chars[i] %in% names(nsqt)) {
        nsqt[[chars[i]]] <- nsqt[[chars[i]]] + 1L
      }
    }
    if (chars[i] == char && 
        (opbr == 0L && opqt %% 2L == 0L  && 
         all(unlist(nsqt) %% 2L == 0L))) {
      if (!keep) {
        accu <- append(accu, substr(string, last.cut + 1L, i - 1L))
      } else if (keep) {  # keep split character
        # get pre
        accu <- append(accu, substr(string, last.cut + 1L, i - 1L))
        last.cut <- i - 1L
        # get split character
        accu <- append(accu, substr(string, last.cut + 1L, last.cut + 1L))
      }
      last.cut <- i
    }
  }
  # consume remainder
  if (last.cut < nchar(string))  {
    accu <- append(accu, substr(string, last.cut + 1L, nchar(string)))
  }
  # serve
  return(accu)
}
