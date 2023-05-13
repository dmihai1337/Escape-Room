/* 
    -------- ESCAPE ROOM --------
    
    Developer: Dancu Mihai-Andrei
*/


// window dimensions - meant to be played in 4:3 ratio
final int wwidth   = 800;
final int wheight  = 600;

// variables
color red_on          = color(255, 0, 0);
color red_off         = color(255, 0, 0, 50);
color black_on        = color(0);
color black_off       = color(0, 0, 0, 50);
color white_on        = color(255);
color white_off       = color(255, 255, 255, 50);
color green_on        = color(0, 255, 0);
color green_off       = color(0, 255, 0, 50);
color yellow_on       = color(255, 255, 0);
color yellow_off      = color(255, 255, 0, 50);
color dark_yellow_on  = color(188, 160, 0);
color dark_yellow_off = color(188, 160, 0, 50);
color gold_on         = color(216, 192, 92);
color gold_off        = color(216, 192, 92, 50);
color brown_on        = color(170, 132, 74);
color brown_off       = color(170, 132, 74, 50);
color dark_brown_on   = color(116, 91, 61, 255);
color dark_brown_off  = color(116, 91, 61, 50);
color grey_on         = color(200);
color grey_off        = color(200, 200, 200, 50);
color light_grey      = color(209, 206, 175);
color dark_grey       = color(80, 75, 69);

boolean light_on;
boolean door_open;
boolean safe_open;
boolean msg_view;
boolean drawer1_open;
boolean drawer2_open;
boolean painting_moved;
boolean key_control;
boolean game_over;
boolean rect1_active;
boolean rect2_active;
boolean rect3_active;
boolean rect4_active;

String rect1Value = "";
String rect2Value = "";
String rect3Value = "";
String rect4Value = "";

// door dimensions
float doorWidth  = wwidth / 6;
float doorHeight = 5 * wheight / 12;
float xDoor = 3 * wwidth / 4;
float yDoor = wheight / 3;

// exit sign dimensions
float xExit = xDoor - doorWidth / 4;
float yExit = yDoor - 3 * doorHeight / 4;
float exitWidth = doorWidth + doorWidth / 2;
float exitHeight = doorHeight / 4;

// switch dimensions
float xSwitch = wwidth / 8;
float ySwitch  = yDoor + doorHeight / 2;
float switchWidth = wwidth / 60;
float switchHeight = 1.5 * switchWidth;

// lamp dimensions
float xLamp = wwidth / 4;
float yLamp = 0;
float lampWidth = wwidth / 60;
float lampHeight = wheight / 8;

// safe dimensions
float safeSize = doorWidth;
float xSafe = 1.5 * xLamp + (0.75 * doorHeight / 1.5 - safeSize) / 2;
float ySafe = lampHeight * 2.55;
float rectHeight = safeSize / 8;
float rectWidth = 2 * rectHeight;
float xRect1 = xSafe + safeSize / 2 - rectWidth / 2;
float yRect1 = ySafe + safeSize / 16;
float xRect2 = xSafe + safeSize / 2 - rectWidth / 2;
float yRect2 = ySafe + safeSize / 4 + safeSize / 16;
float xRect3 = xSafe + safeSize / 2 - rectWidth / 2;
float yRect3 = ySafe + safeSize / 2 + safeSize / 16;
float xRect4 = xSafe + safeSize / 2 - rectWidth / 2;
float yRect4 = ySafe + 0.75 * safeSize + safeSize / 16;

// painting dimensions
float initialxPainting = 1.5 * xLamp;
float initialyPainting = lampHeight * 2.55;
float xPainting = initialxPainting;
float yPainting = initialyPainting;
float paintingHeight = 0.75 * doorHeight;
float paintingWidth = paintingHeight / 1.5;
float borderOffset = wwidth / 45;

// drawers dimensions
float xDrawers = xPainting + 1.5 * paintingWidth;
float yDrawers = yPainting + paintingHeight;
float drawersWidth = xExit - xDrawers;
float drawersHeight = 3 * wheight / 4 - yDrawers;

// letter dimensions
float letterSize = drawersWidth / 8;
float xLetter = xDrawers + drawersWidth / 2 - letterSize / 2;
float yLetter = yDrawers + letterSize / 2;

