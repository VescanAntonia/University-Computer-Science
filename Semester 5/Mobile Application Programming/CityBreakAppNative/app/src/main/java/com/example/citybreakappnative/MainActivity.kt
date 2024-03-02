package com.example.citybreakappnative

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.tooling.preview.Preview
//import com.example.citybreakappnative.ui.theme.CityBreaksAppNativeTheme
import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.view.Window
import android.widget.Button
import androidx.core.content.ContextCompat
import com.example.citybreakappnative.data.ListViewCityBreak

class MainActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        supportActionBar?.hide()
        val window:Window=this@MainActivity.window
        window.statusBarColor=ContextCompat.getColor(this@MainActivity,R.color.black)

        val startButton=findViewById<Button>(R.id.startButton);
        startButton.setOnClickListener{goToList()}
    }

    private fun goToList(){
        val intent=Intent(this,ListViewCityBreak::class.java)
        startActivity(intent);
    }
}
