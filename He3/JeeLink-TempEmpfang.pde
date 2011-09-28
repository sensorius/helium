/*
Empfang von Temperaturdaten mit dem JeeLink
by Carsten Dannat, http://www.it-trend.de

Credits: Jean-Claude Wippler, http://jeelabs.org/
http://opensource.org/licenses/mit-license.php
*/ 

#include <Ports.h>
#include <RF12.h>


typedef struct { int temp; } Payload;
Payload inData;


void setup ()
{
    Serial.begin(9600);	
    Serial.print("\n[www.it-trend.de]");
    Serial.print("\n[JeeLink Helium]");
    rf12_config();
}

static void consumeInData ()
{
  Serial.print("\n[Temperatur 0.1 Grad Celsius]: ");
  Serial.print(inData.temp,DEC);   
}

void loop ()
{
    if (rf12_recvDone() && rf12_crc == 0 && rf12_len == sizeof inData)
    {
        memcpy(&inData, (byte*) rf12_data, sizeof inData);
        consumeInData();
    }
}