// key dimensions
float keyWidth  = safeSize / 4;
float initialxKey = xSafe + safeSize / 2 - keyWidth / 2;
float initialyKey = ySafe + safeSize / 2;
float xKey = initialxKey;
float yKey = initialyKey;
float keyCircleSize = wheight / 60;

void settings() {
  size(wwidth, wheight);
}

void setup() {
  game_over = false;
  light_on = false;
  door_open = false;
  safe_open = false;
  msg_view = false;
  key_control = false;
  drawer1_open = false;
  drawer2_open = false;
  painting_moved = false;
  rect1_active = false;
  rect2_active = false;
  rect3_active = false;
  rect3_active = false;
}

void draw() {
  draw_background();
  draw_ground();
  draw_door();
  draw_exit_sign();
  draw_switch();
  draw_lamp();
  draw_safe();
  draw_painting();
  draw_drawers();
  draw_letter();
  
  hint();
  logic();
}

void draw_door() {
  if(!door_open) {
    if(light_on)
      fill(dark_brown_on);
    else
      fill(dark_brown_off);
    rect(xDoor, yDoor, doorWidth, doorHeight);
    
    circle(xDoor + 3 * doorWidth / 4, yDoor + doorHeight / 2, 5);
  }
  else {
    fill(black_on);
    rect(xDoor, yDoor, doorWidth, doorHeight);
    fill(dark_brown_on);
    float x1 = xDoor;
    float y1 = yDoor + doorHeight;
    float x2 = xDoor;
    float y2 = yDoor;
    float x3 = xDoor + 3 * doorWidth / 4;
    float y3 = yDoor - doorHeight / 8;
    float x4 = xDoor + 3 * doorWidth / 4;
    float y4 = yDoor + doorHeight + doorHeight / 8;
    quad(x1, y1, x2, y2, x3, y3, x4, y4);
    
    circle(xDoor + doorWidth / 2, yDoor + doorHeight / 2, 5);
  }
}

void draw_ground() {
  strokeWeight(2);
  if(light_on)
    fill(dark_yellow_on);
  else
    fill(dark_yellow_off);
  rect(0, 3 * height / 4, width, height / 4);
}

void draw_background() {
  if(light_on)
    background(light_grey);
  else
    background(dark_grey);
}

void draw_exit_sign() {
  if(light_on)
    fill(green_on);
  else
    fill(green_off);
  
  rect(xExit, yExit, exitWidth, exitHeight);
  textAlign(CENTER);
  float textSizeSign = exitHeight;
  textSize(textSizeSign);
  
  if(light_on)
    fill(red_on);
  else
    fill(red_off);
  text("E X I T", xExit + exitWidth / 2, yExit + exitHeight / 2 + textSizeSign / 3);
}

void draw_switch() {
  if(light_on)
    fill(green_on);
  else
    fill(red_on);
  rect(xSwitch, ySwitch, switchWidth, switchHeight);
  
  strokeWeight(width / 60);
  if(light_on) {
    float x1 = xSwitch;
    float y1 = ySwitch;
    float x2 = xSwitch + switchWidth;
    float y2 = ySwitch;
    line(x1, y1, x2, y2);
  }
  else {
    float x1 = xSwitch;
    float y1 = ySwitch + switchHeight;
    float x2 = xSwitch + switchWidth;
    float y2 = ySwitch + switchHeight;
    line(x1, y1, x2, y2);
  }
  stroke(black_on);
  strokeWeight(2);
}

void draw_lamp() {
  if(light_on)
    fill(brown_on);
  else
    fill(brown_off);
  rect(xLamp, yLamp, lampWidth, lampHeight);
  
  float xLampArc = xLamp + lampWidth / 2;
  float yLampArc = lampHeight * 1.5;
  float lampArcWidth = width / 15;
  float lampArcHeight = lampHeight;
  arc(xLampArc, yLampArc, lampArcWidth, lampArcHeight, PI, TWO_PI);
  line(xLampArc - lampArcWidth / 2, yLampArc, xLampArc + lampArcWidth / 2, yLampArc);
  
  if(light_on) {
    stroke(yellow_on);
    
    // light ray 1
    line(xLampArc, 1.75 * lampHeight, xLamp + lampWidth / 2, 2 * lampHeight);
    
    // light ray 2
    line(xLampArc + lampArcWidth / 2, 1.75 * lampHeight, xLampArc + lampArcWidth, 2 * lampHeight);
    
    // light ray 2
    line(xLampArc - lampArcWidth / 2, 1.75 * lampHeight, xLampArc - lampArcWidth, 2 * lampHeight);
    
    stroke(black_on);
    fill(yellow_on);
  }
  else
    fill(yellow_off);
    
  arc(xLamp + lampWidth / 2, lampHeight * 1.5, width / 60, lampHeight / 5, 0, PI);
}

