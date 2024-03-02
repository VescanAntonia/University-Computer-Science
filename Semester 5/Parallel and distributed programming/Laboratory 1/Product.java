public class Product {

    private final String productName;
    private final float price;
//    private int quantity;

    public Product(String productName,float price){
        this.productName=productName;
        this.price=price;
//        this.quantity=quantity;
    }

    public String getProductName() {
        return productName;
    }

    public float getPrice() {
        return price;
    }

//    public int getQuantity() {
//        return quantity;
//    }

//    public void setQuantity(int quantity) {
//        this.quantity = quantity;
//    }
}
