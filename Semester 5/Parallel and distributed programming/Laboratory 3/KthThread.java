public class KthThread implements Runnable{
    //a thread responsible for computing the product of specific cells
    //it uses a step size to det the columns each thread should handle
    private final Integer[][] res; //the result matrix
    private final Integer k; // the thread's column index
    private final Integer stepSize; // the step size for column traversal

    KthThread(Integer[][] res, int k, int stepSize) {
        this.res = res;
        this.k = k;
        this.stepSize = stepSize;
    }

    @Override
    public void run() {
        int n = Main.a;
        int m = Main.c;
        int i = 0;
        int j = k; //current column index
        while (true) {
            int overshoot = j/m; //nr of rows to skip over
            i += overshoot;
            j -= overshoot * m;
            if (i >= n)
                break;   //break if everything is processed
            res[i][j] = Matrix.getProductCell(Main.m1, Main.m2, i, j);
            j += stepSize;  //move to the next one
        }
    }
}