void draw_safe() {
  if(light_on) {
    if(!safe_open) {
      fill(grey_on);
      rect(xSafe, ySafe, safeSize, safeSize);
      fill(white_on);
  
      float textSizeSafe = rectHeight;
      textSize(textSizeSafe);
      
      rect(xRect1, yRect1, rectWidth, rectHeight);
      fill(black_on);
      text(rect1Value, xRect1 + rectWidth / 2, yRect1 + rectHeight / 2 + textSizeSafe / 3);
      fill(white_on);

      rect(xRect2, yRect2, rectWidth, rectHeight);
      fill(black_on);
      text(rect2Value, xRect2 + rectWidth / 2, yRect2 + rectHeight / 2 + textSizeSafe / 3);
      fill(white_on);

      rect(xRect3, yRect3, rectWidth, rectHeight);
      fill(black_on);
      text(rect3Value, xRect3 + rectWidth / 2, yRect3 + rectHeight / 2 + textSizeSafe / 3);
      fill(white_on);
    
      rect(xRect4, yRect4, rectWidth, rectHeight);
      fill(black_on);
      text(rect4Value, xRect4 + rectWidth / 2, yRect4 + rectHeight / 2 + textSizeSafe / 3);
      fill(white_on);
    }
    else {
      fill(grey_on);
      rect(xSafe, ySafe, safeSize, safeSize);

      float x1 = xSafe + safeSize;
      float y1 = ySafe;
      float x2 = xSafe + safeSize + safeSize / 4;
      float y2 = ySafe - safeSize / 8;
      float x3 = xSafe + safeSize + safeSize / 4;
      float y3 = ySafe + safeSize + safeSize / 8;
      float x4 = xSafe + safeSize;
      float y4 = ySafe + safeSize;
      quad(x1, y1, x2, y2, x3, y3, x4, y4);
      
      fill(dark_grey);
      float safeOffset = width / 60;
      float xInside = xSafe + safeOffset;
      float yInside = ySafe + safeOffset;
      rect(xInside, yInside, safeSize - 2 * safeOffset, safeSize - 2 * safeOffset);
      
      // ----------------- KEY ----------------- //
      if(key_control) {
        xKey = mouseX;
        yKey = mouseY;
      }
      else {
        xKey = initialxKey;
        yKey = initialyKey;
      }
      stroke(gold_on);
      strokeWeight(5);
      line(xKey, yKey, xKey + keyWidth, yKey);
      noFill();
      circle(xKey - keyCircleSize / 2, yKey, keyCircleSize);
      line(xKey + keyWidth / 2, yKey, xKey + keyWidth / 2, yKey + keyCircleSize / 2);
      line(xKey + keyWidth, yKey, xKey + keyWidth, yKey + keyCircleSize);
      stroke(black_on);
      strokeWeight(2);
    }
  }
}

void draw_painting() {
  if(light_on)
    fill(gold_on);
  else
    fill(gold_off);
  if(painting_moved)
    xPainting = initialxPainting / 2;
  else
    xPainting = initialxPainting;
  float xBorder = xPainting - borderOffset;
  float yBorder = yPainting - borderOffset;
  float fPaintingWidth = paintingWidth + 2 * borderOffset;
  float fPaintingHeight = paintingHeight + 2 * borderOffset;
    
  rect(xBorder, yBorder, fPaintingWidth, fPaintingHeight);
  PImage img = loadImage("painting.jpeg");
  if(light_on)
    tint(255);
  else
    tint(100);
  image(img, xPainting, yPainting, paintingWidth, paintingHeight);
}

