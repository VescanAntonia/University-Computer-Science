import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.concurrent.*;

public class Main {
    private static final int NR_THREADS = 5;
    private static final int NR_TASKS = 5;

    private static ExecutorService executorService;

    public static void main(String[] args) throws IOException, InterruptedException, ExecutionException {
        Board initialState = Board.readFromFile();

        executorService = Executors.newFixedThreadPool(NR_THREADS);
        executorService.submit(Main::diagnosticsThread);

        Board solution = solve(initialState);
        System.out.println(solution);
        executorService.shutdown();
        executorService.awaitTermination(1000000, TimeUnit.SECONDS);
    }

    public static Board solve(Board root) throws ExecutionException, InterruptedException {
        long time = System.currentTimeMillis();
        int minBound = root.getManhattan();
        int distance;
        while(true) {
            Pair<Integer, Board> solution = searchParallel(root, 0, minBound, NR_TASKS);
            distance = solution.getFirst();
            if(distance == -1) {
                System.out.println("Solution found in: " + solution.getSecond().getNumberOfSteps() + " steps");
                System.out.println("Execution time: " + (System.currentTimeMillis() - time));
                return solution.getSecond();
            }
            else {
                System.out.println("Depth: " + distance + " reached in: " + (System.currentTimeMillis() - time));
            }
            minBound = distance;
        }
    }

    public static Pair<Integer, Board> searchParallel(Board currentBoard, int numberOfSteps, int bound, int nrThreads) throws ExecutionException, InterruptedException {
        if(nrThreads <= 1) {
            return search(currentBoard, numberOfSteps, bound);
        }

        int estimation = numberOfSteps + currentBoard.getManhattan();
        if(estimation > bound) {
            return new Pair<>(estimation, currentBoard);
        }
        if(estimation > 80) {
            return new Pair<>(estimation, currentBoard);
        }
        if(currentBoard.getManhattan() == 0) {
            return new Pair<>(-1, currentBoard);
        }

        int minim = Integer.MAX_VALUE;
        List<Board> moves = currentBoard.generateMoves();
        List<Future<Pair<Integer, Board>>> futures = new ArrayList<>();
        for(Board nextMove : moves) {
            Future<Pair<Integer, Board>> future = executorService.submit(() -> searchParallel(nextMove, numberOfSteps + 1, bound, nrThreads/moves.size()));
            futures.add(future);
        }

        for(Future<Pair<Integer, Board>> future : futures) {
            Pair<Integer, Board> result = future.get();
            int t = result.getFirst();
            if(t == -1) {
                return new Pair<>(-1, result.getSecond());
            }
            if(t < minim) {
                minim = t;
            }
        }
        return new Pair<>(minim, currentBoard);
    }

    public static Pair<Integer, Board> search(Board currentBoard, int numberOfSteps, int bound) {
        int estimation = numberOfSteps + currentBoard.getManhattan();
        if(estimation > bound) {
            return new Pair<>(estimation, currentBoard);
        }
        if(estimation > 80) {
            return new Pair<>(estimation, currentBoard);
        }
        if(currentBoard.getManhattan() == 0) {
            return new Pair<>(-1, currentBoard);
        }

        int minim = Integer.MAX_VALUE;
        Board solution = null;
        for(Board nextMove : currentBoard.generateMoves()) {
            if(true) {
                Pair<Integer, Board> result = search(nextMove, numberOfSteps + 1, bound);
                int t = result.getFirst();
                if(t == -1) {
                    return new Pair<>(-1, result.getSecond());
                }
                if(t < minim) {
                    minim = t;
                    solution = result.getSecond();
                }
            }
        }
        return new Pair<>(minim, solution);
    }

    public static void diagnosticsThread() {
        long startTime = System.currentTimeMillis();
        int k = 0;
        while (true) {
            Board head = null;
            if(head == null) {
                long endTime = System.currentTimeMillis();
                return;
            }
        }
    }
}