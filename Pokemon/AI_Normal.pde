class AI_Normal extends AI{
  ArrayList<Integer> EffectiveMove = new ArrayList<Integer>();
    
  public AI_Normal(Poke p1, Poke p2, Poke p3){
    super(p1,p2,p3);
  }
  
  public AI_Normal(Poke p1, Poke p2, Poke p3, String n){
    super(p1,p2,p3,n);
  } 
  
  Poke chooseNextPoke(){
    ArrayList<Poke>canSwitchTo = new ArrayList<Poke>();
    for (int i = 0; i < AI_Team.size(); i++) {
      if (AI_Team.get(i) != oppPokemonOut && !AI_Team.get(i).getStatus().equals("FNT")) {
        canSwitchTo.add(AI_Team.get(i));  
      }
    }
    Poke chooseThis = canSwitchTo.get((int)(Math.random()*canSwitchTo.size()));
    for(int a = 0; a < canSwitchTo.size(); a ++){
      if (checkFullEffectiveness(canSwitchTo.get(a).type1,yourPokemonOut.type1,yourPokemonOut.type2) > 1 || checkFullEffectiveness(canSwitchTo.get(a).type2,yourPokemonOut.type1,yourPokemonOut.type2) > 1) {
        chooseThis = canSwitchTo.get(a);        
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
    
    ArrayList<Attack>EffectiveMove = new ArrayList<Attack>();
    float strongestEffectiveness = 2;
    int moveNumber = 0;
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
      moveNumber = (int)(Math.random()*4);
      planAttack = attacks.get(moveNumber); 
      if(!yourPokemonOut.getStatus().equals("none")){
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
        if (attacks.size() < 4 && attacks.size() >= 1) {
          planAttack = attacks.get((int)(Math.random()*attacks.size()));
        }
      }   
    }
    return planAttack;         
  }
       
  int chooseAction(){
             /*boolean AllDead = true;
           for(int b = 0; b < AI_Team.size(); b ++){
                if(AI_Team.get(b).hp > 0){
                  AllDead = false;
                }
              }
                
              if((!AllDead) && (checkEffectiveness(oppPokemonOut.geta1().getType(), yourPokemonOut.getType1()) < 1 ||
           checkEffectiveness(oppPokemonOut.geta1().getType(), yourPokemonOut.getType2()) < 1||
           checkEffectiveness(oppPokemonOut.geta2().getType(), yourPokemonOut.getType1()) < 1||
           checkEffectiveness(oppPokemonOut.geta2().getType(), yourPokemonOut.getType2()) < 1||
           checkEffectiveness(oppPokemonOut.geta3().getType(), yourPokemonOut.getType1()) < 1||
           checkEffectiveness(oppPokemonOut.geta3().getType(), yourPokemonOut.getType2()) < 1||
           checkEffectiveness(oppPokemonOut.geta4().getType(), yourPokemonOut.getType1()) < 1||
           checkEffectiveness(oppPokemonOut.geta4().getType(), yourPokemonOut.getType2()) < 1)){
             option = 1;
           }
          else{
            option = 0;
          }*/
    
    int option = 0;
    return option;       
  }
}
    
   
        