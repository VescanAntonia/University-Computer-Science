import java.util.HashMap;
import java.util.Set;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

public class Inventory {

    private final HashMap<Product,Integer> products;   //product->quantity
    public Inventory(){
        this.products=new HashMap<>();
    }

    public void add(Product givenProduct, int givenQuantity){
        //adds a given quantity of a product to the inventory
        //if it already exists=>update the quantity
        if(this.products.containsKey(givenProduct)){
            this.products.replace(givenProduct,this.products.get(givenProduct)+givenQuantity);
        }else{
            this.products.put(givenProduct,givenQuantity);
        }
    }

    public void remove(Product product, int quantity){
        //removes a given quantity for a given product
        if (this.products.containsKey(product)){
            if (this.getQuantity(product) < quantity){
                return;
            }
            this.products.replace(product, this.products.get(product) - quantity);
            if (this.getQuantity(product) == 0){
                this.products.remove(product);
            }

        }else{
            return;
            //throw new RuntimeException("Cannot remove quantity of inexistent product in inventory!");
        }
    }

    public Set<Product> getProducts(){
        return this.products.keySet();
    }

    public int getQuantity(Product product){
        return this.products.getOrDefault(product,0);
    }

    @Override
    public String toString(){
        StringBuilder toPrint=new StringBuilder();
        for(Product p:this.getProducts()){
            toPrint.append(String.format("{%s, %d}\n", p.getProductName(), this.getQuantity(p)));

        }
        return toPrint.toString();
    }

}
