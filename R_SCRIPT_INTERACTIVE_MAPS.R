##########################################################################
#
# TITLE: HOW TO CREATE AN INTERACTIVE MAP USING THE LEAFLET LYBRARY IN R
# AUTHOR: JUAN GALEANO (Juan.Galeano@unige.ch)
# DATE: 25/02/2020
#
###########################################################################

# IMPORTANT PRELIMINARY NOTE:

# If you open this script by simply double clicking over it. Go to tab "File",
# click over "Reopen with Encoding.." and select UTF-8. This will preserve
# special characters included in the map (ü, é)

# 0. Load the necessary libraries. Is possible you will need first to install them 
# on your computer, in case you didn't before.

#install.packages("leaflet")
#install.packages("htmlwidgets")
#install.packages("htmltools")

library(leaflet) # see information about this library: ?leaflet
library(htmlwidgets) # see information about this library: ?htmlwidgets
library(htmltools) # see information about this library: ?htmltools
library(forcats)

# 1- Set a working directory (folder where files are stored, and where the final map will be saved) ####

setwd("C:\\Users\\jgaleano\\Dropbox\\GINEBRA_DataH\\POST_NATURALIZATION")
load("map_communes_st_2011_2017.Rdata")
load("map_cantons.Rdata")

# 2- Create interval for the Standarized rate of ordinary naturalization for the period 2011-2017 ####

SHP1@data$intto1117<-with(SHP1@data, ifelse((is.na(TSNO_2011_2017_1)),"moins de 5 naturalisations<br>weniger als 5 Einbürgerungen<br>meno di 5 naturalizzazioni", 
                                     ifelse((TSNO_2011_2017_1 >0.0001& TSNO_2011_2017_1 <=.5),"<0.5",
                                     ifelse((TSNO_2011_2017_1 >.5&TSNO_2011_2017_1 <=1),"0.5 - 1",
                                     ifelse((TSNO_2011_2017_1 >1&TSNO_2011_2017_1 <=1.5),"1 - 1.5",
                                     ifelse((TSNO_2011_2017_1 >1.5&TSNO_2011_2017_1 <=2),"1.5 - 2",
                                     ifelse((TSNO_2011_2017_1 >2&TSNO_2011_2017_1 <=2.5),"2 - 2.5",
                                     ifelse((TSNO_2011_2017_1 >2.5&TSNO_2011_2017_1 <=3),"2.5 - 3",
                                     ifelse((TSNO_2011_2017_1 >3&TSNO_2011_2017_1 <=3.5),"3 - 3.5",
                                     ifelse((TSNO_2011_2017_1 >3.5&TSNO_2011_2017_1 <=4),"3.5 - 4",
                                     ifelse((TSNO_2011_2017_1 >4&TSNO_2011_2017_1 <=4.5),"4 - 4.5",   
                                     ifelse((TSNO_2011_2017_1 >4.5),">4.5","wrong"))))))))))))

# 3. Convert variable intto1117 in to a factor. ####

SHP1@data$intto1117<-as.factor(SHP1@data$intto1117)

# 3.1 Make possible NAs explicit ####

SHP1@data$intto1117<-fct_explicit_na(SHP1@data$intto1117)

# 3.2 check levels of factor ####

levels(SHP1@data$intto1117)

# 3.3 Reoder levels of factor ####

SHP1@data$intto1117 <- factor(SHP1@data$intto1117, 
  levels = c("<0.5" ,"0.5 - 1","1 - 1.5","1.5 - 2","2 - 2.5",
  "2.5 - 3","3 - 3.5","3.5 - 4","4 - 4.5",">4.5",
  "moins de 5 naturalisations<br>weniger als 5 Einbürgerungen<br>meno di 5 naturalizzazioni" ))

# 4. Due to anonymity issues  if there were less than five naturalization we set a label "<5" ####