void draw_drawers() {
  if(light_on)
    fill(brown_on);
  else
    fill(brown_off);
  rect(xDrawers, yDrawers, drawersWidth, drawersHeight);
  if(drawer1_open) {
    float x1 = xDrawers;
    float y1 = yDrawers;
    float x2 = xDrawers + drawersWidth;
    float y2 = yDrawers;
    float x3 = x2 + drawersWidth / 8;
    float y3 = y2 + drawersHeight / 4;
    float x4 = x1 - drawersWidth / 8;
    float y4 = y2 + drawersHeight / 4;
    if(light_on)
      fill(dark_brown_on);
    else
      fill(dark_brown_off);
    quad(x1, y1, x2, y2, x3, y3, x4, y4);
    if(light_on)
      fill(brown_on);
    else
      fill(brown_off);
    rect(x4, y4, drawersWidth + drawersWidth / 4, drawersHeight / 4);
    circle(xDrawers + drawersWidth / 2, yDrawers + 0.375 * drawersHeight, 5);
    circle(xDrawers + drawersWidth / 2, yDrawers + 0.75 * drawersHeight, 5);
    
    // ----------------- LETTER ----------------- //
    if(light_on) {
      fill(white_on);
      rect(xLetter, yLetter, letterSize, letterSize);
    }
  }
  else if(drawer2_open) {
    float x1 = xDrawers;
    float y1 = yDrawers + drawersHeight / 2;
    float x2 = xDrawers + drawersWidth;
    float y2 = yDrawers + drawersHeight / 2; 
    float x3 = x2 + drawersWidth / 8;
    float y3 = y2 + drawersHeight / 4;
    float x4 = x1 - drawersWidth / 8;
    float y4 = y2 + drawersHeight / 4;
    if(light_on)
      fill(dark_brown_on);
    else
      fill(dark_brown_off);
    quad(x1, y1, x2, y2, x3, y3, x4, y4);
    if(light_on)
      fill(brown_on);
    else
      fill(brown_off);
    rect(x4, y4, drawersWidth + drawersWidth / 4, drawersHeight / 4);
    circle(xDrawers + drawersWidth / 2, yDrawers + 0.25 * drawersHeight, 5);
    circle(xDrawers + drawersWidth / 2, yDrawers + 0.875 * drawersHeight, 5);
  }
  else {
    float x1 = xDrawers;
    float y1 = yDrawers + drawersHeight / 2;
    float x2 = xDrawers + drawersWidth;
    float y2 = yDrawers + drawersHeight / 2;
    line(x1, y1, x2, y2);
    circle(xDrawers + drawersWidth / 2, yDrawers + 0.25 * drawersHeight, 5);
    circle(xDrawers + drawersWidth / 2, yDrawers + 0.75 * drawersHeight, 5);
  }
}

void draw_letter() {
  if(msg_view) {
    fill(white_on);
    rect(width / 3, height / 3, width / 3, height / 3);
    float textSize = height / 40;
    textAlign(CENTER);
    textSize(textSize);
    fill(black_on);
    text("The red letters in this scene", width / 2, height / 2 - height / 32);
    text("shall be translated to base 16", width / 2, height / 2 + height / 32);
  }
}

void logic() {
  if(rect1Value.equals("45") && rect2Value.equals("58") && 
     rect3Value.equals("49") && rect4Value.equals("54"))
    safe_open = true;
  if(xKey >= xDoor && xKey  <= xDoor + doorWidth && 
     yKey >= yDoor && yDoor <= yDoor + doorHeight) {
       door_open = true;
       key_control = false;
       rect1Value = "";
       rect2Value = "";
       rect3Value = "";
       rect4Value = "";
       safe_open = false;
       painting_moved = false;
       game_over = true;
  }
}

void hint() {
  float textSizeHint = exitHeight / 3;
  textSize(textSizeHint);
  textAlign(CENTER);
  fill(white_on);
  if(painting_moved && light_on && !safe_open && !game_over)
    text("Click on each box to write the cipher!", width / 2, 0.875 * height);
  if(game_over)
    text("Good job! You have escaped!", width / 2, 0.875 * height);
}

