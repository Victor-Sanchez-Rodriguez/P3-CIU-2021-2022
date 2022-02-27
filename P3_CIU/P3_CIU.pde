String url;
ArrayList<Planet> planets;
int distance, planet_selected, i;
Planet sun;
float x, y, z, radius;
boolean has_moon, simulation_started, up_pressed, down_pressed;



void setup(){
  size(1920, 1080, P3D);
  url = "sun.jpg";
  distance = 150;
  x=0;
  y=0;
  z=0;
  i=0;
  radius = 80;
  sun = new Planet(x, y, z, radius, url, "Sol",false);  
  create_planets();
  
  //controls
  up_pressed=false;
  down_pressed=false;
  planet_selected=6; // 6 = all planets, 1 = innermost, 5 = outermost
}



void draw(){
  if(simulation_started){
    background(0);
    textSize(18);
    text("Pulsa M/ENTER para volver a inicio, planeta elegido: "+planet_selected,width/2,height/10);
    print_all();
  }else{
    print_welcome();
  }
}



void create_planets(){
  planets = new ArrayList<Planet>();
  url="planet.jpg";
  if(random(0,80)>45){
    has_moon=true;
  }else{
    has_moon=false;
  }
  planets.add(new Planet(x+distance + random(10,20), y + random(-10,10), z, random(25,50), url, "Planeta1", has_moon));
  if(random(0,80)>45){
    has_moon=true;
  }else{
    has_moon=false;
  }
  planets.add(new Planet(x+distance + random(120,150), y + random(-15,15), z, random(25,50), url, "Planeta2", has_moon));
  if(random(0,80)>45){
    has_moon=true;
  }else{
    has_moon=false;
  }
  planets.add(new Planet(x+distance + random(250,350), y + random(-20,20), z, random(25,50), url, "Planeta3", has_moon));
  if(random(0,80)>45){
    has_moon=true;
  }else{
    has_moon=false;
  }
  planets.add(new Planet(x+distance + random(500,630), y + random(-30,30), z, random(25,50), url, "Planeta4", has_moon));
  if(random(0,80)>45){
    has_moon=true;
  }else{
    has_moon=false;
  }
  planets.add(new Planet(x+distance + random(800,1000), y + random(-50,50), z, random(25,50), url, "Planeta5", has_moon));
}


void print_welcome(){
  background(128);
  textAlign(CENTER);
  textSize(32);
  text("Simulación de un sistema planetario simple",width/2,height/8); 
  text("Pulsa enter o 'M' para empezar",width/2,height/6);
  text("Pulsa 'R' para cambiar la configuración de los planetas",width/2,height/3.5);
  text("Pulsa del 1 al 5 para elegir planeta, o 6 para elegir a todos",width/2,height/2.6);
  text("Pulsa la tecla UP para acelerar el planeta elegido",width/2,height/2);
  text("Pulsa la tecla DOWN para detener el planeta elegido",width/2,height/1.7);
}


void print_all(){
  translate(width/2,height/2,0);
  rotateX(radians(-45));
  pushMatrix();
  sun.print_planet();
  sun.update_pos();
  translate(x,y,z);
  i=0;
  for (Planet planet : planets) {
    i++;
    if(planet_selected==i || planet_selected == 6){
      if(up_pressed){
        planet.update_pos_extra(true);
      } else if(down_pressed){
        planet.update_pos_extra(false);
      }
    }
    planet.print_planet();
    planet.update_pos();
  }
  popMatrix();
}


void keyPressed(){
  if(key == 'r' || key == 'R'){
    create_planets();
  }
  if(keyCode == ENTER || key == 'm' || key == 'M'){
    planet_selected=6;
    simulation_started = !simulation_started;
  }
  if(key == '1'){
    planet_selected=1;
  }
  if(key == '2'){
    planet_selected=2;
  }
  if(key == '3'){
    planet_selected=3;
  }
  if(key == '4'){
    planet_selected=4;
  }
  if(key == '5'){
    planet_selected=5;
  }
  if(key == '6'){
    planet_selected=6;
  }
  if(keyCode == UP){
    up_pressed=true;
  }
  if(keyCode == DOWN){
    down_pressed=true;
  }
}


void keyReleased(){
  if(keyCode == UP){
    up_pressed=false;
  }
  if(keyCode == DOWN){
    down_pressed=false;
  }
}




class Planet{
  private PShape planet_shape;
  private PImage planet_texture;
  private float x, y, z, radius, degrees, speed;
  private String name;
  private boolean has_moon;
  private Planet moon;
  
  Planet(float x, float y, float z, float radius, String url, String name, boolean has_moon){
    this.x = x;
    this.y = y;
    this.z = z;
    this.radius = radius;
    this.degrees = 0;
    this.speed = random(0.1, 1.0);
    this.name = name;
    this.planet_texture = loadImage(url);
    beginShape();
    this.planet_shape = createShape(SPHERE, this.radius);
    this.planet_shape.setStroke(255);
    this.planet_shape.setTexture(this.planet_texture);
    endShape(CLOSE);
    this.has_moon = has_moon;
    if(has_moon){
      url="moon.jpg";
      moon = new Planet(radius + random(25,40),y,z,random(10,20),url,"Luna",false);
      url="planet.jpg";
    }else{
      this.moon=null;
    }
  }

  
  void update_pos(){
    this.degrees += this.speed;
    if(this.degrees >=360) this.degrees -= 360;
  }
  
  
  void update_pos_extra(boolean positive){
    if(positive){
      this.degrees += this.speed;
      if(this.degrees >=360) this.degrees -= 360;
    } else{
      this.degrees -= this.speed;
      if(this.degrees <=0) this.degrees += 360;
    }
  }
  
  void print_planet(){
    pushMatrix();
    rotateY(radians(this.degrees));                      // update matrix to planet position
    translate(this.x, this.y, this.z);
    pushMatrix();
    rotateY(radians(-this.degrees));                    //  adjust for text
    rotateX(radians(45));
    text(this.name, 0, - (this.radius + 25));
    popMatrix();                                        // rollback text adjustment
    shape(this.planet_shape);
    if(this.has_moon){
      this.moon.update_pos();
      rotateY(radians(this.moon.degrees));              //  update matrix to moon position
      translate(this.moon.x, this.moon.y, this.moon.z);
      pushMatrix();
      rotateY(radians(-this.moon.degrees));
      rotateY(radians(-this.degrees));                  //  adjust for text
      rotateX(radians(45));
      text(this.moon.name, 0, - (this.moon.radius + 25));
      popMatrix();                                      //  rollback text adjustment
      shape(this.moon.planet_shape);
    }
    popMatrix();
  }
}