SHP1@data$NNO_2011_2017_1<-ifelse(SHP1@data$NNO_2011_2017_1=="less 5","<5",SHP1@data$NNO_2011_2017_1 )

# 5. In order to add a layer with bubbles, we create a dataframe with the Long/lat coordinates of each polygon (commune) ####

BUBLE<-as.data.frame(cbind(coordinates(SHP1),SHP1@data$NNO_2011_2017))

# 5.1 Define the size of the bubble according to the number of naturalizations ####

BUBLE$size<-with(BUBLE, ifelse(V3<1,"", 
                        ifelse((V3>=1&V3<25),10,
                        ifelse((V3>=25&V3<100),20,
                        ifelse((V3>=100&V3<500),30,
                        ifelse((V3>=500&V3<1000),40,
                        ifelse((V3>=1000&V3<2000),50,
                        ifelse((V3>=2000&V3<3000),60,
                        ifelse((V3>=3000&V3<10000),70,
                        ifelse((V3>=10000&V3<20000),100,
                        ifelse((V3>=20000&V3<30000),120,      
                        10000)))))))))))

# 5.2 Coerce variable size to be a number ####                                                                                     

BUBLE$size<-as.numeric(BUBLE$size)

# Now we get into producing the interactive map. ####

# 6. Define a color palette for the polygons (communes) ####

palette <-c( "#ffffb2","#ffe98c","#ffd265","#feb751","#fe9b43",
             "#fb7b35","#f55629","#eb3420","#d41a23", "#bd0026","#e6e6e6")

pal <- colorFactor(palette, NULL)

# 7. Define the information that will be show on the pop-up windows. ####

# 7.1 Pop-up window for the poligons (communes) ####

SHP1$TSNO_2011_2017_1[is.na(SHP1$TSNO_2011_2017_1)] <- ""

state_popup1117 <- paste0(paste("<strong>",SHP1$name,"</strong>",sep=""), 
                          "<br>Taux/Quote/Tasso: ", 
                          paste0("<strong>",ifelse(SHP1$TSNO_2011_2017_1=="","-",paste((SHP1$TSNO_2011_2017_1 ),"%",sep="")),"</strong>"),
                          "<br>Naturalisation ordinaire/",
                          "<br>Ordentliche Einbürgerung/",
                          "<br>Naturalizzazione ordinaria: ",
                          paste0("<strong>",paste((SHP1$NNO_2011_2017_1),sep=" "),"</strong>"),
                          paste0(paste("<br>", SHP1$firstname1," ", paste0("<strong>",SHP1$firstn,"</strong>"),sep="")),
                          paste0(paste("<br>", SHP1$secondname1," ", paste0("<strong>",SHP1$secondn,"</strong>"),sep="")),
                          paste0(paste("<br>", SHP1$thirdname1," ", paste0("<strong>",SHP1$thirdn,"</strong>"),sep="")))

# 7.2 Pop-up window for the bubbles (communes) ####

state_popup1 <- paste0(paste("<strong>",SHP1$name,"</strong>",sep=""), 
                       "<br>Taux/Quote/Tasso: ", 
                       paste0("<strong>",ifelse(SHP1$TSNO_2011_2017_1=="","-",paste((SHP1$TSNO_2011_2017_1 ),"%",sep="")),"</strong>"),
                       "<br>Naturalisation ordinaire/",
                       "<br>Ordentliche Einbürgerung/",
                       "<br>Naturalizzazione ordinaria: ",
                       paste0("<strong>",paste((SHP1$NNO_2011_2017_1),sep=" "),"</strong>"),
                       paste0(paste("<br>", SHP1$firstname1," ", paste0("<strong>",SHP1$firstn,"</strong>"),sep="")),
                       paste0(paste("<br>", SHP1$secondname1," ", paste0("<strong>",SHP1$secondn,"</strong>"),sep="")),
                       paste0(paste("<br>", SHP1$thirdname1," ", paste0("<strong>",SHP1$thirdn,"</strong>"),sep="")))



