import java.util.ArrayList;

public class SymbolTable<T> {
    private final int capacity;
    private ArrayList<ArrayList<T>> elements;

    public SymbolTable(){
        this.capacity=5;
        this.elements=new ArrayList<>();
        for(int i=0;i<=this.capacity;i++){
            this.elements.add(new ArrayList<>());
        }
    }

    public int hashFunction(String key){
        int hashVal=0;
        for(int i=0;i<key.length();i++){
            hashVal+=(hashVal*31)+key.charAt(i);
        }
        return Math.abs(hashVal)%capacity;
    }

    public int hashFunction(Integer key){
        return key%capacity;
    }

    public int lookUp(T element){
        int bucketId=0;
        if(element instanceof Integer){
            bucketId=hashFunction((Integer) element);
        }
        if(element instanceof String){
            bucketId=hashFunction((String) element);
        }
        ArrayList<T> bucket= this.elements.get(bucketId);
        for(int i=0;i< bucket.size();i++){
            if(element.equals((bucket.get(i)))){
                return i;
            }
        }
        return -1;
    }

    public boolean add(T element){
        if(lookUp(element)!=-1){
            return false;
        }
        int givenPosition=0;
        if(element instanceof Integer){
            givenPosition=hashFunction((Integer) element);
        }
        if(element instanceof String){
            givenPosition=hashFunction((String) element);
        }
        ArrayList<T> bucket=this.elements.get(givenPosition);
        bucket.add(element);
        return true;
    }


    public int getSize() {
        return capacity;
    }

    public ArrayList<ArrayList<T>> getElements() {
        return elements;
    }

    @Override
    public String toString() {
        return "HashTable{" +
                "size=" + capacity +
                ", elements=" + elements +
                '}';
    }
}
