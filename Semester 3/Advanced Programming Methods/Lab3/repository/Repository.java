package repository;
import model.ITree;


public class Repository implements IRepository {
    private ITree[] trees;
    private int size;
    public Repository(int maxsize){
        this.size=0;
        this.trees= new ITree[maxsize];
    }
    public void add(ITree tree){
        try{
            this.trees[this.size]=tree;
            this.size++;
        }
        catch(Exception e){
            System.out.println(e.toString());
        }
    }

    public void remove(Integer position){
        try{
            ITree[] trees1 = new ITree[this.size-1];
            int current=0;
            for(int i=0;i<this.size;i++){
                if(i!=position){
                    trees1[current]=this.trees[i];
                    current++;
                }
            }
            this.trees=trees1;
            this.size--;
        }catch(Exception e){
            System.out.println(e.toString());
        }
    }
    public ITree[] getAll(){
        return this.trees;
    }
}
