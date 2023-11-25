import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;

public class Grammar {
    private List<String> nonTerminals;
    private List<String> terminals;
    private List<Production> productions;
    private String startSymbol;
    private String filename;

    public Grammar(String filename) {
        this.nonTerminals=new ArrayList<>();
        this.terminals=new ArrayList<>();
        this.productions=new ArrayList<>();
        this.startSymbol=null;
        this.filename = filename;
    }

    public void initializeFromFile() throws IOException{
        try (BufferedReader reader = new BufferedReader(new FileReader(this.filename))) {
            String line;
            while ((line = reader.readLine()) != null) {
                line = line.trim();
                if (!line.isEmpty() && !line.startsWith("#")) {
                    if (line.startsWith("NonTerminals:")) {
                        String nonterminalsLine = line.split(":")[1].trim();
                        String[] nonterminalsArray = nonterminalsLine.split(", ");
                        nonTerminals.addAll(Arrays.asList(nonterminalsArray));
                    } else if (line.startsWith("Terminals:")) {
                        String terminalsLine = line.split(":")[1].trim();
                        String[] terminalsArray = terminalsLine.split(", ");
                        terminals.addAll(Arrays.asList(terminalsArray));
                    } else if (line.startsWith("Productions:")) {
                        while ((line = reader.readLine()) != null && !line.trim().isEmpty()) {
                            String[] parts = line.split("->");
                            if (parts.length == 2) {
                                String leftSide = parts[0].trim();
                                String[] rightSideSymbols = parts[1].trim().split("\\s+");
                                List<String> rightSide = Arrays.asList(rightSideSymbols);
                                productions.add(new Production(leftSide, rightSide));
                            } else {
                                throw new IllegalArgumentException("Invalid production: " + line);
                            }
                        }
                    } else if (line.startsWith("Starting symbol:")) {
                        startSymbol = line.split(":")[1].trim();
                    }
                }
            }
        }
    }

    public void printNonTerminals(){
        System.out.println("Non-terminals: " + nonTerminals);
    }

    public void printTerminals(){
        System.out.println("Terminals: " + terminals);
    }

}
