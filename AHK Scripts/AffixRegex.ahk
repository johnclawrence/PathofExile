SetBatchLines, -1
clusterEffect(itemModData)
    {
    if RegExMatch(itemModData,"increased Effect"){
        if RegExMatch(itemModData,"Powerful"){
            return 2
        }
        return 1
    }
    return 0
    }

clusterDamage(itemModData)
    {
    if RegExMatch(itemModData,"increased Damage"){
        if RegExMatch(itemModData,"Deadly"){
            return 3
        }
        if RegExMatch(itemModData,"Destructive"){
            return 3
        }
        if RegExMatch(itemModData,"Dangerous"){
            return 3
        }
        if RegExMatch(itemModData,"Hazardous"){
            return 2
        }        
        return 1
    }
    return 0
    }

clusterEnergyShield(itemModData)
    {
    if RegExMatch(itemModData,"to Maximum Energy Shield"){
        if RegExMatch(itemModData,"Pulsing"){
            return 5
        }
        if RegExMatch(itemModData,"Radiating"){
            return 4
        }        
        if RegExMatch(itemModData,"Glowing"){
            return 3
        }  
        if RegExMatch(itemModData,"Glimmering"){
            return 2
        }          
        return 1
    }
    return 0
    }

clusterLife(itemModData)
    {
    if RegExMatch(itemModData,"to Maximum Life"){
        if RegExMatch(itemModData,"Stout"){
            return 5
        }
        if RegExMatch(itemModData,"Stalwart"){
            return 4
        }        
        if RegExMatch(itemModData,"Sanguine"){
            return 3
        }  
        if RegExMatch(itemModData,"Healthy"){
            return 2
        }          
        return 1
    }
    return 0
    }


clusterAllAttribute(itemModData)
    {
    if RegExMatch(itemModData,"to All Attributes"){
        if RegExMatch(itemModData,"Heavens"){
            return 5
        }
        if RegExMatch(itemModData,"Comet"){
            return 4
        }        
        if RegExMatch(itemModData,"Meteor"){
            return 3
        }  
        if RegExMatch(itemModData,"Sky"){
            return 2
        }          
        return 1
    }
    return 0
    }

    
clusterChaosResistance(itemModData)
    {
    if RegExMatch(itemModData,"to Chaos Resistance"){
        if RegExMatch(itemModData,"Exile"){
            return 5
        }
        if RegExMatch(itemModData,"Expulsion"){
            return 4
        }        
        if RegExMatch(itemModData,"Eviction"){
            return 3
        }  
        if RegExMatch(itemModData,"Banishment"){
            return 2
        }          
        return 1
    }
    return 0
    }

clusterDexterity(itemModData)
    {
    if RegExMatch(itemModData,"to Dexterity"){
        if RegExMatch(itemModData,"Panther"){
            return 5
        }
        if RegExMatch(itemModData,"Falcon"){
            return 4
        }        
        if RegExMatch(itemModData,"Fox"){
            return 3
        }  
        if RegExMatch(itemModData,"Lynx"){
            return 2
        }          
        return 1
    }
    return 0
    }

clusterElementalResistance(itemModData)
    {
    if RegExMatch(itemModData,"to all Elemental Resistance"){
        if RegExMatch(itemModData,"Rainbow"){
            return 5
        }
        if RegExMatch(itemModData,"Variegation"){
            return 4
        }        
        if RegExMatch(itemModData,"Kaleidoscope"){
            return 3
        }  
        if RegExMatch(itemModData,"Prism"){
            return 2
        }          
        return 1
    }
    return 0
    }



clusterIntelligence(itemModData)
    {
    if RegExMatch(itemModData,"to Intelligence"){
        if RegExMatch(itemModData,"Philosopher"){
            return 5
        }
        if RegExMatch(itemModData,"Augur"){
            return 4
        }        
        if RegExMatch(itemModData,"Prodigy"){
            return 3
        }  
        if RegExMatch(itemModData,"Student"){
            return 2
        }          
        return 1
    }
    return 0
    }

