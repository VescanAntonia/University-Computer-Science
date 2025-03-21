/**
 * This class is the task for the simple multiplication, with time complexity O(n^2)
 */
public class MultiplicationTask implements Runnable {
    // represent the range of coefficients
    private int start;
    private int end;
    private Polynomial p1, p2, result;

    public MultiplicationTask(int start, int end, Polynomial p1, Polynomial p2, Polynomial result) {
        this.start = start;
        this.end = end;
        this.p1 = p1;
        this.p2 = p2;
        this.result = result;
    }

    /**
     * performs the polynomial multiplication within the specified range [start, end]
     */
    @Override
    public void run() {
        for (int index = start; index < end; index++) {
            //case - no more elements to calculate
            if (index > result.getLength()) {
                return;
            }
            //find all the pairs that we add to obtain the value of a result coefficient
            for (int j = 0; j <= index; j++) {
                if (j < p1.getLength() && (index - j) < p2.getLength()) {
                    int value = p1.getCoefficients().get(j) * p2.getCoefficients().get(index - j);
                    result.getCoefficients().set(index, result.getCoefficients().get(index) + value);
                }
            }
        }
    }
}