import processing.serial.*;

Serial arduino;

void serialEvent(Serial port)
{
  curMillis = millis();
  int cm;
  int angle;
  byte[] buffer = new byte[bufSize];
  while(port.available() > 0) {
    int read = port.readBytes(buffer);
    if(buffer != null) {
      cm = (int(buffer[3]) << 24) | (int(buffer[2]) << 16) | (int(buffer[1]) << 8) | int(buffer[0]);
      cmDist = Float.intBitsToFloat(cm); // distance reading from arduino in centimeters
      angle = (int(buffer[7]) << 24) | (int(buffer[6]) << 16) | (int(buffer[5]) << 8) | int(buffer[4]);
      inputAng = Float.intBitsToFloat(angle); // motor angle reading from arduino in degrees
      if(cmDist > outerLimit) {
        dots.add(new Dot(cmDist, inputAng));
      }
    }
  }
}
