float sigma;
float alpha;
float mu;
float vertScale = 20000;
final float sqrtTwoPi = sqrt(TWO_PI);
float StartX;

void setup() {
  size(400, 400);


  ellipseMode(CENTER);
  rectMode(CORNER);
  background(0);
}


void draw() {
  fill(0, 2);
  noStroke();
  rect(0, 0, width, height);

  noFill();
  colorMode(HSB);
  stroke(sigma%255, 255, 255);
  colorMode(RGB);
  strokeWeight(1);

  pushMatrix();
  scale(1, -1);
  translate(0, -1*height);
  sigma = map(mouseY, 0, height, 20, 400);
  sigma = constrain(sigma, 10, height);
  alpha = 1/(sigma*sqrtTwoPi);
  mu = mouseX;

  float gauss0 = gaussian(0, alpha, mu, sigma);
  float gauss1;
  for (int i = 1; i < width; i++) {
    gauss1 = gaussian(1.0*i, alpha, mu, sigma);
    line(i-1, vertScale*gauss0, i, vertScale*gauss1);
    gauss0 = gauss1;
    ellipse(i, vertScale*gauss1, 1, 0);
  }

  popMatrix();
  stroke(255,5);
  line(mouseX, 0, mouseX, height);
  fill(0);
  rect(0, 0, width, 25);
  fill(255);
  textAlign(LEFT);
  text("mean = " + (round(mu*1000)/1000.0) + "\n" + "st.dev. = " + round(sigma*1000)/1000., 10, 10);

}


float gaussian(float x, float a, float b, float c) {
  float g = a*exp(-1*sq(x - b)/(2*sq(c)));
  return g;
}
