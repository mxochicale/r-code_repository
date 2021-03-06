
#

##################################################
# ref
# https://onestepafteranother.wordpress.com/signal-analysis-and-fast-fourier-transforms-in-r/


##################################################################
##################################################################
###
###  LIBRARIES
###
library(lattice) # for xyplot
library(stats) # for fft


##################################################################
##################################################################
###
###  FUNCTIONS
###
plot.timeseries <- function(time.series, tn) {

# plot <- xyplot(time.series ~ 0: length(time.series),
 # plot <-

 xyplot( time.series ~ tn,
                    col.line = c('red'), type = c("b"), lty=1, lwd=3,
                    pch=1, cex=1.5,
                    xlab=list(label="sample", cex=2),
                    ylab=list(label="x(t)", cex=2),
                    scales=list(font=1, cex=2
                                #,y=list(at=seq(-2,2,1),limits=c(-2.1,2.1))
                                #x=list(at=seq(-5,5,2),limits=c(-7,7))
                    ),
                    abline=list(h=c(0),lwd=4,lty=2),

                    ##function to modify the grid pattern
                    panel=function(...) {
                      panel.xyplot(...)
                      panel.grid(h=-20, v=-1, col.line="blue", lwd=0.5, lty=3 )
                    }

  )

}

plot.frequency.spectrum <- function(X,f){

xyplot( X ~ f,
                   col.line = c('red'),
                   type = c("b"), lty=1, lwd=3,
                   pch=1, cex=1.5,
                   xlab=list(label="Frequency (Hz)", cex=2),
                   ylab=list(label="Strength", cex=2),
                   scales=list(font=1, cex=2,
                     y=list(limits=c( 0,  max(X) +  (20*max(X))/100   ) )
                     ),
                   ##function to modify the grid pattern
                   panel=function(...) {
                     panel.xyplot(...)
                     panel.grid(h=-20, v=-1, col.line="blue", lwd=0.5, lty=3 )
                   }

                   )

}



##################################################################
##################################################################
###
###  MAIN
###

#Domain setup
acq.freq <- 50
dt <- 1/acq.freq #s

T <- 12
df <- 1/T
n <- T/dt


#CREATE OUR TIME SERIES DATA
freq1<-1 #Hz
freq2<-15 #Hz
t <- seq(0,T,by=dt)
y <- 1*sin(2*pi*freq1*t) +5* sin(2*pi*freq2*t)



#CREATE OUR FREQUENCY ARRAY
f <- 1:length(t)/T

#FOURIER TRANSFORM WORK
Y <- fft(y)
#mag <- sqrt(Re(Y)^2+Im(Y)^2)*2/n
mag <- Mod(Y)*2/n

# Discrete Fourier transforms can be normalized in different ways.
# Some apply the whole normalization to the forward transform, some to
# the reverse transform, some apply the square root to each, and some
# don't normalize at all (in which case the reverse of the forward
# transform will need scaling).
# http://r.789695.n4.nabble.com/Is-R-s-fast-fourier-transform-function-different-from-quot-fft2-quot-in-Matlab-td864669.html




pts <- plot.timeseries(y,t)
pfs <- plot.frequency.spectrum( mag[1:length(f)/2], f[1:length(f)/2])



print(pts, split = c(1, 1, 1, 2), more = TRUE)
print(pfs, split = c(1, 2, 1, 2), more = FALSE)
