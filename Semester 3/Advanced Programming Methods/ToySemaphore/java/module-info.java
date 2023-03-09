module com.example.toysemaphore {
    requires javafx.controls;
    requires javafx.fxml;


    opens com.example.toysemaphore to javafx.fxml;
    exports com.example.toysemaphore;
}