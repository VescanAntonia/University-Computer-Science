import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.*;
import java.util.regex.Pattern;

public class Scanner {
    private String program;
    private final List<String> tokens;

    private final List<String> reservedWords;
    private SymbolTable<String> identifiersST;
    private SymbolTable<Object> constantsST;
    private int index = 0;
    private ProgramInternalForm<String,Integer> PIF;
//    private Map<String, Integer> PIF;
    private int currentLine = 1;

    public Scanner() throws IOException {
        this.tokens = new ArrayList<>();
        this.PIF = new ProgramInternalForm<>();
        this.reservedWords = new ArrayList<>();
        this.identifiersST = new SymbolTable<>();
        this.constantsST = new SymbolTable<>();
        initializeTokens("token.in");

    }

    private void initializeTokens(String file) throws IOException {
        //loads and classifies the tokens into reserved words or tokens after reading them from file
        File path = new File(file);
        BufferedReader br = Files.newBufferedReader(path.toPath());
        String line;
        while ((line = br.readLine()) != null) {
            String[] elems = line.split(" ");
            String token = elems[0];

            // Categorize tokens into reserved words and separators,operators
            if (isReservedWord(token)) {
                reservedWords.add(token);
            } else {
                tokens.add(token);
            }
        }
    }

    private boolean isReservedWord(String token) {
        // Define a set of reserved words
        Set<String> reservedWordsSet = new HashSet<>(Arrays.asList("array", "char", "do", "else", "if", "int", "program", "input", "print", "while", "string", "boolean","for","str"));

        // Check if the token is in the set of reserved words
        return reservedWordsSet.contains(token);
    }

    public void writeOutputToFile(String fileName, String resultedOutput) throws IOException {
        //writes output to a file
        BufferedWriter writer = new BufferedWriter(new FileWriter(fileName));
        writer.write(resultedOutput);
        writer.close();
    }


    public void setProgram(String program) {
        // sets the source code program content
        this.program = program;
    }

    private void loadProgram(String programFileName) throws IOException {
        //- loads the program from a file and calls setProgram to set it
        Path file = Path.of(programFileName);
        setProgram(Files.readString(file));
        index = 0;
        currentLine = 1;
    }
    private void writeResultsToFiles(String programFileName) throws IOException {
        // writes contents of PIF,identifiersST, constantsST to corresponding output files
        writeOutputToFile("PIF" + programFileName.replace(".txt", ".out"), PIF.toString());
        writeOutputToFile("ST_IDENTIFIERS" + programFileName.replace(".txt", ".out"), identifiersST.toString());
        writeOutputToFile("ST_CONSTANTS" + programFileName.replace(".txt", ".out"), constantsST.toString());
    }

    public void scan(String programFileName) {
        // loads the program from the given file and performs lexical analysis on it
        try {
            loadProgram(programFileName);
            while (index < program.length()) {
                nextToken();
            }
            writeResultsToFiles(programFileName);
            System.out.println("Lexically correct");
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
    private void nextToken() {
        // skips the whitespaces, then identifies and processes the next token in the program and raise an error if an invalid token was found
        skipAndNextLine();
        if (index >= program.length()|| checkIdentifier()|| checkStringConstant()|| checkIntConstant()||(checkFromTokenList())) {
            // Successfully processed a token, so break the loop
            return;
        }
        // Move to the next character if no token was found
        index++;
        // If no valid token was found, raise an error
        throw new Error("Lexical error: invalid token at line " + currentLine + ", index " + index);
    }



    private int addConstantToST(String constant) {
        // adds a constant to the constants symbol table and return its position
        int position;
        try {
            constantsST.add(constant);
            position = constantsST.lookUp(constant);
        } catch (NumberFormatException e) {
            // Handle the exception if needed
            position = 0; // Set a default value or handle the error accordingly
        }
        return position;
    }

    private int addIdentifierToIdentifierST(String identifier) {
        // adds an identifier to the identifier symbol table and return its position
        int position;
        try {
            identifiersST.add(identifier);
            position = identifiersST.lookUp(identifier);
        } catch (Exception e) {
            // Handle the exception if needed
            position = 0; // Set a default value or handle the error accordingly
        }
        return position;
    }

    private boolean checkIntConstant() {
        // identifies and processes integer constants
        var regexForIntConstant = Pattern.compile("^([+-]?[1-9][0-9]*|0)");
        var matcher = regexForIntConstant.matcher(program.substring(index));

        if (matcher.find()) {
            var intConstant = matcher.group(1);
            index += intConstant.length();

            int position=addConstantToST(intConstant);

            PIF.addToPif("int const", position);
            return true;
        }

        return false;
    }

    private boolean checkStringConstant() {
        // identifies and processes string constants
        var regexForStringConstant = Pattern.compile("^\"[a-zA-z0-9_ ?:*^+=.!]*\"");
        var matcher = regexForStringConstant.matcher(program.substring(index));

        if (matcher.find()) {
            var stringConstant = matcher.group(0);
            index += stringConstant.length();

            int position=addConstantToST(stringConstant);

            PIF.addToPif("string const", position);
            return true;
        }

        return false;
    }


    private boolean checkIdentifier() {
        //  identifies and processes identifiers during lexical analysis.
        var regexForIdentifier = Pattern.compile("^([a-zA-Z_][a-zA-Z0-9_]*)");
        var matcher = regexForIdentifier.matcher(program.substring(index));

        if (matcher.find()) {
            var identifier = matcher.group(1);
            if (!checkIfValidToken(identifier, program.substring(index))) {
                return false;
            }
            index += identifier.length();

            int position=addIdentifierToIdentifierST(identifier);

            PIF.addToPif("identifier", position);
            return true;
        }

        return false;
    }


    private boolean checkFromTokenList() {
        // identifies and processes tokens that are recognized from reservedWords and tokens during lexical analysis
        String possibleToken = program.substring(index).split(" ")[0];

        for (var reservedToken : reservedWords) {
            if (possibleToken.startsWith(reservedToken)) {
                var regex = "^" + "[a-zA-Z0-9_]*" + reservedToken + "[a-zA-Z0-9_]+";
                if (Pattern.compile(regex).matcher(possibleToken).find()) {
                    return false;
                }

                index += reservedToken.length();
                PIF.addToPif(reservedToken, -1); //to specify it is a reservedword
                return true;
            }
        }

        for (var token : tokens) {
            if (Objects.equals(token, possibleToken)||possibleToken.startsWith(token)) {
                index += token.length();
                PIF.addToPif(token, -1); // Assuming -1 is a suitable placeholder value
                return true;
            }
        }

        return false;
    }



    private void skipAndNextLine() {
        //skips over the whitespaces and the new lines iterating currentLine and index
        while (index < program.length() && Character.isWhitespace(program.charAt(index))) {
            if (program.charAt(index) == '\n') {
                currentLine++;
            }
            index++;
        }
    }


    private boolean checkIfValidToken(String token, String textToCheck) {
        // checks if a given token is a valid token
        if (reservedWords.contains(token)) {
            return false;
        }
        if (Pattern.compile("^(?![0-9])[a-zA-Z_][a-zA-Z0-9_]*").matcher(textToCheck).find()) {
            return true;
        }
        return identifiersST.lookUp(token)!=-1;
    }

}

