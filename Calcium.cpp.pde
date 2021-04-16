#include <smartWaterIons.h>

// Connect the Calcium Sensor in the SOCKET1
// All Ion sensors can be connected in the four sockets
socket1Class calciumSensor;

// Calibration concentrations solutions used in the process
#define point1 10.0
#define point2 100.0
#define point3 1000.0

// Calibration Voltage values
#define point1_volt_Ca 2.163
#define point2_volt_Ca 2.296
#define point3_volt_Ca 2.425

// Define the number of calibration points
#define numPoints 3

float calConcentrations[] = {point1, point2, point3};
float calVoltages[] = {point1_volt_Ca, point2_volt_Ca, point3_volt_Ca}; 

void setup()
{
  // Turn ON the Smart Water Ions Board and USB
  SWIonsBoard.ON();
  USB.ON();  

  // Calculate the slope and the intersection of the logarithmic function
  calciumSensor.setCalibrationPoints(calVoltages, calConcentrations, numPoints);
}

void loop()
{
  // Reading of the Calcium sensor
  float calciumVoltage = calciumSensor.read();

  // Print of the results
  USB.print(F(" Calcium Voltage: "));
  USB.print(calciumVoltage);
  USB.print(F("volts |"));

  float concentration = calciumSensor.calculateConcentration(calciumVoltage);

  USB.print(F(" Ca concentration Estimated: "));
  USB.print(concentration);
  USB.println(F(" ppm / mg * L-1"));

  delay(1000);  
}


/*
 OUTPUT:
 H#
Calcium Voltage: 2.1878750324volts | Ca concentration Estimated: 37.4112319946 ppm / mg * L-1
Calcium Voltage: 2.1880011558volts | Ca concentration Estimated: 37.4724884033 ppm / mg * L-1
Calcium Voltage: 2.1878750324volts | Ca concentration Estimated: 37.4112319946 ppm / mg * L-1
*/

