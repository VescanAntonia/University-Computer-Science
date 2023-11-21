import java.util.ArrayList;
import java.util.List;

public class ProgramInternalForm<K, V> {
    private final ArrayList<List<Object>> programInternalForm;

    public ProgramInternalForm() {
        this.programInternalForm = new ArrayList<>();
    }

    public ArrayList<List<Object>> getProgramInternalForm() {
        return programInternalForm;
    }

    public void addToPif(K token, V pos) {
        List<Object> pair = new ArrayList<>();
        pair.add(token);
        pair.add(pos);
        this.programInternalForm.add(pair);
    }

    @Override
    public String toString() {
        StringBuilder stringBuilder = new StringBuilder();
        for (List<Object> pair : this.programInternalForm) {
            K token = (K) pair.get(0);
            V pos = (V) pair.get(1);
            stringBuilder.append("[").append(token).append(", ").append(pos).append("]\n");
        }
        return stringBuilder.toString();
    }
}