void mousePressed() {
  if(!game_over) {
    if(msg_view) 
      msg_view = false;
    else if(!key_control){
      // click switch 
      if(mouseX >= xSwitch && mouseX <= xSwitch + switchWidth &&
         mouseY >= ySwitch && mouseY <= ySwitch + switchHeight) {
         light_on = !light_on;
         if(!light_on) {
           drawer1_open = false;
           drawer2_open = false;
         }
      }
      if(light_on) {
        // click 1st drawer
        if(mouseX >= xDrawers && mouseX <= xDrawers + drawersWidth &&
           mouseY >= yDrawers && mouseY <= yDrawers + drawersHeight / 2 &&
           !drawer2_open) {
             if(drawer1_open) {
               // click letter
               if(mouseX >= xLetter && mouseX <= xLetter + letterSize &&
                  mouseY >= yLetter && mouseY <= yLetter + letterSize &&
                  !msg_view)
                  msg_view = true;
               else
                  drawer1_open = false;
             }
             else
               drawer1_open = true;
        }
        // click 2nd drawer
        if(mouseX >= xDrawers && mouseX <= xDrawers + drawersWidth &&
           mouseY >= yDrawers + drawersHeight / 2 && mouseY <= yDrawers + drawersHeight &&
           !drawer1_open)
           drawer2_open = !drawer2_open;
        // click painting
        if(mouseX >= xPainting && mouseX <= xPainting + paintingWidth &&
           mouseY >= yPainting && mouseY <= yPainting + paintingHeight) {
             painting_moved = !painting_moved;
        }
        
        // click safe
        // click 1st box
        if(mouseX >= xRect1 && mouseX <= xRect1 + rectWidth &&
           mouseY >= yRect1 && mouseY <= yRect1 + rectHeight) {
             rect1_active = true;
             rect2_active = false;
             rect3_active = false;
             rect4_active = false;
        }    
        // click 2nd box
        if(mouseX >= xRect2 && mouseX <= xRect2 + rectWidth &&
           mouseY >= yRect2 && mouseY <= yRect2 + rectHeight) {
             rect1_active = false;
             rect2_active = true;
             rect3_active = false;
             rect4_active = false;
        }
        // click 3rd box
        if(mouseX >= xRect3 && mouseX <= xRect3 + rectWidth &&
           mouseY >= yRect3 && mouseY <= yRect3 + rectHeight) {
             rect1_active = false;
             rect2_active = false;
             rect3_active = true;
             rect4_active = false;
        }
        // click 4th box
        if(mouseX >= xRect4 && mouseX <= xRect4 + rectWidth &&
           mouseY >= yRect4 && mouseY <= yRect4 + rectHeight) {
             rect1_active = false;
             rect2_active = false;
             rect3_active = false;
             rect4_active = true;
        }
        // click key
        if(safe_open && mouseX >= xKey && mouseX <= xKey + keyWidth &&
           mouseY >= yKey - 2 * keyCircleSize && mouseY <= yKey + 2 * keyCircleSize / 2) {
             key_control = true;
        }
      }
    }
  }
}

void keyPressed() {
   if(!game_over) { 
     if(rect1_active) {
       if(key >= '0' && key <= '9') {
          if(rect1Value.length() < 2)
            rect1Value += key;
       }
       else if(key == BACKSPACE)
         if(rect1Value.length() > 0)
           rect1Value = rect1Value.substring(0, rect1Value.length() - 1);
     }
     if(rect2_active) {
       if(key >= '0' && key <= '9') {
          if(rect2Value.length() < 2)
            rect2Value += key;
       }
       else if(key == BACKSPACE)
         if(rect2Value.length() > 0)
           rect2Value = rect2Value.substring(0, rect2Value.length() - 1);
     }
     if(rect3_active) {
       if(key >= '0' && key <= '9') {
          if(rect3Value.length() < 2)
            rect3Value += key;
       }
       else if(key == BACKSPACE)
         if(rect3Value.length() > 0)
           rect3Value = rect3Value.substring(0, rect3Value.length() - 1);
     }
     if(rect4_active) {
       if(key >= '0' && key <= '9') {
          if(rect4Value.length() < 2)
            rect4Value += key;
       }
       else if(key == BACKSPACE)
         if(rect4Value.length() > 0)
           rect4Value = rect4Value.substring(0, rect4Value.length() - 1);
      }
   }
}
