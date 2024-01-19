public class SymbolTable {
    private final int size;
    private CustomHashTable<String> identifierHashTable;
    private CustomHashTable<Integer> intConstHashTable;
    private CustomHashTable<String> stringConstHashTable;

    public SymbolTable(int size) {
        this.size = size;
        this.identifierHashTable = new CustomHashTable<>(size);
        this.intConstHashTable = new CustomHashTable<>(size);
        this.stringConstHashTable = new CustomHashTable<>(size);
    }

    public int addIdentifier(String identifier) throws Exception {
        if(!identifierHashTable.contains(identifier))
            return identifierHashTable.addToHashTable(identifier);
        throw new Exception("Key " + identifier + " is already in the table!");
    }

    public int addIntConstant(Integer constant) throws Exception {
        if(!intConstHashTable.contains(constant))
            return intConstHashTable.addToHashTable(constant);
        throw new Exception("Key " + constant + " is already in the table!");
    }

    public int addStringConstant(String constant) throws Exception {
        if(!stringConstHashTable.contains(constant))
            return stringConstHashTable.addToHashTable(constant);
        throw new Exception("Key " + constant + " is already in the table!");
    }

    public boolean hasIdentifier(String identifier) {
        return identifierHashTable.contains(identifier);
    }

    public boolean hasIntConstant(Integer constant) {
        return intConstHashTable.contains(constant);
    }

    public boolean hasStringConstant(String constant) {
        return stringConstHashTable.contains(constant);
    }

    public int getIdentifierPosition(String identifier) {
        return identifierHashTable.getBucketPosition(identifier);
    }

    public int getIntConstantPosition(Integer constant) {
        return intConstHashTable.getBucketPosition(constant);
    }

    public int getStringConstantPosition(String constant) {
        return stringConstHashTable.getBucketPosition(constant);
    }

    public CustomHashTable getIdentifierHashTable(){
        return identifierHashTable;
    }

    public CustomHashTable getIntConstHashTable(){
        return intConstHashTable;
    }

    public CustomHashTable getStringConstHashTable(){
        return stringConstHashTable;
    }

    @Override
    public String toString() {
        return "SymbolTable: " +
                "identifierHashTable: \n" + identifierHashTable +
                "\n intConstantHashTable: \n" + intConstHashTable +
                "\n stringConstantHashTable: \n" + stringConstHashTable;
    }

//    public boolean contains(Value value) {
//        return hashTable.contains(value);
//    }
//
//    public boolean isEmpty() {
//        return hashTable.isEmpty();
//    }
//
//    public int getSize() {
//        return hashTable.size();
//    }
//
//    public int getPosition(Value value) {
//        List<Value> allValues = hashTable.getAllValues();
//        if(allValues.contains(value)) {
//            return allValues.indexOf(value);
//        }
//        return -1; //if value does not exist
//    }
//
//    public int getBucketPosition(Value value) {
//        int index = hashTable.getBucketPosition(value);
//        return index;
//    }
//
//    public CustomHashTable getHashTable(){
//        return hashTable;
//    }
}