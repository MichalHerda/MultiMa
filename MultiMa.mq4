//+------------------------------------------------------------------+
//|                                                    MultiMAOnChart.mq4 |
//|                        Copyright 2023, MetaQuotes Software Corp. |
//|                                       http://www.metaquotes.net/ |
//+------------------------------------------------------------------+
#property indicator_chart_window
#property indicator_buffers 3
#property indicator_color1 Red
#property indicator_color2 Blue
#property indicator_color3 Green

//--- input parameters
input int MaPeriod1 = 14;
input int MaMethod1 = MODE_SMA;
input int MaPeriod2 = 14;
input int MaMethod2 = MODE_EMA;
input int MaPeriod3 = 14;
input int MaMethod3 = MODE_SMMA;

//--- indicator buffers
double MaBuffer1[];
double MaBuffer2[];
double MaBuffer3[];

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit()
  {
   //--- indicator buffers mapping
   SetIndexBuffer(0, MaBuffer1);
   SetIndexBuffer(1, MaBuffer2);
   SetIndexBuffer(2, MaBuffer3);

   //--- set buffer names
   IndicatorShortName("MultiMAOnChart");
   SetIndexLabel(0, "SMA");
   SetIndexLabel(1, "EMA");
   SetIndexLabel(2, "SMMA");

   //--- set drawing properties
   SetIndexStyle(0, DRAW_LINE);
   SetIndexStyle(1, DRAW_LINE);
   SetIndexStyle(2, DRAW_LINE);

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
   int i;

   //--- calculate the first moving average
   for(i = 0; i < rates_total; i++)
      MaBuffer1[i] = iMA(NULL, 0, MaPeriod1, 0, MaMethod1, PRICE_CLOSE, i);

   //--- calculate the second moving average
   for(i = 0; i < rates_total; i++)
      MaBuffer2[i] = iMA(NULL, 0, MaPeriod2, 0, MaMethod2, PRICE_CLOSE, i);

   //--- calculate the third moving average
   for(i = 0; i < rates_total; i++)
      MaBuffer3[i] = iMA(NULL, 0, MaPeriod3, 0, MaMethod3, PRICE_CLOSE, i);

   return(rates_total);
  }
//+------------------------------------------------------------------+
