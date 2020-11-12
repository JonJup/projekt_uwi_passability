
# RDS ist ein Dateiformat, dass R Objekt speichert und wenig Platz auf der
# Festplatte einimmt. Es ist optimal um Dateien zu speichern mit dennen man
# hauptsächlich in R arbeiten möchte.
data = readRDS("01_data/new_sites1.RDS")

# Wie ihr im Fenster Enviornment schon sehen könnt, hat data die Klasse sf es ist also bereits ein räumliches Objekt. 
# Falls das nicht der Fall gewesen wäre hätten wir die Funktion 
sf::st_as_sf(x = ,
             coords = c("X", "Y"),
             )
# nutzen können. Oft erkennt die Funktion die Spalten mit den Koordinanten von
# selbst, aber nicht immer. In dem Fall können sie mit dem Argument coords
# spezifiziert werden. Hier im Beispiel für die Spaltennamen X und Y. Das erste
# Argument ist immer die X Koordinate und das zweite die Y Koordinate.

# Zum speichern nutzt ihr den Befehl: 
st_write(obj = data , 
         dsn = "01_data/new_sites1.gpkg")

# Die Funktion erkennt das Dateiformat automatisch an der Endung des Namens.