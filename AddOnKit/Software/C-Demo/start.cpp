#include <stdio.h>            
#include <propeller.h>    
#include <ILI9341-spi.h>      

  
int main(){
  ILI9341_spi	disp;
  disp.Start(8, 7, 9, 10, 11);
  int x,y =0;
  int colors[] = {63519, 63488, 61440, 65535, 65504, 63488};
  int currentColor = colors[0]; 
  while(1) 
  {
    x+=10;
    disp.SetColours(0, currentColor);
    disp.ClearScreen();
    char * text = "Hello World!";
    disp.DrawString(x, x, (int32_t)text);
   
    if(x > 240)
    {
      y++;
      currentColor = colors[y % (sizeof(colors)/sizeof(*colors))];
      x=-60; 
    }      
    
    waitcnt((CNT + (CLKFREQ / 2)));
  }   
  return 0;
}
