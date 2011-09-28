/*
LM35 Temperaturmessung mit der JeeNode
by Carsten Dannat, http://www.it-trend.de

Credits: Jean-Claude Wippler, http://jeelabs.org/
http://opensource.org/licenses/mit-license.php
*/ 

#include <Ports.h>
#include <RF12.h>

int temp = 0;             // Temperatur in 0.1 Grad Celsius
int dataPin = 0;          // DatenLeitung des LM35;
int messungAnzahl = 5;    // Anzahl der Messungen für Mittelwertsbildung
int messungDelay = 1000;  // Messung alle n Millisekunden
int i;

void setup()
{
  Serial.begin(9600); 
  Serial.print("[www.it-trend.de]\n");
  Serial.print("[JeeNode LM35]\n\n");
  analogReference(INTERNAL);  // Spannungsversorgung LM35 auf 1.1 Volt setzen
  
  rf12_config();
  
  rf12_easyInit(5);
}

void loop()
{
  
 
  rf12_easyPoll();
    
  temp = 0;
  for(i = 0; i < messungAnzahl; i++)
  {
   
    temp = temp + analogRead(dataPin) / 0.931; // Abfrage des analogen Einganges
    delay(messungDelay); // Messung alle n Millisekunden 
  }

  temp = temp / messungAnzahl; // Mittelwert aus n Messungen

  Serial.print(temp,DEC);
  Serial.print(" [0.1 Grad Celsius]\n");
  
  byte value = temp;
  
  rf12_easySend(&temp, sizeof temp);
  
}
