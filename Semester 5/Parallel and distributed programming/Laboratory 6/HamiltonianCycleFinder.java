import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.concurrent.Executors;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

public class HamiltonianCycleFinder {
    public Graph graph;
    public boolean isHamiltonian=false;

    public HamiltonianCycleFinder(Graph graph) {
        this.graph = graph;
    }

    public void beginSearch() {
        //initiates the search
        ArrayList<Integer> path = new ArrayList<>();
        try {
            path.add(0);
            search(0, path);
        } catch (Exception e) {
            e.printStackTrace();
        }
        if (isHamiltonian){
            System.out.println("The graph has a hamiltonian cycle.");
        }
        else{

            System.out.println("The graph does not have a hamiltonian cycle.");
        }
    }

    private boolean checkVisited(int node, List<Integer> path) {
        //check if node visited
        return path.contains(node);
    }

    private void search(int currentNode, ArrayList<Integer> path) throws Exception {
        // search recursively for a cycle using a parallelized approach
        // we can reach the first node from the current node and the length of the path (in number of nodes) is equal to the number of nodes
        if (graph.getEdgesForNode(currentNode).contains(0) && path.size() == graph.size()) {
            isHamiltonian=true;
            return;
        }

        // all nodes are visited but no solution is found
        if (path.size() == graph.size()) {
            return;
        }

        // check all possible vertices
        for (int i = 0; i < graph.size(); i++) {
            // if the node is not visited and there is an edge between the current node and the node
            // add it to the path and mark it as visited (remove the edge temporarily)
            if (graph.getEdgesForNode(currentNode).contains(i) && !checkVisited(i, path)) {
                path.add(i);
                graph.getEdgesForNode(currentNode).remove(Integer.valueOf(i));

                // search recursively for the current node on a new thread
                ThreadPoolExecutor executor = (ThreadPoolExecutor) Executors.newFixedThreadPool(4);
                final int node = i;
                final Runnable task = () -> {
                    try {
                        search(node, path);
                    } catch (Exception e) {
                        throw new RuntimeException(e.getMessage());
                    }
                };
                executor.execute(task);
                executor.shutdown();
                executor.awaitTermination(50, TimeUnit.SECONDS);

                // replace the removed edge so the paths can be explored correctly
                graph.getEdgesForNode(currentNode).add(i);
                //delete the path after it was checked
                path.remove(path.size() - 1);
            }
        }
    }
}