## File Name: mice_imputation_pls_correlation_criteria.R
## File Version: 0.04


mice_imputation_pls_correlation_criteria <- function( y, x, ry, use.ymat)
{
    if ( ! use.ymat ){
        # c1 <- stats::cor( y[ry], x[ry,] )
        c1 <- cor_avoid_zero( y[ry], x[ry,] )
    } else {
        # look for correlations of all the dummy variables
        # c1 <- stats::cor( y[ry,], x[ry,] )
        c1 <- cor_avoid_zero( y[ry], x[ry,] )
        c1 <- apply( abs(c1), 2, mean, na.rm=TRUE )
    }
    return(c1)
}

