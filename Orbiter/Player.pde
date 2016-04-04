public static Player PLAYER;

public class Player extends Ship{
    public double DeltaV = 1;
    public double MaxDeltaV = 1;
    public double accel = 0.01;
    public double charge = 0.0005;
    
    private double rotation;
    
    
    public void Rotate(double delta){
        this.rotation += delta;
        if (this.rotation > 2 * Math.PI){
            this.rotation -= 2 * Math.PI;
        } else if (this.rotation < 0){
            this.rotation += 2 * Math.PI;   
        }
    }
    
    public Player(Orbit orbit){
        super(orbit);   
    }
    
    @Override
    public void Draw(){
        this.orbit.Draw();
        this.orbit.update();     
        this.orbit.recalculate();
        pushMatrix();            
            float s = Transforms.peek().scale;
            translate((this.orbit.position().getPVector().x - Transforms.peek().offset.x)*s,
                      (this.orbit.position().getPVector().y - Transforms.peek().offset.y)*s);
            pushMatrix();
              rotate((float)this.rotation);
              pushStyle();
                  strokeWeight(5);
                  stroke(140, 220, 140, 80);
                  line(0, 0, 12, 12);
                  fill(120,20,40);
                  noStroke();
                  float r = 5 * Transforms.peek().scale;
                  ellipse(0, 0, r, r);
              popStyle();
            popMatrix();             //<>//
        popMatrix();        
    }
    
    public void EvaluateInputs(){
        if (Keys.get('a')){
            this.Rotate(-0.05);   
        } else if (Keys.get('d')){
            this.Rotate(0.05);   
        }
        if (Keys.get('w')){
            if (this.DeltaV > 0){
                this.orbit.accelerate(new G2Vector(Math.cos(this.rotation) * this.accel, Math.sin(this.rotation) * this.accel));       
                this.DeltaV -= this.accel;
            }
        } else if (this.DeltaV < this.MaxDeltaV){
            this.DeltaV += this.charge;   
        }
    }
}