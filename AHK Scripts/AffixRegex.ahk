SetBatchLines, -1
clusterEffect(itemModData)
    {
    if RegExMatch(itemModData,"% increased Effect"){
        if RegExMatch(itemModData,"35% increased Effect"){
            return 2
        }
        return 1
    }
    return 0
    }

clusterDamage(itemModData)
    {
    if RegExMatch(itemModData,"% increased Damage"){
        if RegExMatch(itemModData,"4% increased Damage"){
            return 3
        }
        if RegExMatch(itemModData,"4% increased Damage"){
            return 3
        }
        if RegExMatch(itemModData,"4% increased Damage"){
            return 3
        }
        if RegExMatch(itemModData,"3% increased Damage"){
            return 2
        }        
        return 1
    }
    return 0
    }

clusterEnergyShield(itemModData)
    {
    if RegExMatch(itemModData,"to Maximum Energy Shield"){
        if RegExMatch(itemModData,"(1[7-9]|20) to Maximum Energy Shield"){
            return 5
        }
        if RegExMatch(itemModData,"(1[3-9]|20) to Maximum Energy Shield"){
            return 4
        }        
        if RegExMatch(itemModData,"(1[0-9]|20) to Maximum Energy Shield"){
            return 3
        }  
        if RegExMatch(itemModData,"([6-9]|1[0-9]|20) to Maximum Energy Shield"){
            return 2
        }          
        return 1
    }
    return 0
    }

clusterLife(itemModData)
    {
    if RegExMatch(itemModData,"to Maximum Life"){
        if RegExMatch(itemModData,"1[4-6] to Maximum Life"){
            return 5
        }
        if RegExMatch(itemModData,"1[1-9] to Maximum Life"){
            return 4
        }        
        if RegExMatch(itemModData,"([8-9]|1[0-6]) to Maximum Life"){
            return 3
        }  
        if RegExMatch(itemModData,"([4-9]|1[0-6]) to Maximum Life"){
            return 2
        }          
        return 1
    }
    return 0
    }


clusterAllAttribute(itemModData)
    {
    if RegExMatch(itemModData,"to All Attributes"){
        if RegExMatch(itemModData,"6 to All Attributes"){
            return 5
        }
        if RegExMatch(itemModData,"[5-6] to All Attributes"){
            return 4
        }        
        if RegExMatch(itemModData,"[4-6] to All Attributes"){
            return 3
        }  
        if RegExMatch(itemModData,"[3-6] to All Attributes"){
            return 2
        }          
        return 1
    }
    return 0
    }

    
clusterChaosResistance(itemModData)
    {
    if RegExMatch(itemModData,"% to Chaos Resistance"){
        if RegExMatch(itemModData,"[7-8]% to Chaos Resistance"){
            return 5
        }
        if RegExMatch(itemModData,"[6-8]% to Chaos Resistance"){
            return 4
        }        
        if RegExMatch(itemModData,"[5-8]% to Chaos Resistance"){
            return 3
        }  
        if RegExMatch(itemModData,"[4-8]% to Chaos Resistance"){
            return 2
        }          
        return 1
    }
    return 0
    }

clusterDexterity(itemModData)
    {
    if RegExMatch(itemModData,"to Dexterity"){
        if RegExMatch(itemModData,"1[2-4] to Dexterity"){
            return 5
        }
        if RegExMatch(itemModData,"(9|1[0-4]) to Dexterity"){
            return 4
        }        
        if RegExMatch(itemModData,"([6-9]|1[0-4]) to Dexterity"){
            return 3
        }  
        if RegExMatch(itemModData,"([4-9]|1[0-4]) to Dexterity"){
            return 2
        }          
        return 1
    }
    return 0
    }

clusterElementalResistance(itemModData)
    {
    if RegExMatch(itemModData,"% to all Elemental Resistance"){
        if RegExMatch(itemModData,"6% to all Elemental Resistance"){
            return 5
        }
        if RegExMatch(itemModData,"[5-6]% to all Elemental Resistance"){
            return 4
        }        
        if RegExMatch(itemModData,"[4-6]% to all Elemental Resistance"){
            return 3
        }  
        if RegExMatch(itemModData,"[3-6]% to all Elemental Resistance"){
            return 2
        }          
        return 1
    }
    return 0
    }



clusterIntelligence(itemModData)
    {
    if RegExMatch(itemModData,"to Intelligence"){
        if RegExMatch(itemModData,"1[2-4] to Intelligence"){
            return 5
        }
        if RegExMatch(itemModData,"(9|1[0-4]) to Intelligence"){
            return 4
        }        
        if RegExMatch(itemModData,"([6-9]|1[0-4]) to Intelligence"){
            return 3
        }  
        if RegExMatch(itemModData,"([4-9]|1[0-4]) to Intelligence"){
            return 2
        }          
        return 1
    }
    return 0
    }

clusterStrength(itemModData)
    {
        if RegExMatch(itemModData,"to Strength"){
            if RegExMatch(itemModData,"1[2-4] to Strength"){
                return 5
            }
            if RegExMatch(itemModData,"(9|1[0-4]) to Strength"){
                return 4
            }        
            if RegExMatch(itemModData,"([6-9]|1[0-4]) to Strength"){
                return 3
            }  
            if RegExMatch(itemModData,"([4-9]|1[0-4]) to Strength"){
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
    if (clusterAllAttribute(Clipboard) > 1){
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

eleBowPrefix()
    {    
    score = 0
    ;LD:= RegExMatch(Clipboard,"([4-6][0-9][0-9]|3[7-9][0-9]|36[6-9]) Lightning Damage") (458)
    LD:= RegExMatch(Clipboard,"([5-6][0-9][0-9]|4[5-9][0-9]) Lightning Damage")
    ;FD:= RegExMatch(Clipboard,"([3-4][0-9][0-9]|2[3-9][0-9]|2[2-9][3-9]) Fire Damage") (279)
    FD:= RegExMatch(Clipboard,"([3-4][0-9][0-9]|2[7-9][0-9]) Fire Damage")
    ;CD:= RegExMatch(Clipboard,"[2-4][0-9][0-9] Cold Damage") (250)
    CD:= RegExMatch(Clipboard,"([3-4][0-9][0-9]|2[5-9][0-9]) Cold Damage")
    if (LD >0){
        score:=score+1
        }
    if (FD >0){
        score:=score+1
        }
    if (CD >0){
        score:=score+1
        }
    return score
    }