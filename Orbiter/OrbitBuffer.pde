public class OrbitBuffer{
    private final int length = 1024;
    private OrbitState[] orbitData;
    private int head, tail = 0;
    
    public OrbitBuffer(){
        this.orbitData = new OrbitState[this.length]; 
    }
    
    public void pushTail(OrbitState state){
        this.orbitData[this.tail] = state;
        this.tail++;
        this.tail = this.tail % this.length;        
    }
    
    public OrbitState readTail(){
        int index = this.tail-1;
        if (index < 0){
          index += this.length - 1; 
        }
        return this.orbitData[ index ];
    }
    
    public OrbitState readHead(){
        return this.orbitData[ this.head ];
    }
    
    public OrbitState popHead(){
        OrbitState top = this.readHead();
        this.head += 1;
        this.head = this.head % this.length;
        return top;
    }
    
    public OrbitState stateAt(int delta){
        if (delta > 1000){
            return this.readTail(); 
        } else if (delta < 1){
            return this.readHead(); 
        }
        return this.orbitData[ (this.head + delta) % this.length ];
    }
    
    public void fill(){
        if (this.tail != 1 || this.head != 0){
            throw new IllegalStateException(); 
        }
        while (this.tail < 1000){
            this.pushTail( this.readTail() .next() );
        }
    }
    
    public OrbitState rotate(){
        this.stepDownTimes();
        this.pushTail( this.readTail() .next () );        
        return this.popHead();
    }
    
    public void update(){
        this.tail = this.head + 1;
        this.tail = this.tail % 1024;
        for (int i = 0; i < 1000; i++){
            this.pushTail( this.readTail() .next() );
        }
    }
    
    private void stepDownTimes(){
        for (int i = 0; i < 1000; i++){
            this.stateAt(i).date--; 
        }
    }
}