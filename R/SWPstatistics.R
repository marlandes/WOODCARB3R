#' Solidwood products statistics
#'
#' Various production, imports and export data for different wood product types.
#' 21 columns in SWPcalcdata that are used to calculate production and stock change approach.
#'
#' @return Data frame of Roundwood and solidwood production, imports and exports
#' corresponds to columns in `SWPcalcdata` spreadsheet.
#' @export
#'
#' @examples
#' calculateswpdata()
calculateswpdata <- function(){
  swpcalcdata <- data.frame(Years = yrs)
  yrs <- swpcalcdata$Years

  swpcalcdata$`Other Products Production` <- sapply(yrs, function(y){
    if (y < 1950){
      return(h3(y,37)*InceN5*1000)
    }
    if (y < 1965){
      return(u4(y,19)*InceN5*1000)
    }
    if (y < 2021){
      return(h5(y,19)*InceN5*1000)
    }
  })
  pOther <- function(y){#other products exports, swpcalcP
    return(0)
  }
  swpcalcdata$`Other Products Exports` <- 0
  swpcalcdata$`Sawnwood Production` <- sapply(yrs, function(y){
    ###CHECK THIS, why are errors x*10^-8? shouldnt error be 10^16
    cavg <- (h8(1904,2)-h8(1899,2))/5
    davg <- (h8(1904,3)-h8(1899,3))/5
    if(y < 1904){
      return((((h8(1899,2) +((y-1899)*cavg))* InceF5)+(h8(1899,3)+(y-1899)*davg)* InceG5)*1000)
    }
    if(y < 1950){
      return((h8(y,2)*InceF5+h8(y,3)*InceG5)*1000)
    }
    if(y < 1965){
      return((u29(y,1)*1000*(((u29(y,2)/u29(y,1))*InceF5)+((u29(y,3)/u29(y,1))*InceG5)))*1000)
    }
    if(y< 2021){
      return((h28(y,1)*1000*(((h28(y,2)/h28(y,1))*InceF5)+((h28(y,3)/h28(y,1))*InceG5)))*1000)
    }
  })
  swpcalcdata$`Sawnwood Imports` <- sapply(yrs, function(y){
    if(y > 1899 && y < 1918){
      return(h8(y,4)*InceF5*1000)
    }
    if(y>1917 && y < 1950){
      return((((h8(y,5)+h8(y,7))*InceF5)+(h8(y,6)*InceG5))*1000)
    }
    if(y > 1949 && y < 1965){
      return(((u29(y,5)*1000*InceF5)+(u29(y,6)*InceG5*1000))*1000)
    }
    if(y>1964 && y< 2021){
      return(((h28(y,5)*1000*InceF5)+(h28(y,6)*InceG5*1000))*1000)
    }
    # if(y>2020 && y< 2051){
    #   return(((i1(y,4)*InceF5)+(i1(y,5)*InceG5))*1000)
    # }
  })

  swpcalcdata$`Sawnwood Exports` <- sapply(yrs, function(y){
    if(y < 1911){
      return(h8(y,13) * InceF5 * 1000)
    }
    if(y < 1950){
      return((((h8(y,14) + h8(y,16))*InceF5) + (h8(y,15)*InceG5))*1000)
    }
    if(y < 1965){
      return((((u29(y,8)*1000*InceF5)+(u29(y,9)*1000*InceG5)) * 1000))
    }
    if(y< 2021){
      return( ((h28(y,8)*1000*InceF5)+(h28(y,9)*1000*InceG5))*1000)
    }
  })
  swpcalcdata$`Roundwood consumed for lumber and panels` <- sapply(yrs, function(y){
    if(y < 1950){
      return((h3(y,28)+h3(y,31))*(InceV5*0.8+InceW5*0.2)*1000)
    } #sawlog domestic prod + veneer logs domestic production

    if(y < 1965){
      #u5$j, u5$o...u6$j, u6$o
      return(1000*((u5(y,7)+u5(y,11))*InceV5+(u6(y,7)+u6(y,11))*InceW5))
    } #J,O.. Lumber Production + plywood/veneer production, for HW and SW
    if (y < 2021){
      return(1000*((h6(y,7)+h6(y,11))*InceV5+(h7(y,7)+h7(y,11))*InceW5))
    }
  })

  swpcalcdata$`Log Exports (tons)` <- sapply(yrs, function(y){
    if(y < 1965){
      return((h3(y,8)*InceV5+h3(y,10)*InceW5)*1000)
    }
    if(y < 2021){
      return((h6(y,21)*InceV5+h7(y,21)*InceW5)*1000)
    }
  })
  swpcalcdata$`Imported logs for lumber and panels (1000 tons)` <- sapply(yrs, function(y){
    if(y<1950){
      return(0)
    }
    if (y < 1965){
      #u5$Y, u6$z
      return(1000*(u5(y,20)*InceV5+u6(y,20)*InceW5))
    }
    if(y < 2021){
      return(1000*(h6(y,20)*InceV5+h7(y,20)*InceW5))
    }
  })
  swpcalcdata$SP.Production <- sapply(yrs, function(y){
    if(y < 1950){
      #softwood plywood million ft^2
      return(((inc1(y,1)*InceB5))*1000)
    }
    if(y < 1965){

      return(((u36(y,2)*InceB5))*1000)
    }
    if(y<1980){
      return(((h37(y,2)*InceB5))*1000)
    }
    if(y < 2021){
      return(((h37(y,2)*InceB5)+(h38(y,3)*InceC5))*1000)
    }
  })
  swpcalcdata$SP.Imports <- sapply(yrs,function(y){
    if (y>1889 &&y<1950){
      return(0)
    }
    if(y>1949 && y<1965){
      return((u36(y,5)*InceB5)*1000)
    }
    if (y>1964 && y<1980){
      return((h37(y,5)*InceB5)*1000)
    }
    if (y>1979 && y<2021){
      return(((h37(y,5)*InceB5)+(h38(y,6)*InceC5))*1000)
    }
    # if(y>2020 && y<2051){
    #   return(((inc1(y,1)*InceB5)+(inc1(y,2)*InceC5))*1000)
    # }
  })

  swpcalcdata$SP.Exports <- sapply(yrs, function(y){
    if(y < 1927){
      return(0)
    }
    if(y < 1950){
      return(((h3t20(y,7)/1000*InceB5))*1000)
    }
    if(y < 1965){
      return(((u36(y,8)*InceB5))*1000)
    }
    if(y < 1991){
      return(((h37(y,8)*InceB5))*1000)
    }
    if(y < 2021){
      return(((h37(y,8)*InceB5)+(h38(y,9)*InceC5))*1000)
    }
  })
  swpcalcdata$NSP.Production <- sapply(yrs, function(y){
    if(y < 1950){
      return(((inc1(y,4)*InceE5)+(inc1(y,9)*InceJ5)+(inc1(y,13)*InceO5))*1000)
    }
    if(y < 1965){
      return(((u36(y,3)*InceE5)+(u52(y,2)*InceI5)+(u54(y,1)*InceJ5)+(u53(y,1)*InceO5))*1000)
    }
    if(y < 2021){
      return(((h37(y,3)*InceE5)+(h53(y,2)*InceI5)+(h56(y,1)*InceJ5)+(h53(y,3)*InceK5)+h55(y,1)*InceQ5)*1000)
    }
  })
  swpcalcdata$NSP.Imports <- sapply(yrs, function(y){
    if(y>1889 && y<1927){
      return(0)
    }
    if(y>1926 && y<1935){
      return(((h3t21(y,1)/1000)*InceR5)*1000)
    }
    if(y>1934 && y<1950){
      return((((h3t20(y,3)*InceE5)+(h3t21(y,1)*InceR5))/1000)*1000)
    }
    if(y>1949 && y<1954){
      return(u36(y,6)*InceE5*1000)
    }
    if(y>1953 && y<1963){
      return(((u36(y,6)*InceE5)+(u54(y,2)*InceJ5)+(u53(y,2)*InceO5))*1000)
    }
    if(y>1962 && y< 1965){
      return(((u36(y,6)*InceE5)+(u52(y,4)*InceI5)+(u54(y,2)*InceJ5)+(u53(y,2)*InceO5))*1000)
    }
    if(y>1964&& y<2021){
      return(((h37(y,6)*InceE5)+(h53(y,4)*InceI5)+(h56(y,2)*InceJ5)+(h55(y,2)*InceQ5))*1000)
    }
  })

  swpcalcdata$NSP.Exports <- sapply(yrs, function(y){##lNSP
    if (y<1916){
      return(0)
    }
    if(y < 1925){
      return((u54(y,3)*InceJ5)*1000)
    }
    if(y < 1927){
      return(((u54(y,3)*InceJ5)+(u53(y,3)*InceO5))*1000)
    }
    if(y < 1935){
      return((((h3t20(y,8)*InceE5+h3t21(y,4)*InceR5)/1000)+(u54(y,3)*InceJ5)+(u53(y,3)*InceO5))*1000)
    }
    if(y < 1950){
      return((((h3t20(y,8)+h3t21(y,4))/1000*InceE5)+(u54(y,3)*InceJ5)+(u53(y,3)*InceO5))*1000)
    }
    if(y < 1965){
      return(((u36(y,9)*InceE5)+(u54(y,3)*InceJ5)+(u53(y,3)*InceO5))*1000)
    }
    if(y < 2021){
      return(((h37(y,9)*InceE5)+(h53(y,5)*InceI5)+(h56(y,3)*InceJ5)+h55(y,3)*InceQ5)*1000)
    }
  })
  ######################
  swpcalcdata$`Other Products Production Special` <- swpcalcdata$`Other Products Production` - (1-a5)*swpcalcdata$`Other Products Exports`
  swpcalcdata$`Sawnwood Prod Special` <- (swpcalcdata$`Sawnwood Production` - (1-a5) * swpcalcdata$`Sawnwood Exports`) * ((swpcalcdata$`Roundwood consumed for lumber and panels`+swpcalcdata$`Log Exports (tons)`*a5-swpcalcdata$`Imported logs for lumber and panels (1000 tons)`*PRP62)/swpcalcdata$`Roundwood consumed for lumber and panels`)
  swpcalcdata$`SP Prod Special` <- (swpcalcdata$SP.Production-(1-a5)*swpcalcdata$SP.Exports)*((swpcalcdata$`Roundwood consumed for lumber and panels`+a5*swpcalcdata$`Log Exports (tons)`-swpcalcdata$`Imported logs for lumber and panels (1000 tons)`*PRP62)/swpcalcdata$`Roundwood consumed for lumber and panels`)
  swpcalcdata$`NSP Prod Special` <- (swpcalcdata$NSP.Production-(1-a5)*swpcalcdata$NSP.Exports)*((swpcalcdata$`Roundwood consumed for lumber and panels`+a5*swpcalcdata$`Log Exports (tons)`-swpcalcdata$`Imported logs for lumber and panels (1000 tons)`*PRP62)/swpcalcdata$`Roundwood consumed for lumber and panels`)

  #these used for variable 1a
  swpcalcdata$`Sawnwood Consumption` <- swpcalcdata$`Sawnwood Production` +
                                        swpcalcdata$`Sawnwood Imports` -
                                        swpcalcdata$`Sawnwood Exports`

  swpcalcdata$SP.Consumption <- swpcalcdata$SP.Production +
                                swpcalcdata$SP.Imports -
                                swpcalcdata$SP.Exports

  swpcalcdata$NSP.Consumption <- swpcalcdata$NSP.Production +
                                 swpcalcdata$NSP.Imports -
                                 swpcalcdata$NSP.Exports

  swpcalcdata

}
###############

