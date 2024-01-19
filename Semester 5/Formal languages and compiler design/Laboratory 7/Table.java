import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class Table {
    private Map<Pair<String, String>, Pair<List<String>, Integer>> table = new HashMap<>();

    public void put(Pair<String, String> key, Pair<List<String>, Integer> value) {
        table.put(key, value);
    }

    public Pair<List<String>, Integer> get(Pair<String, String> key) {
        return table.entrySet()
                .stream()
                .filter(entry -> entry.getKey().equals(key) && entry.getValue() != null)
                .map(Map.Entry::getValue)
                .findFirst()
                .orElse(null);
    }

    public boolean containsKey(Pair<String, String> key) {
        boolean result = false;
        Set<Pair<String, String>> keys = table.keySet();
        for(Pair<String, String> k : keys) {
            if (k.getKey().equals(key.getKey()) && k.getValue().equals(key.getValue())) {
                result = true;
                break;
            }
        }
        return !result;
    }

    @Override
    public String toString() {
        String result = "";

        for (Map.Entry<Pair<String, String>, Pair<List<String>, Integer>> entry : table.entrySet()) {
            Pair<String, String> key = entry.getKey();
            Pair<List<String>, Integer> value = entry.getValue();

            if (value != null) {
                result += String.format("M[%s,%s] = [%s,%d]%n",
                        key.getKey(), key.getValue(), value.getKey(), value.getValue());
            }
        }

        return result;
    }
}