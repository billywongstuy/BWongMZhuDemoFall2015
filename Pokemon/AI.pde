//AI_Team is equivalent to oppTeam //they both never change after the battle starts

import java.lang.Object;
import java.util.*;
abstract class AI {
  private ArrayList<Poke> PlayerPokeTeam = new ArrayList<Poke>();
  public ArrayList<Poke> AI_Team = new ArrayList<Poke>(3);
  private Attack[][] PokeAttacks = new Attack[3][4];
  private int counter = 0;
  String name;

  public AI(Poke p1, Poke p2, Poke p3) {
      AI_Team.add(p1);
      AI_Team.add(p2);
      AI_Team.add(p3);
      name = "TRAINER";
  }
  
  public AI(Poke p1, Poke p2, Poke p3, String n) {
      AI_Team.add(p1);
      AI_Team.add(p2);
      AI_Team.add(p3);
      name = n.toUpperCase();
  }
  
  

  
  void addPokeAttacks(Poke pokemon,Attack attack){
    int PokePosition = PlayerPokeTeam.indexOf(pokemon);
    PokeAttacks[PokePosition][counter]= attack;
    counter ++;
  }
  
  float fullEffectiveness(String PokeType,String oppPokeType){
    return checkEffectiveness(PokeType,oppPokeType);
  }
    
   abstract Poke chooseNextPoke();
   abstract Attack chooseMove();  
   abstract int chooseAction();
   
   String toString() {
     return name;  
   }

}
      
      
      
      
    

    
  
    
  
  

  
  
  
 
  