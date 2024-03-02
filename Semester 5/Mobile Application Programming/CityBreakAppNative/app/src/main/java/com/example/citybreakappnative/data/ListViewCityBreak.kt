package com.example.citybreakappnative.data

import android.app.Activity
import android.content.Intent

import androidx.recyclerview.widget.LinearLayoutManager
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.Window
import android.widget.ImageView
import android.widget.Toast
import androidx.activity.result.contract.ActivityResultContracts
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import androidx.recyclerview.widget.GridLayoutManager
import com.example.citybreakappnative.R
import com.example.citybreakappnative.adapter.ItemAdapter
import com.example.citybreakappnative.model.CityBreak
import com.example.citybreakappnative.service.AddCityBreakActivity
import com.example.citybreakappnative.databinding.ActivityListCitybreakBinding // Import the ViewBinding class
import java.time.LocalDate
import java.time.format.DateTimeFormatter
class ListViewCityBreak : AppCompatActivity() {
    private val cityBreaks = mutableListOf<CityBreak>()
    lateinit var addButton: ImageView
    private lateinit var binding: ActivityListCitybreakBinding // ViewBinding

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onCreate(savedInstanceState: Bundle?) {
        //initialize the view binding
        super.onCreate(savedInstanceState)
        binding = ActivityListCitybreakBinding.inflate(layoutInflater) // Initialize ViewBinding
        val view = binding.root
        setContentView(view)


        supportActionBar?.hide()
        val window: Window = window
        window.statusBarColor = ContextCompat.getColor(this, R.color.black)

        initCityBreaks()

        //sets up recycler view and attaches the item adapter
        binding.recyclerView.layoutManager = GridLayoutManager(this, 1) // or any other number of columns you prefer

        //binding.recyclerView.layoutManager = LinearLayoutManager(this)
        binding.recyclerView.adapter = ItemAdapter(this, cityBreaks)

        addButton = binding.addCityBreak

        addButton.setOnClickListener {
            val intent = Intent(applicationContext, AddCityBreakActivity::class.java)
            startActivityForResult(intent, 3)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == 3) {
            if (resultCode == Activity.RESULT_OK) {
                if (data != null) {
                    val bundle = data.getBundleExtra("cityBreakBundle")
                    val cityBreak = bundle?.getParcelable<CityBreak>("cityBreak")
                    if (cityBreak != null) {
                        addCityBreakToList(cityBreak)
                    }
                }
                Toast.makeText(this, "Added!", Toast.LENGTH_SHORT).show()
                binding.recyclerView.adapter?.notifyItemInserted(cityBreaks.size - 1)
            }
        } else if(requestCode == 5){
            if(resultCode == Activity.RESULT_OK){
                if(data != null){
                    val bundle = data.getBundleExtra("cityBreakBundle")
                    val cityBreak = bundle?.getParcelable<CityBreak>("cityBreak")
                    val id = data.getIntExtra("id", -1)
                    if(cityBreak != null && id != -1){
                        updateCityBreak(cityBreak, id)
                    }
                }
            }
        }
    }

    private fun updateCityBreak(cityBreak: CityBreak, id: Number) {
        //update
        for(i in 0 until cityBreaks.size){
            if(cityBreaks[i].id == id){
                cityBreaks[i] = cityBreak
                Toast.makeText(this, "Updated!", Toast.LENGTH_SHORT).show()
                binding.recyclerView.adapter?.notifyItemChanged(i)
            }
        }
    }

    private fun addCityBreakToList(cityBreak: CityBreak) {
        //add
        cityBreaks.add(cityBreak)
        val position = cityBreaks.size - 1
        binding.recyclerView.adapter?.notifyItemInserted(position)
        Log.d("AddCityBreakToList", "City break added: $cityBreak")
    }

    fun getId(): Number {
        return cityBreaks.size + 1
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun initCityBreaks() {

        val formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy")

        val cityBreak1 = CityBreak(
            "Paris",
            "France",
            LocalDate.parse("19-06-2023", formatter),
            LocalDate.parse("24-06-2023", formatter),
            "Very beautiful city.",
            "Palace Hotel",
            199
        )
        val cityBreak2 = CityBreak(
            "Rome",
            "Italy",
            LocalDate.parse("19-06-2023", formatter),
            LocalDate.parse("24-06-2023", formatter),
            "Very beautiful city.",
            "Palace Hotel",
            200
        )
        val cityBreak3 = CityBreak(
            "London",
            "UK",
            LocalDate.parse("19-06-2023", formatter),
            LocalDate.parse("24-06-2023", formatter),
            "Very beautiful city.",
            "Palace Hotel",
            200
        )
        val cityBreak4 = CityBreak(
            "Napoli",
            "Italy",
            LocalDate.parse("19-06-2023", formatter),
            LocalDate.parse("24-06-2023", formatter),
            "Very beautiful city.",
            "Palace Hotel",
            200
        )
        val cityBreak5 = CityBreak(
            "Bucharest",
            "Romania",
            LocalDate.parse("19-06-2023", formatter),
            LocalDate.parse("24-06-2023", formatter),
            "Very beautiful city.",
            "Palace Hotel",
            200
        )
        val cityBreak6 = CityBreak(
            "Madrid",
            "Spain",
            LocalDate.parse("19-06-2023", formatter),
            LocalDate.parse("24-06-2023", formatter),
            "Very beautiful city.",
            "Palace Hotel",
            200
        )
        val cityBreak7 = CityBreak(
            "Amsterdam",
            "Netherlands",
            LocalDate.parse("19-06-2023", formatter),
            LocalDate.parse("24-06-2023", formatter),
            "Very beautiful city.",
            "Palace Hotel",
            200
        )


        cityBreaks.add(cityBreak1)
        cityBreaks.add(cityBreak2)
        cityBreaks.add(cityBreak3)
        cityBreaks.add(cityBreak4)
        cityBreaks.add(cityBreak5)
        cityBreaks.add(cityBreak6)
        cityBreaks.add(cityBreak7)
    }


}
