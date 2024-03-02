import java.util.concurrent.locks.ReentrantLock;
import java.util.concurrent.locks.Lock;

public class Transaction extends Inventory implements  Runnable{

    private String name; //name of the transaction
    private float totalPrice=0.0f; //total price of a transaction
    private Boolean inventoryChanged;  //keep track of the inventory changes during the transaction
    private Inventory deposit; //reference to another Inventory obj
    public Lock _mutex= new ReentrantLock();   //ensuring that only one thread at a time can access the locked block

    public Transaction(Inventory deposit, String name){
        this.deposit=deposit;
        this.name=name;
    }
    @Override
    public void run() {
        //iterating through the products associated with the transaction, acquires a lock, removes the corresponding quantities of products from the deposit
        for(Product p:this.getProducts()){
            _mutex.lock();
            try{
                deposit.remove(p,this.getQuantity(p));
                System.out.println(this.name + ": took "+p.getProductName()+" -> "+String.valueOf(this.getQuantity(p)));
            }catch(Exception e){
                System.out.println(e.getMessage());
            }
            _mutex.unlock();
        }
    }

    @Override
    public void add(Product givenProduct, int givenQuantity){
        super.add(givenProduct,givenQuantity);
        inventoryChanged=true;
    }

    @Override
    public void remove(Product givenProduct,int givenQuantity) {
        super.remove(givenProduct,givenQuantity);
        inventoryChanged=true;
    }

    public String getName() {
        return name;
    }

    public float getTotalPrice() {
        //calculates the total price of the transaction
        if (inventoryChanged==null) return 0.0f;
        if (inventoryChanged){
            this.totalPrice=0;
            for(Product p:this.getProducts()){
                this.totalPrice+=this.getQuantity(p)*p.getPrice();
            }
            this.inventoryChanged=false;
        }
        return this.totalPrice;
    }

    public Boolean getInventoryChanged() {
        return inventoryChanged;
    }

    public Inventory getDeposit() {
        return deposit;
    }

    public Lock get_mutex() {
        return _mutex;
    }
}