clusterStrength(itemModData)
    {
        if RegExMatch(itemModData,"to Strength"){
            if RegExMatch(itemModData,"Gorilla"){
                return 5
            }
            if RegExMatch(itemModData,"Lion"){
                return 4
            }        
            if RegExMatch(itemModData,"Bear"){
                return 3
            }  
            if RegExMatch(itemModData,"Wrestler"){
                return 2
            }          
            return 1
        }
        return 0
        }


MR384(){
    score = 0
    Introspection := RegExMatch(Clipboard,"Introspection")
    if (Introspection>0){
        score := 1
        }
    if (clusterEffect(Clipboard)>0){
        score := 1
        if (Introspection>0){
            score := 3
            }
        if (clusterEnergyShield(Clipboard) + clusterLife(Clipboard) > 4){
            if (clusterEffect(Clipboard) > 1){
                score := 3
                }
            }
        }
    return score
    }

SD1284(){
    score=0
    if (clusterEffect(Clipboard) > 1){
        score:=score+1
        }
    if (clusterAllAttribute(Clipboard)+clusterElementalResistance(Clipboard) > 1){
        score:=score+1
        }
    if  (clusterEnergyShield(Clipboard)+clusterLife(Clipboard)+clusterDamage(Clipboard) > 1){
        score:=score+1
        }
    if  (clusterStrength(Clipboard)+clusterIntelligence(Clipboard) > 2){
        score:=score+1
        }
    if (clusterStrength(Clipboard) > 2) {
        if (clusterEnergyShield(Clipboard) > 1) {
            score:=score-1
            }
        }
    if (clusterIntelligence(Clipboard) > 2) {
        if (clusterLife(Clipboard) > 1) {
            score:=score-1
            }
        }
    return score
    }

SD1284M(){
    score=0
    if (clusterEffect(Clipboard) > 1){
        score:=score+1
        }
    if (clusterAllAttribute(Clipboard) > 2){
        score:=score+1
        }
    if  (clusterEnergyShield(Clipboard) > 2){
        score:=score+1
        }
    if  (clusterIntelligence(Clipboard) > 2){
        score:=score+1
        }
        
    return score
    }
    
SD1284toFracture(){
    score=0
    if (clusterEffect(Clipboard) > 1){
        score:=score+1
        }
    if (clusterAllAttribute(Clipboard) > 2){
        score:=score+1
        }
    if  (clusterEnergyShield(Clipboard) > 2){
        score:=score+1
        ;if (RegExMatch(Clipboard,"Skills also grant: +12")){
            
        ;    }
        }
    if  (clusterIntelligence(Clipboard) > 2){
        ;if (RegExMatch(Clipboard,"Skills also grant: +8")){
        score:=score+1
            ;}
        } 
    return score
    }

MD1284(){
    AtkSpedT1 :=  RegExMatch(Clipboard,"Minions have 3% increased Attack and Cast Speed")
    vBite := RegExMatch(Clipboard,"Vicious")

    ;I must have T1 effect or Attributes in my 3 mods.
    score=0
    output = 0
    if (clusterEffect(Clipboard) > 1){
        score:=score+1
        }
    if (AtkSpedT1 > 0){
        score:=score+1
        }
    if  (clusterEnergyShield(Clipboard)+clusterLife(Clipboard) > 1){
        score:=score+1
        }
    if  (clusterElementalResistance(Clipboard)+clusterChaosResistance(Clipboard)+vBite > 1){
        score:=score+1
        }
    return score
    }
    
BD1284(){
    AtkSpedT1 :=  RegExMatch(Clipboard,"3% increased Attack Speed")
    ;I must have T1 effect or Attributes in my 3 mods.
    score=0
    if (clusterEffect(Clipboard)>1){
        score:=score+1
        }
    if (AtkSpedT1 > 0){
        score:=score+1
        }
    if  (clusterLife(Clipboard) + clusterDamage(Clipboard) > 1){
        score:=score+1
        }
    if  (clusterElementalResistance(Clipboard)+clusterChaosResistance(Clipboard)+clusterStrength(Clipboard)+clusterIntelligence(Clipboard)+clusterDexterity(Clipboard)+clusterAllAttribute(Clipboard) > 2){
        score:=score+1
        }
    return score
    }

