import java.util.*;

public class Body{
    public Orbit orbit;    
    public int mass;
    public color fill;
    private double surfaceGravityRef;
    public Body(Orbit orbit, int mass){
        this.orbit = orbit;                
        this.mass = mass;
        this.fill = color(130, 130, 200);
        this.surfaceGravityRef = ((OrbitState.G * this.mass) / this.mass*0.5) + 1;
    }
    
    public void Draw(){
        this.orbit.Draw();
        CURRENT = this;
        this.orbit.update();  
        CURRENT = null;
        pushMatrix();
            float s = Transforms.peek().scale;                       
            translate((this.orbit.position().getPVector().x - Transforms.peek().offset.x)*s,
                      (this.orbit.position().getPVector().y - Transforms.peek().offset.y)*s);
            pushStyle();
                fill(this.fill);
                noStroke();                
                ellipse(0, 0, (this.mass/2.5)*s, (this.mass/2.5)*s);
                //fill(255);
                //text(Double.toString(this.getAccelerationOnPoint(PLAYER.orbit.position(), 1).mag()), 20, -20);
            popStyle();
        popMatrix();
    }
    
    public G2Vector getAccelerationOnPoint(G2Vector point, int date){
       if (CURRENT == this){
           return new G2Vector(0, 0);
       }
        G2Vector mutable = new G2Vector(point.x, point.y);
        if (mutable.sub(this.orbit.position(date)).mag() < (this.mass/5)){
            return new G2Vector(0, 0);
        }
        mutable = new G2Vector(point.x, point.y);
        double scalar = (OrbitState.G * this.mass) / mutable.sub(this.orbit.position(date)).magSquared();
        mutable = new G2Vector(point.x, point.y);
        G2Vector direction = this.orbit.position(date).copy().sub(mutable);
        return direction.mult(scalar);
    }
}

public class Ship extends Body{
    
    public Ship(Orbit orbit){
        super(orbit, 1);   
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
            pushStyle();
                fill(120,20,40);
                noStroke();
                float r = 3 * Transforms.peek().scale;
                ellipse(0, 0, r, r);
            popStyle();
        popMatrix();        
    }
}