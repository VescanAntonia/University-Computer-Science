package com.example.appnative_db.service


import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.util.Log
import android.view.Window
import android.widget.Button
import android.widget.Toast
import androidx.annotation.RequiresApi
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import com.example.appnative_db.R
import com.example.appnative_db.model.CityBreak
import com.example.appnative_db.databinding.EditCitybreakBinding
import java.time.LocalDate
import java.time.format.DateTimeFormatter
import java.time.format.DateTimeParseException

class EditCityBreakActivity : AppCompatActivity() {

    private lateinit var id: Number
    private lateinit var initialCityBreak: CityBreak
    private lateinit var cancelButton: Button
    private lateinit var saveButton: Button
    private lateinit var binding: EditCitybreakBinding // ViewBinding

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onCreate(savedInstanceState: Bundle?) {
        val str = "EDIT NOTE ACTIVITY"
        Log.i(str, "We are in edit note")
        super.onCreate(savedInstanceState)

        binding = EditCitybreakBinding.inflate(layoutInflater) // Initialize ViewBinding
        val view = binding.root
        setContentView(view)
        //setContentView(R.layout.edit_citybreak)

        supportActionBar?.hide()

        val window: Window = this@EditCityBreakActivity.window
        window.statusBarColor = ContextCompat.getColor(this@EditCityBreakActivity, R.color.black)

        val bundle = intent.getBundleExtra("cityBreakBundle")
        if (bundle != null) {
            val citybreak = bundle.getParcelable<CityBreak>("cityBreak")
            if (citybreak != null) {
                initialCityBreak = citybreak
//                id = citybreak.id!!
            }
        }
        id = intent.getLongExtra("id", -1);

        initializeInputs()

        saveButton = binding.saveButtonUpdate
        cancelButton = binding.cancelButtonUpdate

        saveButton.setOnClickListener {
            editCityBreak()
        }

        cancelButton.setOnClickListener {
            goBack()
        }
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun editCityBreak() {
        if (checkInputs()) {
            val formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd")
            initialCityBreak.city = binding.updateCity.text.toString()
            initialCityBreak.country = binding.updateCountry.text.toString()
            initialCityBreak.startDate = binding.updateStartDate.text.toString()
            initialCityBreak.endDate = binding.updateEndDate.text.toString()
            initialCityBreak.description = binding.updateDescription.text.toString()
            initialCityBreak.accommodation = binding.updateAccommodation.text.toString()
            initialCityBreak.budget = binding.updateBudget.text.toString()

            val bundle = Bundle()
            bundle.putParcelable("cityBreak", initialCityBreak)
            intent.putExtra("cityBreakBundle", bundle)
            intent.putExtra("id", id)
            setResult(RESULT_OK, intent)
            finish()
        } else {
            Toast.makeText(this, "All fields must be completed and the date must have the format yyyy-MM-dd!", Toast.LENGTH_LONG).show()
        }
    }

    private fun goBack() {
        intent = Intent()
        finish()
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun checkInputs(): Boolean {
        if (binding.updateCity.text.isEmpty() || binding.updateCountry.text.isEmpty() || binding.updateStartDate.text.isEmpty() || binding.updateEndDate.text.isEmpty() || binding.updateDescription.text.isEmpty() || binding.updateAccommodation.text.isEmpty() || binding.updateBudget.text.isEmpty()) {
            return false
        }

        val dateChecker = binding.updateStartDate.text.toString()
        if (!isValidDate(dateChecker))
            return false

        val dateChecker2 = binding.updateEndDate.text.toString()
        if (!isValidDate(dateChecker2))
            return false

        return true
    }

    @RequiresApi(Build.VERSION_CODES.O)
    fun isValidDate(stringToTest: String): Boolean {
        try {
            LocalDate.parse(stringToTest)
        } catch (pe: DateTimeParseException) {
            return false
        }
        return true
    }

    private fun initializeInputs() {
        //binding.idInputUpdate.setText(id.toString())
        //binding.idInputUpdate.isEnabled = false
        binding.updateCity.setText(initialCityBreak.city)
        binding.updateCountry.setText(initialCityBreak.country)
        binding.updateStartDate.setText(initialCityBreak.startDate.toString())
        binding.updateEndDate.setText(initialCityBreak.endDate.toString())
        binding.updateDescription.setText(initialCityBreak.description)
        binding.updateAccommodation.setText(initialCityBreak.accommodation)
        binding.updateBudget.setText(initialCityBreak.budget.toString())
    }
}

