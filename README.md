# Crude and standardized rates of ordinary naturalization in Swiss municipalities: new interactive maps

Immigrant naturalization in Switzerland is often characterised by a generally restrictive approach, yet with substantial variation in policies due to the complex multi-level naturalization procedure: ordinary naturalization is based on a three-level decision (municipality/commune, canton, and confederation) with a wide range of different (restrictive or almost liberal) procedures at the municipality level (Wanner, Piguet 2002), which can lead to different outcomes for the foreigner depending of his/her place of residence, and also citizenship. 

At the beginning of this century, discriminatory practices in some communes of central Switzerland have been publicized in the media and highlighted in scholarly research (Hainmueller & Hangartner, 2013). In order to document the differences in the municipal practices, standardized naturalization rates were published in 2000 (Piguet and Wanner, 2000) and updated in 2012 (Wanner and Steiner, 2012).

For policy makers and persons in charge of the naturalization at the municipality level, it is important to be able to compare the practices and naturalization rates of their municipality with other neighbouring communes, cantons or the whole country. To do so, however, naturalization rates should be comparable, i.e. they should take into account the basic characteristics of the foreign population of the municipality.  In particular, a municipality with a large number of young foreigners born in Switzerland will, all other things being equal, have more naturalisations than the neighbouring municipality, which is mainly composed of recently arrived migrants. 

Therefore, standardized naturalization rates were developed in order to compute the number of naturalizations (in %) for a « standard » population that has a specific structure in terms of age, duration of residence in Switzerland and place of birth. Standardization is justified by the strong influence of those variables on the propensity to be naturalized (Kitagawa 1964; Althauser & Wigler, 1972). So, the rates we computed considered the hypothetical number of naturalizations if every Swiss municipality presents the same demographic structure, which was established in 2000 using the structure of the foreign population on that time (Piguet and Wanner, 2000).

Recently, those publications were updated and rates were made available on a website at the University of Geneva, available in French, German and Italian. https://www.unige.ch/communication/communiques/en/2020/des-cartes-et-tableaux-interactifs-sur-la-pratique-de-naturalisation/

Visitors of this website can find information on crude and standardized naturalization by population size of municipalities in the period 1992-2017. These numbers are visualised in Figure 1 for the period 2011-2017. : 

Moreover, web visitors can explore interactive maps with crude and standardized naturalized naturalization by municipality. Figure 2 provides data on standardized naturalization rates for the period 2011-17. The pop-up window included for each municipality contains information about the name of the municipality, the rate value, the absolute number of ordinary naturalizations (when there were more than five due to anonymity requirements) and the three main nationalities of individual accessing the Swiss citizenship. 
https://www.unige.ch/communication/communiques/en/2020/des-cartes-et-tableaux-interactifs-sur-la-pratique-de-naturalisation/

In order to make data available in an appealing way, we mapped the rates using R and the library Leaflet which allows users who not are familiar with JavaScript language to easily create web maps by means of its core functions (Cheng et al. 2019). The final outcome can be saved as and html file which be embed in any webpage.   
For those who could be interested in learning how to create this sort of interactive maps, and example with the standardized rates for the period 2011-2017 as well as the necessary shapefiles of Switzerland (by communes and cantons) and the annotated R code for creating the maps can be find here: https://github.com/JuanGaleano/Naturalization-rates-Switzerland/


## References: 

Althauser, R. P., & Wigler, M. (1972). Standardization and Component Analysis. Sociological Methods & Research, 1(1), 97–135. https://doi.org/10.1177/004912417200100105

Cheng, J.; Karambelkar, B. & Xie, Y. (2019). leaflet: Create Interactive Web Maps with the JavaScript 'Leaflet' Library. R package version 2.0.3. https://CRAN.R-project.org/package=leaflet

Hainmueller, J., & Hangartner, D. (2013). Who gets a Swiss passport? A natural experiment in immigrant discrimination. American political science review, 107(1), 159-187.

Kitagawa, E. (1964). Standardized Comparisons in Population Research, Demography, Vol. 1, No. 1 (1964), pp. 296-315

Piguet E., Wanner P., Die Einbürgerungen in derSchweiz. Unterschiede zwischen Nationalitäten,Kantonen und Gemeinden, 1981–1998,Neuchâtel,Office fédéral de la statistique, 2000

Wanner P., Piguet É. The Practice of Naturalization in Switzerland: A Statistical Overview. In: Population (English edition), 57ᵉ année, n°6, 2002. pp. 917-925. DOI : 10.2307/3246621

Wanner P., Steiner I (2012), Einbürgerungslandschaft Switzerland. Entwicklung 1992-2010. Bern, EKM, 60p






