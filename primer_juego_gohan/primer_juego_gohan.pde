PImage fondo;
Gohan gohan;
N17 n17;
N18 n18;
ArrayList<PoderKi> ataques;

void setup() {
  size(800, 600);
  fondo = loadImage("fondo.png");
  gohan = new Gohan();
  n17 = new N17();
  n18 = new N18();
  ataques = new ArrayList<PoderKi>();
}

void draw() {
  background(0);
  image(fondo, 0, 0, width, height);
  gohan.mostrar();
  gohan.mover();
  n17.mostrar();
  n17.mover();
  n18.mostrar();
  n18.mover();
  
  // Mostrar y mover los ataques
  for (int i = 0; i < ataques.size(); i++) {
    PoderKi ataque = ataques.get(i);
    ataque.mostrar();
    ataque.mover();
    // Verificar colisiones
    if (ataque.colision(gohan)) {
      println("¡Colisión con un ataque!");
      // Aquí podrías hacer algo cuando hay una colisión, como reducir la vida del jugador
    }
    // Eliminar ataques que salieron de la pantalla
    if (ataque.y > height) {
      ataques.remove(i);
    }
  }
  
  // Generar ataques aleatorios
  if (frameCount % 60 == 0) { // Generar un ataque cada segundo
    generarAtaque();
  }
}

void generarAtaque() {
  int x = (int) random(width);
  int y = -50; // Comienza desde arriba
  PoderKi ataque = new PoderKi(x, y);
  ataques.add(ataque);
}

class Gohan {
  PImage imagen;
  float x, y;
  
  Gohan() {
    imagen = loadImage("gohan.png");
    imagen.resize(50, 0); 
    x = width/2;
    y = height - imagen.height - 10;
  }
  
  void mostrar() {
    image(imagen, x, y);
  }
  
  void mover() {
    if (keyPressed) {
      if (key == 'a' || key == 'A') { // Mover a la izquierda
        x -= 5;
      } else if (key == 'd' || key == 'D') { // Mover a la derecha
        x += 5;
      }
    }
    // Limitar el movimiento dentro de la pantalla
    x = constrain(x, 0, width - imagen.width);
  }
}

class N17 {
  PImage imagen;
  float x, y;
  float velocidad = 2;
  int direccion = 1; // 1 para moverse hacia la derecha, -1 para moverse hacia la izquierda
  
  N17() {
    imagen = loadImage("n17.png");
    imagen.resize(50, 0);
    x = 0;
    y = 50;
  }
  
  void mostrar() {
    image(imagen, x, y);
  }
  
  void mover() {
    x += velocidad * direccion;
    // Rebotar en los bordes
    if (x < 0 || x > width - imagen.width) {
      direccion *= -1;
    }
  }
}

class N18 {
  PImage imagen;
  float x, y;
  float velocidad = 2;
  int direccion = -1; // -1 para moverse hacia la izquierda, 1 para moverse hacia la derecha
  
  N18() {
    imagen = loadImage("n18.png");
    imagen.resize(50, 0);
    x = width - imagen.width;
    y = 50;
  }
  
  void mostrar() {
    image(imagen, x, y);
  }
  
  void mover() {
    x += velocidad * direccion;
    // Rebotar en los bordes
    if (x < 0 || x > width - imagen.width) {
      direccion *= -1;
    }
  }
}

class PoderKi {
  PImage imagen;
  float x, y;
  float velocidad = 5;
  
  PoderKi(float x, float y) {
    imagen = loadImage("poder_ki.png");
    imagen.resize(30, 0);
    this.x = x;
    this.y = y;
  }
  
  void mostrar() {
    image(imagen, x, y);
  }
  
  void mover() {
    y += velocidad;
  }
  
  boolean colision(Gohan gohan) {
    // Verificar colisión con el rectángulo del jugador
    return (x + imagen.width > gohan.x && 
            x < gohan.x + gohan.imagen.width &&
            y + imagen.height > gohan.y &&
            y < gohan.y + gohan.imagen.height);
  }
}
