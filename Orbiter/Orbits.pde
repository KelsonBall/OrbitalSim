public class OrbitState{
    public static final double G = 0.001;
    public int date = 0;
    public G2Vector position;
    public G2Vector velocity;
    
    public OrbitState(G2Vector position, G2Vector velocity, int date){
        this.date = date;   
        this.position = position;
        this.velocity = velocity;
    }
    
    public OrbitState(PVector position, PVector velocity){
        this.position = new G2Vector(position);
        this.velocity = new G2Vector(velocity);
    }
    
    public OrbitState(G2Vector position, G2Vector velocity){
        this.position = position;
        this.velocity = velocity;
    }
    
    public OrbitState next(){
        G2Vector nP = this.position.copy();        
        G2Vector dV = this.velocity.copy();
        for (Body body : Planets){
            dV.add(body.getAccelerationOnPoint(nP, this.date));
        }
        nP.add(dV);
        return new OrbitState(nP, dV);
    }
}

public class Orbit{    
    private OrbitBuffer buffer;        
    private Body self;
    
    public Orbit(OrbitState state){
        this.buffer = new OrbitBuffer();
        this.buffer.pushTail(state);
        this.buffer.fill();
    }
    
    public void setBody(Body self){
        this.self = self; 
    }
    
    public void recalculate(){
        this.buffer.update(); 
    }
    
    public void update(){        
        this.buffer.rotate();
    }
    
    public void accelerate(G2Vector accel){
        this.buffer.readHead().velocity.add(accel);
        this.buffer.update();
    }
    
    public G2Vector position(int offset){
        return this.buffer.stateAt(offset).position.copy(); 
    }
    
    public G2Vector position(){
        return this.buffer.readHead().position.copy(); 
    }
        
    public void Draw(){
        pushMatrix();
            float s = Transforms.peek().scale;
            translate(-Transforms.peek().offset.x*s, -Transforms.peek().offset.y*s);            
            pushStyle();
                noFill();       
                int r = 80;
                int g = 180; 
                int b = 80;                
                strokeWeight(1.5);
                OrbitState previous = null;
                int skip = 0;
                int count = 0;
                OrbitState state;
                for (int i = 1; i < 1000; i++){
                    stroke(r, g, b);
                    if (g > 80 && i%4 == 0){
                      g--; 
                    }
                    state = this.buffer.stateAt(i);
                    if (previous == null){
                        previous = state;   
                    } else {
                        if (skip < 3){
                           skip++;
                           continue;
                        }
                        skip = 0;                        
                        line((float)previous.position.x()*s, (float)previous.position.y()*s, (float)state.position.x()*s, (float)state.position.y()*s);
                        previous = state;
                    }
                    count++;                    
                                                          
                }
            popStyle();
        popMatrix();
    }
}