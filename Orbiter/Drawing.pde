public static Stack<Transform> Transforms = new Stack<Transform>();

public class Transform{
    public boolean zoomEnabled = true;
    public float scale = 1.0;
    public boolean panEnabled = true;
    public PVector offset = new PVector();
}

public static class TUtils{
    private static float scaleGoal = 1.0;
    private static final float maxScale = 4.0;
    private static final float minScale = 0.25;
    
    public static float scale(){
        return Transforms.peek().scale;   
    }
    
    public static float scale(float set){
        if (set >= minScale && set <= maxScale){
            Transforms.peek().scale = set;
        }
        return TUtils.scale();
    }
    
    public static PVector offset(){
        return Transforms.peek().offset;   
    }
    
    public static void translate(double x, double y){
       translate((x - TUtils.offset().x) * TUtils.scale(), (y - TUtils.offset().y) * TUtils.scale());
    }
    
    public static void zoomOut(){
        println(scale(), scaleGoal);
        if (scaleGoal > minScale){
            scaleGoal -= 0.1;   
        }
    }
    
    public static void zoomIn(){
        println(scale(), scaleGoal);
        if (scaleGoal < maxScale){
            scaleGoal += 0.1;   
        }
    }
    
    public static void zoomStep(){
        float scaleDif = scaleGoal - scale();
        if (scale() > scaleGoal - 0.01){
            scale(scale() + scaleDif * 0.01);                       
        }
        if (scale() < scaleGoal + 0.01){
            scale(scale() + scaleDif * 0.01);            
        }
    }
}