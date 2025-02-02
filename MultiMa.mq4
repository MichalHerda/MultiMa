//+------------------------------------------------------------------+
//|                                               ThreeMAs.mq4       |
//|                                            https://www.mql5.com  |
//+------------------------------------------------------------------+
#property strict
#property indicator_chart_window  
#property indicator_buffers 8      
#property indicator_color1 clrRed   
#property indicator_color2 clrGold
#property indicator_color3 clrAqua
#property indicator_color4 clrAzure   
#property indicator_color5 clrBeige
#property indicator_color6 clrCoral
#property indicator_color7 clrDeepPink
#property indicator_color8 clrLightCyan
//-----------------------------------------------------------------------------------------------------------------
enum movAveNo
   {
      MA1, MA2, MA3, MA4, MA5, MA6, MA7, MA8,
   };
//-----------------------------------------------------------------------------------------------------------------
input movAveNo visibleMovingAverages = MA3;

input ENUM_TIMEFRAMES Timeframe1 = PERIOD_H1;         
input int Period1 = 10;           
input ENUM_MA_METHOD MAType1 = MODE_SMA;    
input ENUM_APPLIED_PRICE MAPrice1 = PRICE_CLOSE; 

input ENUM_TIMEFRAMES Timeframe2 = PERIOD_D1;         
input int Period2 = 10;           
input ENUM_MA_METHOD MAType2 = MODE_SMA;     
input ENUM_APPLIED_PRICE MAPrice2 = PRICE_CLOSE;

input ENUM_TIMEFRAMES Timeframe3 = PERIOD_W1;         
input int Period3 = 10;           
input ENUM_MA_METHOD MAType3 = MODE_SMA;     
input ENUM_APPLIED_PRICE MAPrice3 = PRICE_CLOSE;

input ENUM_TIMEFRAMES Timeframe4 = PERIOD_W1;         
input int Period4 = 20;           
input ENUM_MA_METHOD MAType4 = MODE_SMA;    
input ENUM_APPLIED_PRICE MAPrice4 = PRICE_CLOSE; 

input ENUM_TIMEFRAMES Timeframe5 = PERIOD_H4;         
input int Period5 = 5;           
input ENUM_MA_METHOD MAType5 = MODE_SMA;     
input ENUM_APPLIED_PRICE MAPrice5 = PRICE_CLOSE;

input ENUM_TIMEFRAMES Timeframe6 = PERIOD_D1;         
input int Period6 = 5;           
input ENUM_MA_METHOD MAType6 = MODE_SMA;     
input ENUM_APPLIED_PRICE MAPrice6 = PRICE_CLOSE;

input ENUM_TIMEFRAMES Timeframe7 = PERIOD_W1;         
input int Period7 = 5;           
input ENUM_MA_METHOD MAType7 = MODE_SMA;     
input ENUM_APPLIED_PRICE MAPrice7 = PRICE_CLOSE;

input ENUM_TIMEFRAMES Timeframe8 = PERIOD_MN1;         
input int Period8 = 5;           
input ENUM_MA_METHOD MAType8 = MODE_SMA;     
input ENUM_APPLIED_PRICE MAPrice8 = PRICE_CLOSE;
//-----------------------------------------------------------------------------------------------------------------
double MABuffer1[];
double MABuffer2[];
double MABuffer3[];
double MABuffer4[];
double MABuffer5[];
double MABuffer6[];
double MABuffer7[];
double MABuffer8[];
//-----------------------------------------------------------------------------------------------------------------
int OnInit()
  {   
   switch(visibleMovingAverages) {
      case MA8:
         SetIndexBuffer(7, MABuffer8);
         SetIndexStyle(7, DRAW_LINE, STYLE_SOLID, 1);
      case MA7:
         SetIndexBuffer(6, MABuffer7);
         SetIndexStyle(6, DRAW_LINE, STYLE_SOLID, 1);
      case MA6:
         SetIndexBuffer(5, MABuffer6);
         SetIndexStyle(5, DRAW_LINE, STYLE_SOLID, 1);
      case MA5:
         SetIndexBuffer(4, MABuffer5);
         SetIndexStyle(4, DRAW_LINE, STYLE_SOLID, 1);
      case MA4:
         SetIndexBuffer(3, MABuffer4);
         SetIndexStyle(3, DRAW_LINE, STYLE_SOLID, 2);
      case MA3:
         SetIndexBuffer(2, MABuffer3);
         SetIndexStyle(2, DRAW_LINE, STYLE_SOLID, 2);
      case MA2:
         SetIndexBuffer(1, MABuffer2);
         SetIndexStyle(1, DRAW_LINE, STYLE_SOLID, 2);
      case MA1:
         SetIndexBuffer(0, MABuffer1);
         SetIndexStyle(0, DRAW_LINE, STYLE_SOLID, 2);
      default:
         SetIndexBuffer(0, MABuffer1);
         SetIndexStyle(0, DRAW_LINE, STYLE_SOLID, 2);     
   }
    
   IndicatorShortName("Multi MA");

   return(INIT_SUCCEEDED);
  }
