library('stringr')
remove_missing <- function(a) {
  a[!is.na(a)]
}

get_minimum <- function(a, na.rm = FALSE) {
  if (na.rm == TRUE) {
    sort(remove_missing(a))[1]
  } else {
    sort(a)[1]
  }
}

get_maximum <- function(a, na.rm = FALSE) {
  if (na.rm == TRUE) {
    temp <- sort(remove_missing(a))
    temp[length(temp)]
  } else {
    sort(a)[length(a)]
  }
}

get_range <- function(a, na.rm = FALSE) {
  if (na.rm == TRUE) {
    a <- remove_missing(a)
    max <- get_maximum(a)
    min <- get_minimum(a)
    max - min
  } else {
    get_maximum(a) - get_minimum(a)
  }
}


get_percentile10 <- function(a, na.rm = FALSE) {
  if (na.rm == TRUE) {
    a <- remove_missing(a)
    quantile(a, c(.1),na.rm = TRUE)
  } else {
    quantile(a, c(.1))
  }
}

get_percentile90 <- function(a, na.rm = FALSE) {
  if (na.rm == TRUE) {
    a <- remove_missing(a)
    quantile(a, c(.9),na.rm = TRUE)
  } else {
    quantile(a, c(.9))
  }
}

get_median <- function(a, na.rm = FALSE) {
  len <- length(a)
  temp <- len %% 2
  if (na.rm == TRUE) {
    a <- remove_missing(a)
    len <- length(a)
    temp <- len %% 2
  }
  if (temp != 0) {
    a[ceiling(len/2)]
  } else {
    temp <- (len + 1)/2
    (a[ceiling(temp)] + a[floor(temp)]) / 2
  }
}

get_average <- function(a, na.rm = FALSE) {
  if (na.rm == TRUE) {
    a <- remove_missing(a)
  }
  len <- length(a)
  count <- 0
  for (i in 1:len) {
    count <- count + a[i]
  }
  count / len
}

get_stdev <- function(a, na.rm = FALSE) {
  if (na.rm == TRUE) {
    a <- remove_missing(a)
  }
  len <- length(a)
  count <- 0
  avg <- get_average(a)
  for (i in 1:len) {
    count <- count + (a[i] - avg)**2
  }
  sqrt(count * (1/(len-1)))
}

get_quartile1 <- function(a, na.rm = FALSE) {
  if (na.rm == TRUE) {
    a <- remove_missing(a)
  }
  quantile(a, .25)
}

get_quartile3 <- function(a, na.rm = FALSE) {
  if (na.rm == TRUE) {
    a <- remove_missing(a)
  }
  quantile(a, .75)
}

count_missing <- function(a) {
  sum(is.na(a))
}


summary_stats <- function(a) {
  b <- a
  a <- remove_missing(a)
  min <- min(a)
  p10 <- get_percentile10(a)
  q1 <- get_quartile1(a)
  med <- get_median(a)
  mn <- mean(a)
  q3 <- get_quartile3(a)
  p90 <- get_percentile90(a)
  mx <- get_maximum(a)
  rg <- get_range(a)
  stdev <- get_stdev(a)
  miss <- count_missing(b)
  temp <- list(minimum = min, percent10 = p10, quartile1 = q1, median = med, mean = mn, quartile3 = q3, percent90 = p90, maximum = mx, range = rg, stdev = stdev, missing = miss)
}
print_stats <- function(a) {
  print(paste("minimum", sprintf("%3s", ":"), sprintf("%.4f", a[1])))
  print(paste("percent10", sprintf("%0s", ":") ,sprintf("%.4f", a[2])))
  print(paste("quartile1", sprintf("%0s", ":"),sprintf("%.4f", a[3])))
  print(paste("median", sprintf("%4s", ":") ,sprintf("%.4f", a[4])))
  print(paste("mean", sprintf("%6s", ":"),sprintf("%.4f", a[5])))
  print(paste("quartile3", sprintf("%0s", ":") ,sprintf("%.4f", a[6])))
  print(paste("percent90", sprintf("%0s", ":"),sprintf("%.4f", a[7])))
  print(paste("maximum", sprintf("%3s", ":") ,sprintf("%.4f", a[8])))
  print(paste("range", sprintf("%5s", ":"),sprintf("%.4f", a[9])))
  print(paste("stdev", sprintf("%5s", ":") ,sprintf("%.4f", a[10])))
  print(paste("missing", sprintf("%3s", ":"),sprintf("%.4f", a[11])))
}


rescale100 <- function(x, xmin, xmax) {
  100 * ((x-xmin)/ (xmax - xmin))
}

drop_lowest <- function(a) {
  a <-sort(a)
  b <- length(a)
  return(a[2:b])

}

score_homework <- function(a, drop = FALSE) {
  if (drop == TRUE) {
    b <- drop_lowest(a)
    return(get_average(b))
  } else {
    return(get_average(a))
  }
}

score_quiz <- function(a, drop = FALSE) {
  ss <- c(12,18,20,20)
  s <- c()
  len <- length(a)
  if (drop == TRUE) {
    for (i in 1:len) {
      s[i] = a[i]/ss[i] 
    }
    
    a <- sort(unlist(s))
    b <- length(a)
    a <- (a[2:b])
      
    count <- 0
    len <- length(a)
    for (i in 1:len) {
      count <- count + a[i]
    }
    return ((count *100)/ len) 
    
  } else {
    count <- 0
    for (i in 1:len) {
      count <- count + (a[i]/ss[i])
    }
    (count / len) * 100
  }
}





score_lab <- function(a) {
  if (a == 12 || a == 11) {
    return(100)
  }
  if (a == 10){
    return(80)
  }
  if (a == 9) {
    return(60)
  }
  if (a == 8) {
    return(40)
  }
  if (a == 7) {
    return(20)
  }
  return(0)
}

giveGrade <- function(a) {
  if (a >= 0 && a < 50) {
    return('F')
  } 
  if (a >= 50 && a < 60) {
    return('D')
  }
  if (a >= 60 && a < 70) {
    return('C-')
  }
  if (a >= 70 && a < 77.5) {
    return('C')
  }
  if (a >= 77.5 && a < 79.5) {
    return('C+')
  }
  if (a >= 79.5 && a < 82) {
    return('B-')
  }
  if (a >= 82 && a < 86) {
    return('B')
  }
  if (a >= 86 && a < 88) {
    return('B+')
  }
  if (a >= 88 && a < 90) {
    return('A-')
  }
  if (a >= 90 && a < 95) {
    return('A')
  }
  if (a >= 95 && a <= 100) {
    return('A+')
  }
}