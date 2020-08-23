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

class Size {
  private float DISPLAY_RATIO = 0.8;

  private float _width;
  private float _height;

  Size(int imgWidth, int imgHeight) {
    // center image
    float ratio = 1.0;
    if ((imgWidth - imgHeight) < 0) {
      ratio = width / imgWidth;
    } else {
      ratio = height / imgHeight;
    }
    _width = img.width * ratio * DISPLAY_RATIO;
    _height = img.height * ratio * DISPLAY_RATIO;
  }

  public float getWidth() {
    return _width;
  }

  public float getHeight() {
    return _height;
  }
}

ArrayList<Grid> grids = new ArrayList<Grid>();
Size imgSize;

void setup() {
  // Bug on mac: https://github.com/processing/processing/issues/5791
  //size(200, 202);
  fullScreen();
  smooth();

  img = loadImage("zakuhead.png");
  imgSize = new Size(img.width, img.height);

  for (int x = 0; x < img.width; x++) {
    for (int y = 0; y < img.height; y++) {
      float gridW = imgSize.getWidth() / (float)img.width;
      float gridH = imgSize.getHeight() / (float)img.height;

      float posX = gridW * x;
      float posY = gridH * y;

      color c = img.pixels[y * img.width + x];
      grids.add(new Grid(posX, posY, c, gridW));
    }
  }
}

void draw() {
  background(255);
  translate(width/2 - imgSize.getWidth()/2, height/2 - imgSize.getHeight()/2);
  for (int i = 0; i < grids.size(); i++) {
    Grid g = grids.get(i);
    g.display();
  }
}
