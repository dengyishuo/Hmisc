translate <- if(!.R. && !under.unix) 
  function(text, old, new, multichar) {
    if(!missing(multichar) && !multichar)
      stop('multichar=F not implemented for this operating system')
    sedit(text, old, new)
  } else if(FALSE && .R.) function(text, old, new, multichar=FALSE) {
    if(multichar) stop('multichar=T not implemented under R')
    k <- chartr(old, new, text)
    if(is.matrix(text)) k <- matrix(k, nrow=nrow(text))
    k
  } else
  function(text, old, new, multichar=FALSE) {
    if(length(old)>1 || (nchar(old)!=nchar(new))) multichar <- TRUE
    if(length(old)>1 && (length(new)>1 & length(new)!=length(old)))
      stop("old and new must have same lengths or new must have 1 element")

    if(.R. && !multichar) k <- chartr(old, new, text)  ## 27aug03
    else {
      if(multichar) command <- paste("sed",paste('-e "s/',old,"/",new,'/g"',
                                                 sep="", collapse=" "))
      else command <- paste("tr \"", old, "\" \"", new, "\"", sep="")
      ##    k <- sys(command, text)  replace with next 2 27aug03
      ## Thanks:   <Sebastian.Weber@aventis.com>
      k <- unlist(lapply(text, function(x, command) {
        sys(paste("echo \"", x, "\" | ", command, sep="")) },
                         command=command))  #  command= 22feb04
      ## added command 26jan04; thanks:<Willi.Weber@aventis.com>
    }
    if(is.matrix(text)) k <- matrix(k, nrow=nrow(text))
    k
  }
