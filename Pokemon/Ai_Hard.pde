class AI_Hard extends AI{
    ArrayList<Integer> EffectiveMove = new ArrayList<Integer>();
    public AI_Hard(Poke p1, Poke p2, Poke p3){
    super(p1,p2,p3);
    }
              
  public AI_Hard(Poke p1, Poke p2, Poke p3, String n){
    super(p1,p2,p3,n);
  }
              
  int chooseAction(){
    int option = 0;
    if(fullEffectiveness(oppPokemonOut.getType1(),yourPokemonOut.getType1()) < 2||
    fullEffectiveness(oppPokemonOut.getType1(),yourPokemonOut.getType2()) < 2||
    fullEffectiveness(oppPokemonOut.getType2(),yourPokemonOut.getType1()) < 2||
    fullEffectiveness(oppPokemonOut.getType2(),yourPokemonOut.getType2()) < 2){
      option = 1;
    }
    else if(oppPokemonOut.speed > yourPokemonOut.speed){
            if(willKill(yourPokemonOut)){
              option = 0;
            }
            else{
              option = 1;
            }
    }
    
    else if(oppPokemonOut.speed < yourPokemonOut.speed && willDie(oppPokemonOut)) {
      option = 1;
    }
    else{
      option = 0;
    }
    return option;
  }
          
        
      
  Poke chooseNextPoke(){
    ArrayList<Poke>canSwitchTo = new ArrayList<Poke>();
    for (int i = 0; i < AI_Team.size(); i++) {
      if (AI_Team.get(i) != oppPokemonOut && !AI_Team.get(i).getStatus().equals("FNT")) {
        canSwitchTo.add(AI_Team.get(i));  
      }
    }
    if (canSwitchTo.size() == 0) {
      return null;  
    }
    Poke chooseThis = canSwitchTo.get(0);
      for(int c = 0; c < canSwitchTo.size(); c ++){
        if(fullEffectiveness(canSwitchTo.get(c).getType1(),yourPokemonOut.getType1())>1||
        fullEffectiveness(canSwitchTo.get(c).getType2(),yourPokemonOut.getType1())>1||
        fullEffectiveness(canSwitchTo.get(c).getType1(),yourPokemonOut.getType2())>1||
        fullEffectiveness(canSwitchTo.get(c).getType2(),yourPokemonOut.getType2())>1){
          chooseThis = canSwitchTo.get(c);
        }
      }
      return chooseThis;
  }
       

              
  Attack chooseMove(){
    ArrayList<Attack>attacks = new ArrayList<Attack>();
    
    attacks.add(oppPokemonOut.a1);
    attacks.add(oppPokemonOut.a2);
    attacks.add(oppPokemonOut.a3);
    attacks.add(oppPokemonOut.a4);
    
    for (int y = 0; y < attacks.size(); y++) {
      if (attacks.get(y).ppLeft <= 0) {
        attacks.remove(y);
        y--;
      }
    }
    int beginningSize = attacks.size();
    
    ArrayList<Attack>EffectiveMove = new ArrayList<Attack>();
    float strongestEffectiveness = 2;
    int moveNumber = (int)(Math.random()*attacks.size());
    Attack planAttack = attacks.get(moveNumber);
    
    //check if the typeffectiveness of each attack >= strongestEffectiveness if so, add it to arraylist then set strongest
    //at end remove any elements with effectiveness < strongest
    for(int i = 0; i < attacks.size(); i ++){
      if(checkBattleEffectiveness(attacks.get(i),yourPokemonOut) >= strongestEffectiveness){
        EffectiveMove.add(attacks.get(i));
        strongestEffectiveness = checkBattleEffectiveness(attacks.get(i),yourPokemonOut);
      }
    }
    
    if (EffectiveMove.size() > 0) {
      println("no supper effecrive");
      Attack HiDamage = EffectiveMove.get(0);
      float greatestBase = EffectiveMove.get(0).getPower() * checkBattleEffectiveness(EffectiveMove.get(0),yourPokemonOut);
      for(int j = 1; j < EffectiveMove.size(); j++){
        if(EffectiveMove.get(j).getPower() * checkBattleEffectiveness(EffectiveMove.get(j),yourPokemonOut) > greatestBase){
          HiDamage = EffectiveMove.get(j);
          greatestBase = EffectiveMove.get(j).getPower() * checkBattleEffectiveness(EffectiveMove.get(j),yourPokemonOut);
        }
      }
      planAttack = HiDamage;
      return planAttack;
    }
    
    if(EffectiveMove.size() == 0){
      planAttack = attacks.get(moveNumber); 
      if(!yourPokemonOut.getStatus().equals("")){
        if(moveNumber == 0){
          if (!attacks.get(0).effect1.equals("") && attacks.get(0).effect1Chance == 1){
            attacks.remove(0);          
          }
        }
        if(moveNumber == 1){
          if (!attacks.get(1).effect1.equals("") && attacks.get(1).effect1Chance == 1){
            attacks.remove(1);          
          }
        }
        if(moveNumber == 2){
          if (!attacks.get(2).effect1.equals("") && attacks.get(2).effect1Chance == 1){
            attacks.remove(2);          
           }
        }
        if(moveNumber == 3){
          if (!attacks.get(3).effect1.equals("") && attacks.get(3).effect1Chance == 1){
            attacks.remove(3);          
          }
        }
        if (attacks.size() < beginningSize && attacks.size() >= 1) {
          planAttack = attacks.get((int)(Math.random()*attacks.size()));
        }
      }   
    }
    return planAttack;         
  }

          
        int calculateDamage(Poke opp, Attack attack) {
          double baseDmg;
          if (attack.getCategory().equals("Physical")) {
            baseDmg = Math.floor(yourPokemonOut.checkSTAB(attack)*(Math.floor(Math.floor((2*yourPokemonOut.lv+10)*yourPokemonOut.atk*yourPokemonOut.burned()*multipliers[yourPokemonOut.statStatus[0]+6]*attack.getPower()/250)/(opp.getDef()*multipliers[opp.statStatus[1]+6]))+2.0));
            }
          else if (attack.getCategory().equals("Special")) {
            baseDmg = Math.floor(yourPokemonOut.checkSTAB(attack)*(Math.floor(Math.floor((2*yourPokemonOut.lv+10)*yourPokemonOut.spec*multipliers[yourPokemonOut.statStatus[2]+6]*attack.getPower()/250)/(opp.getSpec()*multipliers[opp.statStatus[2]+6]))+2.0));
            }
          else {
            baseDmg = 0;  
            }
          double random = (int)(Math.random()*16+85);
          //println("Random:" + random);
          double modifier = (random/100.0)*yourPokemonOut.effective(attack,opp.getType1(),opp.getType2()); //includes STAB(above), random, effectiveness, and random (included above)
    
          int damage = (int)(Math.floor(baseDmg*modifier));
   
          if (opp.hp < damage) {
            return opp.hp;  
            }
      return damage;
      }
      boolean willDie(Poke opp){
        if(calculateDamage(opp, yourPokemonOut.geta1()) >= opp.hp||
           calculateDamage(opp, yourPokemonOut.geta2()) >= opp.hp||
           calculateDamage(opp, yourPokemonOut.geta3()) >= opp.hp||
           calculateDamage(opp, yourPokemonOut.geta4()) >= opp.hp){
             return true;
           }
           else{
             return false;
           }
      }
      boolean willKill(Poke yourPoke){
         if(calculateDamage(oppPokemonOut, yourPokemonOut.geta1()) >= yourPoke.hp||
           calculateDamage(oppPokemonOut, yourPokemonOut.geta2()) >= yourPoke.hp||
           calculateDamage(oppPokemonOut, yourPokemonOut.geta3()) >= yourPoke.hp||
           calculateDamage(oppPokemonOut, yourPokemonOut.geta4()) >= yourPoke.hp){
             return true;
           }
           else{
             return false;
           }
      }
      
        
}