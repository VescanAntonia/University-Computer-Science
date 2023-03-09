module com.example.proceduressleep {
    requires javafx.controls;
    requires javafx.fxml;


    opens com.example.proceduressleep to javafx.fxml;
    exports com.example.proceduressleep;
}