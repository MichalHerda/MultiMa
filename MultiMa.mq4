//+------------------------------------------------------------------+
//|                                               ThreeMAs.mq4       |
//|                        Copyright 2023, MetaQuotes Software Corp. |
//|                                            https://www.mql5.com  |
//+------------------------------------------------------------------+
#property strict
#property indicator_chart_window  
#property indicator_buffers 3      
#property indicator_color1 clrRed   
#property indicator_color2 clrGold
#property indicator_color3 clrAqua

enum movAveNo
   {
      MA1, MA2, MA3, MA4, MA5, MA6, MA7, MA8,
   };

input movAveNo visibleMovingAverages = MA3;

input ENUM_TIMEFRAMES Timeframe1 = PERIOD_M5;         
input int Period1 = 5;           
input ENUM_MA_METHOD MAType1 = MODE_SMA;    
input ENUM_APPLIED_PRICE MAPrice1 = PRICE_CLOSE; 

input ENUM_TIMEFRAMES Timeframe2 = PERIOD_D1;         
input int Period2 = 5;           
input ENUM_MA_METHOD MAType2 = MODE_SMA;     
input ENUM_APPLIED_PRICE MAPrice2 = PRICE_CLOSE;

input ENUM_TIMEFRAMES Timeframe3 = PERIOD_W1;         
input int Period3 = 20;           
input ENUM_MA_METHOD MAType3 = MODE_SMA;     
input ENUM_APPLIED_PRICE MAPrice3 = PRICE_CLOSE;

input ENUM_TIMEFRAMES Timeframe4 = PERIOD_M5;         
input int Period4 = 5;           
input ENUM_MA_METHOD MAType4 = MODE_SMA;    
input ENUM_APPLIED_PRICE MAPrice4 = PRICE_CLOSE; 

input ENUM_TIMEFRAMES Timeframe5 = PERIOD_D1;         
input int Period5 = 5;           
input ENUM_MA_METHOD MAType5 = MODE_SMA;     
input ENUM_APPLIED_PRICE MAPrice5 = PRICE_CLOSE;

input ENUM_TIMEFRAMES Timeframe6 = PERIOD_W1;         
input int Period6 = 20;           
input ENUM_MA_METHOD MAType6 = MODE_SMA;     
input ENUM_APPLIED_PRICE MAPrice6 = PRICE_CLOSE;

input ENUM_TIMEFRAMES Timeframe7 = PERIOD_D1;         
input int Period7 = 5;           
input ENUM_MA_METHOD MAType7 = MODE_SMA;     
input ENUM_APPLIED_PRICE MAPrice7 = PRICE_CLOSE;

input ENUM_TIMEFRAMES Timeframe8 = PERIOD_W1;         
input int Period8 = 20;           
input ENUM_MA_METHOD MAType8 = MODE_SMA;     
input ENUM_APPLIED_PRICE MAPrice8 = PRICE_CLOSE;

double MABuffer1[];
double MABuffer2[];
double MABuffer3[];
double MABuffer4[];
double MABuffer5[];
double MABuffer6[];
double MABuffer7[];
double MABuffer8[];

int getMaNo() 
   {
     return visibleMovingAverages + 1;
   }

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
   int maNo = getMaNo();
   Print("maNo = ", maNo);
   
   // Deklaracja buforów
   SetIndexBuffer(0, MABuffer1);
   SetIndexBuffer(1, MABuffer2);
   SetIndexBuffer(2, MABuffer3);
   SetIndexBuffer(3, MABuffer4);
   SetIndexBuffer(4, MABuffer5);
   SetIndexBuffer(5, MABuffer6);
   SetIndexBuffer(6, MABuffer7);
   SetIndexBuffer(7, MABuffer8);

   // Ustawienia wskaźników
   SetIndexStyle(0, DRAW_LINE, STYLE_SOLID, 2);
   SetIndexStyle(1, DRAW_LINE, STYLE_SOLID, 2);
   SetIndexStyle(2, DRAW_LINE, STYLE_SOLID, 2);
   SetIndexStyle(3, DRAW_LINE, STYLE_SOLID, 2);
   SetIndexStyle(4, DRAW_LINE, STYLE_SOLID, 2);
   SetIndexStyle(5, DRAW_LINE, STYLE_SOLID, 2);
   SetIndexStyle(6, DRAW_LINE, STYLE_SOLID, 2);
   SetIndexStyle(7, DRAW_LINE, STYLE_SOLID, 2);

   IndicatorShortName("Three MAs");

   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
   if (rates_total < Period1 || rates_total < Period2 || rates_total < Period3)
      return(0);

   int counted_bars = prev_calculated;
   if (counted_bars < 0)
      counted_bars = 0;

   for (int i = counted_bars; i < rates_total; i++)
     {
      int shift1 = iBarShift(NULL, Timeframe1, time[i]);
      int shift2 = iBarShift(NULL, Timeframe2, time[i]);
      int shift3 = iBarShift(NULL, Timeframe3, time[i]);

      if (shift1 >= 0)
        MABuffer1[i] = iMA(NULL, Timeframe1, Period1, 0, MAType1, MAPrice1, shift1);
      if (shift2 >= 0)
        MABuffer2[i] = iMA(NULL, Timeframe2, Period2, 0, MAType2, MAPrice2, shift2);
      if (shift3 >= 0)
        MABuffer3[i] = iMA(NULL, Timeframe3, Period3, 0, MAType3, MAPrice3, shift3);
     }

   return(rates_total);
  }
//+------------------------------------------------------------------+