ADS1284toFracture(){
    score=0
    AtkSpedT1 :=  RegExMatch(Clipboard,"Added Small Passive Skills also grant: 3% increased Attack Speed")
    if (clusterEffect(Clipboard) > 1){
        score:=score+1
        }
    if  (clusterEnergyShield(Clipboard) >2){
        if (RegExMatch(Clipboard,"Added Small Passive Skills also grant: +12")){
            score:=score+1
            }
        }
    if  ((clusterIntelligence(Clipboard)> 2)){
        if (RegExMatch(Clipboard,"Added Small Passive Skills also grant: +6")){
            score:=score+1
            }
        }
    if (AtkSpedT1 > 0){
        score:=score+1
        }
    if (clusterAllAttribute(Clipboard) > 2){
        score:=score+1
        }
    return score
    }
        
LD1284H(){
    AtkSpedT1 :=  RegExMatch(Clipboard,"3% increased Attack and Cast Speed with Lightning Skills")
    score=0
    output = 0
    if (clusterEffect(Clipboard)>1){
        score:=score+1
        }
    if (AtkSpedT1 > 0){
        score:=score+1
        }
    return score
    }
        
LD1284(){
    AtkSpedT1 :=  RegExMatch(Clipboard,"3% increased Attack and Cast Speed with Lightning Skills")
     
    score=0
    output = 0
    if (clusterEffect(Clipboard)>1){
        score:=score+1
        }
    if (AtkSpedT1 > 0){
        score:=score+1
        }
    if (clusterLife(Clipboard) + clusterDamage(Clipboard)+clusterEnergyShield(Clipboard) >1){
        score:=score+1
        }
    if (clusterElementalResistance(Clipboard)+clusterChaosResistance(Clipboard)+clusterStrength(Clipboard)+clusterIntelligence(Clipboard)+clusterAllAttribute(Clipboard) >2){
        score:=score+1
        }
    return score
    }

QACluster()
    {
    return Effect clusterEffect(Clipboard) Damage clusterDamage(Clipboard) ES clusterEnergyShield(Clipboard) Life clusterLife(Clipboard) Attr clusterAllAttribute(Clipboard) chaos clusterChaosResistance(Clipboard) Dex clusterDexterity(Clipboard) ele clusterElementalResistance(Clipboard) Int clusterIntelligence(Clipboard) Str clusterStrength(Clipboard)
    }

FD684(){
    AtkSpedT1 :=  RegExMatch(Clipboard,"Overflowing")
    vBite := RegExMatch(Clipboard,"Fasting")

    ;I must have T1 effect or Attributes in my 3 mods.
    score=0
    output = 0
    if (clusterEffect(Clipboard) > 1){
        score:=score+1
        }
    if  (clusterLife(Clipboard) +vBite> 2){
        score:=score+1
        }
    if (AtkSpedT1 > 0){
        score:=score+1
        }
    if  (clusterElementalResistance(Clipboard)clusterChaosResistance(Clipboard)+clusterAllAttribute(Clipboard)+clusterStrength(Clipboard) > 2){
        score:=score+1
        }
    return score
    }

FD684ToFracture(){
    AtkSpedT1 :=  RegExMatch(Clipboard,"Overflowing")
    vBite := RegExMatch(Clipboard,"Fasting")

    ;I must have T1 effect or Attributes in my 3 mods.
    score=0
    output = 0
    if (clusterEffect(Clipboard) > 1){
        score:=score+1
        }
    if  (vBite> 0){
        score:=score+1
        }
    if (AtkSpedT1 > 0){
        score:=score+1
        }
    return score
    }

eleBowPrefix()
    {    
    score = 0
    ;LD:= RegExMatch(Clipboard,"([4-6][0-9][0-9]|3[7-9][0-9]|36[6-9]) Lightning Damage") (458)
    FD3:= RegExMatch(Clipboard,"Blasting")
    FD2:= RegExMatch(Clipboard,"Cremating")
    FD1:= RegExMatch(Clipboard,"Carbonising")
    ;FD:= RegExMatch(Clipboard,"([3-4][0-9][0-9]|2[3-9][0-9]|2[2-9][3-9]) Fire Damage") (279)
    LD3:= RegExMatch(Clipboard,"Discharging")
    LD2:= RegExMatch(Clipboard,"Electrocuting")
    LD1:= RegExMatch(Clipboard,"Vapourising")
    ;CD:= RegExMatch(Clipboard,"[2-4][0-9][0-9] Cold Damage") (250)
    CD3:= RegExMatch(Clipboard,"Polar")
    CD2:= RegExMatch(Clipboard,"Entombing")
    CD1:= RegExMatch(Clipboard,"Crystalising")
    if (LD3+LD2+LD1 >0){
        score:=score+1
        }
    if (FD1+FD2+FD3 >0){
        score:=score+1
        }
    if (CD3+CD2+CD1 >0){
        score:=score+1
        }
    return score
    }
