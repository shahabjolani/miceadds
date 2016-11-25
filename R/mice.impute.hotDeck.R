mice.impute.hotDeck <- function (y, ry, x, donors=5 , 
	method = "Mahalanobis" , ...)
{
	
	N1 <- base::sum(ry)
	N0 <- base::sum(!ry)
	#*** center x variables
	x <- ma.scale2(x)
	ry2 <- sort(base::sample( which(ry) , N1 , replace = TRUE ))
	X1 <- x[ ry2 , ,drop=FALSE]
	X0 <- x[ !ry , , drop=FALSE]
	NV <- base::ncol(X1)
	#*** create distance matrix
	distmat <- base::matrix( NA , nrow=N0 , ncol=N1 )
	#--- hot deck using Mahalanobis distance
	if (method=="Mahalanobis"){
		if (NV>1){
			W <- base::solve( stats::cov(X1) )
		} else {
			W <- matrix(1 , nrow=1,ncol=1)
		}
		for (nn in 1:N0){
			X0_nn <- base::matrix( X0[nn,] , nrow=N1 , ncol=NV , byrow=TRUE )
			Xdist_nn <- X0_nn - X1
			d1 <- Xdist_nn %*% W
			distmat[nn,] <- base::rowSums( d1 * Xdist_nn )
		}
	}
	#--- hot deck using weights from correlations
	if (method %in% base::c("cor","lm") ){
		if (method == "cor"){
			W0 <- base::as.vector( stats::cor( y[ry2] , X1 ) )
		}
		if (method == "lm"){
			mod1 <- stats::lm( y[ry2] ~ X1 )
			W0 <- coef(mod1)[-1]
		}
		W0 <- base::matrix( base::abs(W0) , nrow=N1 , ncol=NV, byrow=TRUE)
		for (nn in 1:N0){
			X0_nn <- base::matrix( X0[nn,] , nrow=N1 , ncol=NV , byrow=TRUE )
			Xdist_nn <- X0_nn - X1
			distmat[nn,] <- base::rowSums( W0 * Xdist_nn^2 )
		}		
	}
	#***** matching
	m1 <- sirt::rowKSmallest2.sirt(matr=distmat , K=donors )$smallind
	g1 <- m1[ cbind( 1:N0 , base::sample( 1:donors , N0 , replace = TRUE ) ) ]
	#*** imputed values
	yimp <- y[ry2][g1]
	#--- output
	base::return(yimp)	
}

	
	