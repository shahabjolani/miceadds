
filename_split <- function( file_name , file_sep = "__" ,
		file_ext = ".")
{		
	file <- file_name
	v1 <- base::strsplit( file , split= file_ext , fixed=TRUE )[[1]]
	
	N1 <- base::length(v1)
	v1a <- base::paste0( v1[ 1:(N1-1) ] , collapse= file_ext )
	v1b <- v1[N1]
	v1 <- base::c( v1a, v1b )
	
	v2 <- base::strsplit( v1 , split = file_sep , fixed=TRUE )[[1]]
	N2 <- base::length(v2)
	v2a <- base::paste0( v2[ 1:(N2-1) ] , collapse= file_sep )
	v2b <- v2[N2]
	res <- base::list( "file_name" = file , "stem" = v2a , "suffix" = v2b , 
				"ext" = v1[2] )
	res$main <- base::paste0( res$stem , file_ext , res$ext )
	base::return(res)
}
	