import java.util.List;

public class Production {
    private String key;
    private List<String> value;

    public Production(String key, List<String> value) {
        this.key = key;
        this.value = value;
    }

    public String getKey() {
        return key;
    }

    public List<String> getValue() {
        return value;
    }

    @Override
    public String toString() {
        return "Production{" +
                "key='" + key + '\'' +
                ", value=" + value +
                '}';
    }
}