eleQuiverSuffix(){
    score=0
    extraArrow:= RegExMatch(Clipboard,"Splintering")
    if (extraArrow>0){
        score:=score+1
    }
    return score
    }

mdRing(){
    score=0
    T1Speed:= RegExMatch(Clipboard,"Agitation")
    if (T1Speed>0){
        score:=score+1
        }
    return score
    }
Genius(){
    score=0
    T1Int:= RegExMatch(Clipboard,"Genius")
    if (T1Int>0){
        score:=score+1
        }
    return score
}
Dissolution(){
    score=0
    T1Int:= RegExMatch(Clipboard,"Dissolution")
    if (T1Int>0){
        score:=score+1
        }
    return score
    } 

allskillsneck(){
    score=0
    T1Int:= RegExMatch(Clipboard,"Exalter's")
    if (T1Int>0){
        score:=score+2
        }
    return score
    }


MinionGhastlyAdorned(){
    score=0
    T1Speed:=RegExMatch(Clipboard,"Training")
    T1Life:=RegExMatch(Clipboard,"Stalwart")
    T1Damage:=RegExMatch(Clipboard,"Flaring")
    T2Life:=RegExMatch(Clipboard,"Sanguine")
    if (T1Speed>0){
        score:=score+1
        }
    if (T1Life+T2Life>0){
        score:=score+1
        }
    if (T1Damage>0){
        score:=score+1
        }
    return score
    }
CD875(){
    score = 0
    P0:=RegExMatch(Clipboard,"Fan of Blades")
    P1:=RegExMatch(Clipboard,"Feed the Fury")
    P2:=RegExMatch(Clipboard,"Fuel the Fight")
    S1:=RegExMatch(Clipboard,"Martial Prowess")
    P3:=RegExMatch(Clipboard,"Wind-up")
    P4:=RegExMatch(Clipboard,"Vicious Skewering")
    P5:=RegExMatch(Clipboard,"Drive the Destruction")
    P6:=RegExMatch(Clipboard,"Disease Vector")
    P7:=RegExMatch(Clipboard,"Devastator")
    P8:=RegExMatch(Clipboard,"Calamitous")
    P9:=RegExMatch(Clipboard,"Aggressive Defence")
    S2:=RegExMatch(Clipboard,"Heavy Hitter")
    S3:=RegExMatch(Clipboard,"Smite the Weak")

    if (S1+S2+S3>0){
        score := score+1
        }
    if (P0>0){
        score := score+1
        }
    if (P0>0){
        score := score+2
        }
    if (P1>0){
        score := score+1
        }
    if (P2>0){
        score := score+1
        }
    if (P3>0){
        score := score+1
        }
    if (P4>0){
        score := score+1
        }
    if (P5>0){
        score := score+0
        }
    if (P6>0){
        score := score+1
        }
    if (P7>0){
        score := score+1
        }
    if (P8>0){
        score := score+1
        }
    if (P9>0){
        score := score+0
        }
    
    return score
    }

WD1284(){
    score=0
    AtkSpedT1 :=  RegExMatch(Clipboard,"Added Small Passive Skills also grant: 3% increased Attack Speed")
    if (clusterEffect(Clipboard) > 1){
        score:=score+1
        }
    if  ((clusterLife(Clipboard) + clusterDamage(Clipboard)+clusterEnergyShield(Clipboard) >1)){
        score:=score+1
        }
    if  ((clusterIntelligence(Clipboard)+clusterElementalResistance(Clipboard)+clusterChaosResistance(Clipboard)> 2)){
        score:=score+1
        }
    if (AtkSpedT1 > 0){
        score:=score+1
        }
    if (clusterAllAttribute(Clipboard) > 0){
        score:=score+1
        }
    return score
    }