//+------------------------------------------------------------------+
//|                                                   acorralado-jpy |
//|                                  Copyright 2018, Gustavo Carmona |
//|                                      awwthttps://www.awtt.com.ar |
//+------------------------------------------------------------------+



#property copyright "Copyright 2018, Gustavo Carmona"
#property link      "https://www.awtt.com.ar"
#property version   "1.00"
#property strict
#include "acorralado.mqh"

Acorralado bot("bot"), tob("tob");
double profitBot, profitTob;
int lastOP;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {
  bot.setInitialOrder(OP_SELL);
  tob.setInitialOrder(OP_BUY);

  return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick(){
   //if last order executed
   
   profitTob = 0;
   profitBot = 0;
   bot.setPendingOrder();
   tob.setPendingOrder();
   profitBot = bot.getBalance();
   profitTob = tob.getBalance();
   Comment("Balance bot= ",profitBot, ", balance tob= ", profitTob);
   bot.closePendingOrder();
   tob.closePendingOrder();

   if(!bot.getBotIsOpen()){
      if(!OrderSelect(bot.getTicketLastExecutedOrder(),SELECT_BY_TICKET,MODE_HISTORY))
         Comment("Error Select Order: ", GetLastError());
      lastOP = OrderType();
      bot.setInitialValues();
      bot.setInitialOrder((lastOP+1)%2);
      }
   
   if(!tob.getBotIsOpen()){
      if(!OrderSelect(tob.getTicketLastExecutedOrder(),SELECT_BY_TICKET,MODE_HISTORY))
         Comment("Error Select Order: ", GetLastError());
      lastOP = OrderType();
      tob.setInitialValues();
      tob.setInitialOrder((lastOP+1)%2);
      }
      
}      
      
    