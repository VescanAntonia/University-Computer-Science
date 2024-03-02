package com.example.appnative_db.service


import androidx.appcompat.app.AppCompatActivity
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.Window
import android.widget.Button
import android.widget.Toast
import androidx.annotation.RequiresApi
import androidx.core.content.ContextCompat
//import androidx.databinding.DataBindingUtil
import com.example.appnative_db.R
import com.example.appnative_db.databinding.AddCityBreakBinding
import com.example.appnative_db.model.CityBreak
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.time.format.DateTimeParseException

class AddCityBreakActivity : AppCompatActivity() {
    lateinit var cancelButton: Button;
    lateinit var saveButton: Button;
    lateinit var id: String;
    private lateinit var binding: AddCityBreakBinding

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onCreate(savedInstanceState: Bundle?) {
        val str = "ADD NOTE ACTIVITY"
        Log.i(str, "We are in add note")
        super.onCreate(savedInstanceState)
        setContentView(R.layout.add_city_break)
        binding = AddCityBreakBinding.inflate(layoutInflater)
        val view = binding.root
        setContentView(view)


        saveButton = binding.saveButtonCreate
        cancelButton = binding.cancelButtonCreate

        supportActionBar?.hide()

        val window: Window = this@AddCityBreakActivity.window
        window.statusBarColor = ContextCompat.getColor(this@AddCityBreakActivity, R.color.black)

        //initialize inputs and buttons
//        binding.idInputCreate.setText(CityBreak.currentId.toString())
//        binding.idInputCreate.isEnabled = false

        saveButton = binding.saveButtonCreate
        cancelButton = binding.cancelButtonCreate
        saveButton.setOnClickListener {
            addCityBreak()
        }

        cancelButton.setOnClickListener {
            goBack()
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun addCityBreak() {
        if (checkInputs()) {
            val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd")

            val cityBreak = CityBreak(
                binding.cityInputCreate.text.toString(),
                binding.CountryInputCreate.text.toString(),
                binding.startDateInputCreate.text.toString(),
                binding.endDateInputCreate.text.toString(),
                binding.descriptionInputCreate.text.toString(),
                binding.accommodationInputCreate.text.toString(),
                binding.BudgetInputCreate.text.toString(),
                0
            )
            //cityBreakList.add(cityBreak)
            val bundle = Bundle()
            bundle.putParcelable("cityBreak", cityBreak)
            intent.putExtra("cityBreakBundle", bundle)
            setResult(RESULT_OK, intent)
            finish()
        } else {
            Toast.makeText(
                this,
                "All fields must be completed, and the date must have the format yyyy-MM-dd!",
                Toast.LENGTH_LONG
            ).show()
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun checkInputs(): Boolean {
        if (binding.cityInputCreate.text.isEmpty() || binding.descriptionInputCreate.text.isEmpty() ||
            binding.accommodationInputCreate.text.isEmpty() || binding.startDateInputCreate.text.isEmpty() ||
            binding.endDateInputCreate.text.isEmpty() || binding.BudgetInputCreate.text.isEmpty()
        ) {
            return false
        }

        val dateChecker = binding.startDateInputCreate.text.toString()
        if (!isValidDate(dateChecker))
            return false

        val dateChecker2 = binding.endDateInputCreate.text.toString()
        if (!isValidDate(dateChecker2))
            return false

        return true
    }

    @RequiresApi(Build.VERSION_CODES.O)
    fun isValidDate(stringToTest: String): Boolean {
        try {
            val dateTime: LocalDate = LocalDate.parse(stringToTest)
        } catch (pe: DateTimeParseException) {
            return false
        }
        return true
    }

    private fun goBack() {
        intent = Intent()
        finish()
    }
}


