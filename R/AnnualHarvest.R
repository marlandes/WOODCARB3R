annualDomesticHarvest <- function(years = 1990:2020, var = FALSE){
  var5 <- data.frame(Years = yrs)

  Var5 <- function(year){
    return((Calc_DI(year)+Calc_DO(year)
            + Calc_DN(year))*1000)
  }

  #DI= industrial roundwood production as C flow
  Calc_DI <- function(year){
    return(PRO17*usa_C(year)*1000)
  }
  usa_C <- function(year){
    if (year < 1950){
      return((h3(year, 5)*InceV5 + h3(year, 6) * InceW5)*1000)
    }
    if (year > 1949 && year < 1965){
      return((u5(year, 4)*InceV5 + u6(year, 4))*1000)
    }
    if (year > 1964 && year < 2021){
      return((h6(year, 3)*InceV5 + h7(year, 3))*1000)
    }
    if (year > 2020 && year < 2051){
      return((i3(year,10)*InceV5) (i3(year,9) * InceW5) *1000)
    }
  }

  #########
  #DO= fuelwood
  Calc_DO <- function(year){
    return(PRO17*usa_G(year)*1000)

  }
  usa_G <- function(year){
    if (year < 1950){
      return(((u5(year, 27)*InceV5+ u6(year,27) *InceW5)) / ((u5(year, 27)+ u6(year, 27) * h3(year, 38)) *1000))
    }
    if (year > 1949 && year < 1965){
      return(u5(year, 27) * InceV5 + u6(year, 27) * InceW5) *1000
    }
    if (year > 1964 && year < 2014){
      return(h6(year, 24) * InceV5 + h7(year, 24)* InceW5) * 1000
    }
  }





  ##########
  #DN= bark carbon
  Calc_DN <- function(year){
    return(PRO17*((PRM19*usa_BO(year))+(PRM20*usa_BP(year)))*1000)
  }
  usa_BO <- function(year){
    if (year < 1950){
      return(h3(year, 5)* InceV5) *1000
    }
    if (year > 1949 && year < 1965){
      return(u5(year, 4) * InceV5) *1000
    }
    if (year > 1964 && year < 2014){
      return(h6(year, 3) * InceV5) * 1000
    }
    if (year > 2013 && year < 2051){
      return(i3(year, 10)* InceV5) *1000
    }
  }

  usa_BP <- function(year){
    return(usa_C(year) - usa_BO(year))
  }

  usa_C <- function(year){
    if (year < 1950){
      return(h3(year, 5)* InceV5 + h3(year, 6) * InceW5) *1000
    }
    if (year < 1965){
      return(u5(year, 4) * InceV5 + u6(year, 4) * InceW5) *1000
    }
    if (year < 2021){
      return(h6(year, 3) * InceV5 + h7(year, 3) * InceW5) * 1000
    }
    #if (year < 2051){
      #return((i3(year, 10)* InceV5) + i3(year, 9) * InceW5) *1000
    #}
  }
}
