import java.util.ArrayList;
import java.util.List;

public class CustomHashTable<Value> {
    private static final int DEFAULT_CAPACITY = 5;
    private List<Value>[] table;

    public CustomHashTable() {
        this(DEFAULT_CAPACITY);
    }

    public CustomHashTable(int capacity) {
        table = new ArrayList[capacity];
        for(int index = 0; index < capacity; index++) {
            table[index] = new ArrayList<>();
        }
    }

    private int hashFunction(Value value) {
        int sum = 0;
        for(char c : value.toString().toCharArray()) {
            sum = sum + (int) c;
        }
        return sum % table.length;
    }

    public int addToHashTable(Value value) throws Exception{
        int index = hashFunction(value);
        List<Value> bucket = table[index];
        bucket.add(value);
        return index;
    }

    public boolean contains(Value value) {
        int index = hashFunction(value);
        List<Value> bucket = table[index];
        return bucket.contains(value);
    }

    public boolean isEmpty() {
        for(List<Value> bucket : table) {
            if(!bucket.isEmpty()) {
                return false;
            }
        }
        return true;
    }

    public int size() {
        int tableSize = 0;
        for(List<Value> bucket : table) {
            tableSize += bucket.size();
        }
        return tableSize;
    }

//    public int getPosition(Value value) {
//        int index = hashFunction(value);
//        return index;
//    }

    public List<Value> getAllValues() {
        List<Value> allValues = new ArrayList<>();
        for(List<Value> bucket : table) {
            allValues.addAll(bucket);
        }
        return allValues;
    }

    public int getBucketPosition(Value value) {
        int index = hashFunction(value);
        return index;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        for (int index = 0; index < table.length; index++) {
            sb.append("Bucket: ").append(index).append(": ");
            List<Value> bucket = table[index];
            for (Value value : bucket) {
                sb.append(value).append(" -> ");
            }
            sb.append("null\n");
        }
        return sb.toString();
    }
}