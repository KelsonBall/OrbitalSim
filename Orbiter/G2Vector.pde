import java.math.*;

public class G2Vector {
    private double x;
    public double x(){
        return x;   
    }
    
    private double y;
    public double y(){
        return y;   
    }
    
    public G2Vector(double x, double y){
        this.set(x, y);   
    }
    
    public G2Vector(PVector origin){
        this.set(origin.x, origin.y);   
    }
    
    public G2Vector copy(){
        return new G2Vector(this.x, this.y);   
    }    
    
    public G2Vector set(double x, double y){
        this.x = x;
        this.y = y;
        return this;
    }
    
    public PVector getPVector(){
        return new PVector((float)this.x, (float)this.y);
    }
    
    public G2Vector add(G2Vector vec){
        this.x = this.x + vec.x;
        this.y = this.y + vec.y;
        return this;
    }
    
    public G2Vector sub(G2Vector vec){
        this.x = this.x - vec.x;
        this.y = this.y - vec.y;
        return this;
    }
    
    public G2Vector mult(double scalar){
        this.x = this.x * scalar;
        this.y = this.y * scalar;
        return this;
    }
    
    public double mag(){        
        return Math.sqrt(this.magSquared());
    }
    
    public double magSquared(){
        return (this.x * this.x) + (this.y * this.y);
    }
    
}