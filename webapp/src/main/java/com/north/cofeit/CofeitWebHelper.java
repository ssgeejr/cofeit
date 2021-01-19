package com.north.cofeit;

public class CofeitWebHelper{

public void CofeitWebHelper(){
  try{
	//NOTHING TO SEE HERE
  }catch(Exception ex){
     ex.printStackTrace();
  }

}

public String fetchMessage(){
   return "HELLO @ " + new java.util.Date().toString();
}

public static void main(String args[]){
  System.out.println("CLI Mode enabled");
  CofeitWebHelper helper = new CofeitWebHelper();
  System.out.println("MESSAGE: " + helper.fetchMessage());
}	


}
