## File Name: ma.wtd.curtosisNA.R
## File Version: 0.07


###############################################################################
# weighted skewness
ma.wtd.curtosisNA <- function( data, weights=NULL, vars=NULL,
      method="unbiased" ){
    #*** pre-processing
    res <- ma.wtd.aux.data(data=data, weights=weights, vars=vars )
    data <- res$data
    weights <- res$weights
    M <- length(data)
    #*** weighted curtosis
    res <- matrix( NA, nrow=M, ncol=ncol(data[[1]]) )
    for (ii in 1:M){
        data1 <- data[[ii]]
        dataResp <- 1 - is.na( data1 )
        data1[ is.na(data1) ] <- 0
        data1 <- as.matrix( data1 )
        # calculate means
        sumweight <- colSums( dataResp * weights )
        M_vars <- colSums( data1 *  weights ) / sumweight
        M_varsM <- matrix( M_vars, nrow=nrow(data1), ncol=length(M_vars ), byrow=TRUE )
        data1adj <- ( data1 - M_varsM ) * dataResp # take care of missings
        w1 <- colSums( dataResp * weights )
        sdx <- sqrt( colSums( data1adj^2 * weights ) /  w1 )
        # adjustment of covariance
        if (method=="unbiased" ){
            wgtadj <- w1 - colSums( dataResp * weights^2 ) / w1
            wgtadj <- w1 / wgtadj
            # wtd.var ...
            #     sum(weights * ((x - xbar)^2))/(sw - sum(weights^2)/sw)
            sdx <- sqrt(wgtadj) * sdx
                                }
        sdxM <- matrix( sdx, nrow=nrow(data1), ncol=length(sdx), byrow=TRUE)
        data1adj <- ( ( data1 - M_varsM ) / sdxM )^4 * dataResp
        M1 <- colSums( data1adj *  weights ) / sumweight
        res[ii,] <- M1 - 3
                    }
    res <- colMeans(res)
    names(res) <- colnames(data[[1]])
    return( res )
        }
###############################################################################
