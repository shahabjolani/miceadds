
########################################################################
# several variants for getting system time
systime <- function(){
    s1 <- paste(Sys.time())
    res <- c( s1 , substring( s1 , 1,10) )
    res <- c(res , gsub("-","",res[2] ) )
    s1a <- substring( s1 , 1 , 16 )
    s1a <- gsub( ":" , "" , gsub( " " , "_" , s1a ) )
    res <- c(res , s1a )
    res <- c(res , paste0( substring( s1a , 1,13) , "00"  ) )
    return(res)
        }
########################################################################


.attach.environment <- function( res , envir ){
	CC <- length(res)
	for (cc in 1:CC){
		assign( names(res)[cc] , res[[cc]] , envir=envir )		
					}
					}