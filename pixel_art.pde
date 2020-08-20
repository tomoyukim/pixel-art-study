PImage img;

class Grid {
  private float _posX;
  private float _posY;
  private color _col;
  private float _size;

  private int _grayscale;  

  private float _dx;
  private float _dy;
  
  Grid(float posX, float posY, color col, float size) {
    float s = size/2.0;
    float f = random(-s, s);
    _posX = posX + f;
    _posY = posY + f;
    _col = col;
    _size = size;

    // https://ja.wikipedia.org/wiki/グレースケール#cite_note-5      
    _grayscale = round(red(_col) * 0.213 + green(_col) * 0.715 + blue(_col) * 0.072);
    
    _dx = 0;
    _dy = 0;
  }
  
  public void display() {
    float f1 = map(_grayscale, 0, 255, 1, 0.1);
    noStroke();
    fill(_col);
    _dx += random(-1, 1);
    _dy += random(-1, 1);
    square(_posX + _dx, _posY + _dy, _size * f1);    
  }
}

ArrayList<Grid> grids = new ArrayList<Grid>();

void setup() {
  // Bug on mac: https://github.com/processing/processing/issues/5791
  size(800, 600);
  smooth();  

  img = loadImage("zakuhead.png");
  
  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      float gridW = width / (float)img.width;
      float gridH = height / (float)img.height;
      
      float posX = gridW * x;
      float posY = gridH * y;
      
      color c = img.pixels[y * img.width + x];
      grids.add(new Grid(posX, posY, c, gridW));
    }
  }
}

void draw() {
  background(255);
  for (int i = 0; i < grids.size(); i++) {
    Grid g = grids.get(i);
    g.display();
  }
}