//-----------------------------------------------------------------------------------------------------------------
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
   if (rates_total < Period1 || rates_total < Period2 || rates_total < Period3 ||
       rates_total < Period4 || rates_total < Period5 || rates_total < Period6 ||
       rates_total < Period7 || rates_total < Period8 )
      return(0);

   int counted_bars = prev_calculated;
   if (counted_bars < 0)
      counted_bars = 0;
  
   ArrayResize(MABuffer1, rates_total);
   for (int i = counted_bars; i < rates_total; i++)
     {
      switch(visibleMovingAverages) {
      case MA8: {
         int shift8 = iBarShift(NULL, Timeframe8, time[i]);
         if (shift8 >= 0)
            MABuffer8[i] = iMA(NULL, Timeframe8, Period8, 0, MAType8, MAPrice8, shift8); }
      case MA7: {
         int shift7 = iBarShift(NULL, Timeframe7, time[i]);
         if (shift7 >= 0)
            MABuffer7[i] = iMA(NULL, Timeframe7, Period7, 0, MAType7, MAPrice7, shift7); }
      case MA6: {
         int shift6 = iBarShift(NULL, Timeframe6, time[i]);
         if (shift6 >= 0)
            MABuffer6[i] = iMA(NULL, Timeframe6, Period6, 0, MAType6, MAPrice6, shift6); }
      case MA5: {
         int shift5 = iBarShift(NULL, Timeframe5, time[i]);
         if (shift5 >= 0)
            MABuffer5[i] = iMA(NULL, Timeframe5, Period5, 0, MAType5, MAPrice5, shift5); }
      case MA4: {
         int shift4 = iBarShift(NULL, Timeframe4, time[i]);
         if (shift4 >= 0)
            MABuffer4[i] = iMA(NULL, Timeframe4, Period4, 0, MAType4, MAPrice4, shift4); }
      case MA3: {
         int shift3 = iBarShift(NULL, Timeframe3, time[i]);
         if (shift3 >= 0)
            MABuffer3[i] = iMA(NULL, Timeframe3, Period3, 0, MAType3, MAPrice3, shift3); }
      case MA2: {
         int shift2 = iBarShift(NULL, Timeframe2, time[i]);
         if (shift2 >= 0)
            MABuffer2[i] = iMA(NULL, Timeframe2, Period1, 0, MAType2, MAPrice2, shift2); }
      case MA1: {
         int shift1 = iBarShift(NULL, Timeframe1, time[i]);
         if (shift1 >= 0)
            MABuffer1[i] = iMA(NULL, Timeframe1, Period1, 0, MAType1, MAPrice1, shift1); }
      default: {
         int shift1 = iBarShift(NULL, Timeframe1, time[i]);
         if (shift1 >= 0)
            MABuffer1[i] = iMA(NULL, Timeframe1, Period1, 0, MAType1, MAPrice1, shift1); }
      }      
   }
    return(rates_total);
  }
//-----------------------------------------------------------------------------------------------------------------