# 7.3 Define a style for the title of the map ####

tag.map.title <- tags$style(HTML("
  .leaflet-control.map-title { 
    transform: translate(-50%,20%);
    position: fixed !important;
    left: 50%;
    bottom: 90%;
    text-align: center;
    padding-left: 10px; 
    padding-right: 10px; 
    background: rgba(255,255,255,0.75);
    font-weight: bold;
    font-size: 15px;
  }
"))

# 7.4 Define the title ####

title <- tags$div(
  tag.map.title, HTML("Taux standardisé de naturalisation ordinaire, 2011-2017
                      <br>Standardisierte Einbürgerungsquote Ordentlichen, 2011-2017
                      <br>Tasso standardizzato di naturalizzazione ordinari, 2011-2017"))  

# 7.5 Define a style for the caption of the map ####

tag.map.title2 <- tags$style(HTML("
  .leaflet-control.map-title2 { 
    transform: translate(-50%,20%);
    position: fixed !important;
    left: 50%;
    bottom: 1%;
    text-align: center;
    padding-left: 10px; 
    padding-right: 10px; 
    background: rgba(255,255,255,0.75);

    font-size: 12px;
  }
"))

# 7.4 Define the caption ####

title2 <- tags$div(
  tag.map.title2, HTML("Source: OFS, STATPOP. Méthode : voir texte 
                      <br>Quelle: BFS, STATPOP. Methode: siehe Text
                      <br>Fonte : UST, STATPOP. Metodo: vedi testo"))

# 8. Create the map using function Leaflet  #####  

map<-leaflet(SHP1) %>%
  addTiles(urlTemplate = "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
           attribution = '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors')%>%
    # add a layer with cantonal borders
    addPolylines(data=SHP,
                 group = "Polygons1",
                 fillColor = NA, 
                 fillOpacity = 0, 
                 color = "black",
                 stroke=TRUE,
                 weight = 2)%>%
  # add a layer with communes borders and value of rates 
    addPolygons(data=SHP1,
                group = "Taux/Quote/Tasso",
                fillColor = ~pal(intto1117), 
                fillOpacity = 0.5, 
                color = "black",
                stroke=TRUE,
                weight = .5, 
                popup = state_popup1117,
                highlightOptions = highlightOptions(
                  color = "#ffffff", opacity = 1, weight = 2, fillOpacity = 1,
                  bringToFront = FALSE, sendToBack = FALSE))%>%
  # add a layer with the bubbles and value of rates   
  addCircles(data=BUBLE, 
               lng = ~V1, lat = ~V2, 
               weight = .5,
               group = paste0("Naturalisation ordinaire/","<br>Ordentliche Einbürgerung/","<br>Naturalizzazione ordinaria"),
               radius = ~(size*45),  
               stroke = TRUE,
               color =  "black",
               fillColor =  "YELLOW", 
               fillOpacity = .75,
               popup = state_popup1,
               highlightOptions = highlightOptions(
                 color = "red", opacity = 1, weight = 2, fillOpacity = 1,
                 bringToFront = TRUE, sendToBack = FALSE))%>%
    addControl(title, position = "topleft", className="map-title")%>%
    addControl(title2, position = "bottomright", className="map-title2")%>%
    addLayersControl(
      overlayGroups = c("Taux/Quote/Tasso",paste0("Naturalisation ordinaire/","<br>Ordentliche Einbürgerung/","<br>Naturalizzazione ordinaria")),
      options = layersControlOptions(collapsed = FALSE))%>%
    leaflet::addLegend("bottomright", pal = pal, values = ~intto1117,
                       title ="Taux/Quote/Tasso",
                       labFormat = labelFormat(prefix = ""),
                       opacity = 1)
  
  map
  
# 9. Save your map as an html file ####
  
saveWidget(map, file="MAP_standardized_rates_2011_2017_FINAL_VERSION.html")
  
################################END OF CODE ##################################