#' Total carbon placed in use in od tons of wood fiber
#'
#' Corresponds to B3147 column in SW Calc P and SW Calc spreadsheet for Production and Stock Change
#' approach respectively.
#'
#' @param Years years to calculate carbon placed in use for
#' @param approach The approach type to use. Fractions dont change but inflow does
#' @param total Whether to return total placed in use or seperate it by end uses.
#'
#' @return a data frame of carbon placed in use for various end uses
#' @export
#'
#' @examples
#' calcplacediu()
#' calcplacediu(approach = "Stock Change", total = FALSE)
calcplacediu <- function(Years = 1900:2020, approach = c("Production",
                                                         "Stock Change"),
                         total = TRUE){
  approachtype <- match.arg(approach)
  swpcalcdata <- calculateswpdata()
  placeIU <- data.frame(Years = Years)

  if(approachtype == "Production"){
    placeIU[,2:16] <- swpcalcdata[["Sawnwood Prod Special"]][Years-(minyr-1)] * fracsawnwood[Years-(minyr-1),-16] +
      swpcalcdata[["SP Prod Special"]][Years-(minyr-1)] * fracstrpanels[Years-(minyr-1),-16] +
      swpcalcdata[["NSP Prod Special"]][Years-(minyr-1)] * fracnonstrpanels[Years-(minyr-1),-16]
  }
  else if(approachtype == "Stock Change"){
    placeIU[,2:16] <- swpcalcdata[["Sawnwood Consumption"]][Years-(minyr-1)] * fracsawnwood[Years-(minyr-1),-16] +
      swpcalcdata[["SP.Consumption"]][Years-(minyr-1)] * fracstrpanels[Years-(minyr-1),-16] +
      swpcalcdata[["NSP.Consumption"]][Years-(minyr-1)] * fracnonstrpanels[Years-(minyr-1),-16]
  }

placeIU$V17 <- swpcalcdata$`Other Products Production Special`[Years-(minyr-1)]
  if(total == FALSE){
    placeIU[,-c(1,5,10,14)]
  }
  else{
    apply(placeIU[,-c(1,5,10,14)], 1, sum)
  }
}


