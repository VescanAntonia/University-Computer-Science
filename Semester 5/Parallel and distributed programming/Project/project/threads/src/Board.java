import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.*;

public final class Board {
    private static final int[] dx = new int[]{0, -1, 0, 1};
    private static final int[] dy = new int[]{-1, 0, 1, 0};
    private static final String[] movesStrings = new String[]{"left", "up", "right", "down"};

    private final byte[][] tiles;

    private final int numberOfSteps;
    private final int freeRowPosition;
    private final int freeColumnPosition;

    private final Board previouseState;
    private final int minimSteps;
    private final int estimation;
    private final int manhattan;
    private final String move;
    private final int hashValue;


    public Board(byte[][] tiles, int freeRowPosition, int freeColumnPosition, int numberOfSteps, Board previouseState, String move) {
        this.tiles = tiles;
        this.numberOfSteps = numberOfSteps;
        this.freeRowPosition = freeRowPosition;
        this.freeColumnPosition = freeColumnPosition;
        this.previouseState = previouseState;
        this.manhattan = manhattanDistance();
        this.minimSteps = numberOfSteps + manhattan;
        this.estimation = manhattan + numberOfSteps;
        this.move = move;
        this.hashValue = fakeHashCode();
    }

    public int manhattanDistance() {
        int distance = 0;
        for(int indexRow = 0; indexRow < 4; indexRow++) {
            for(int indexCol = 0; indexCol < 4; indexCol++) {
                if(tiles[indexRow][indexCol] != 0) {
                    int targetIndexRow = (tiles[indexRow][indexCol] - 1) / 4;
                    int targetIndexCol = (tiles[indexRow][indexCol] - 1) % 4;
                    distance += Math.abs(indexRow - targetIndexRow) + Math.abs(indexCol - targetIndexCol);
                }
            }
        }
        return distance;
    }

    public int fakeHashCode(){
        int result = 0;
        for(int index = 0; index < 4; index++){
            result += Arrays.hashCode(tiles[index]);
        }
        return result;
    }

    @Override
    public int hashCode(){
        return hashValue;
    }

    public static Board readFromFile() throws IOException{
        byte[][] tiles = new byte[4][4];
        int freeIndexRow = -1;
        int freeIndexCol = -1;
        Scanner scanner = new Scanner(new BufferedReader(new FileReader(new File("board.txt"))));
        for(int indexRow = 0; indexRow < 4; indexRow++) {
            for(int indexCol = 0; indexCol < 4; indexCol++) {
                tiles[indexRow][indexCol] = Integer.valueOf(scanner.nextInt()).byteValue();
                if(tiles[indexRow][indexCol] == 0) {
                    freeIndexRow = indexRow;
                    freeIndexCol = indexCol;
                }
            }
        }
        return new Board(tiles, freeIndexRow, freeIndexCol, 0, null, "");
    }

    public List<Board> generateMoves(){
        List<Board> moves = new ArrayList<>();
        for(int index = 0; index < 4; index++) {
            if(freeRowPosition + dx[index] >= 0 && freeRowPosition + dx[index] < 4 && freeColumnPosition + dy[index] >= 0 && freeColumnPosition + dy[index] < 4) {
                int movedFreeRowPosition = freeRowPosition + dx[index];
                int movedFreeColPosition = freeColumnPosition + dy[index];
                if(previouseState != null && movedFreeRowPosition == previouseState.freeRowPosition && movedFreeColPosition == previouseState.freeColumnPosition) {
                    continue;
                }
                byte[][] movedTiles = Arrays.stream(tiles)
                        .map(byte[]::clone)
                        .toArray(byte[][]::new);
                movedTiles[freeRowPosition][freeColumnPosition] = movedTiles[movedFreeRowPosition][movedFreeColPosition];
                movedTiles[movedFreeRowPosition][movedFreeColPosition] = 0;

                moves.add(new Board(movedTiles, movedFreeRowPosition, movedFreeColPosition, numberOfSteps + 1, this, movesStrings[index]));
            }
        }
        return moves;
    }

    public int getEstimation() {
        return estimation;
    }

    public int getMinimSteps() {
        return minimSteps;
    }

    public int getNumberOfSteps() {
        return numberOfSteps;
    }

    public int getManhattan() {
        return manhattan;
    }

    @Override
    public String toString() {
        Board currentBoard = this;
        List<String> strings = new ArrayList<>();
        while(currentBoard != null) {
            StringBuilder stringBuilder = new StringBuilder();
            stringBuilder.append("\n");
            stringBuilder.append(currentBoard.move);
            stringBuilder.append("\n");
            Arrays.stream(currentBoard.tiles).forEach(row -> stringBuilder.append(Arrays.toString(row)).append("\n"));
            stringBuilder.append("\n");
            strings.add(stringBuilder.toString());
            currentBoard = currentBoard.previouseState;
        }
        Collections.reverse(strings);
        return "Moves: " + String.join("", strings) + " number of steps: " + numberOfSteps;
    }
}
