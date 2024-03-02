package com.example.appnative_db.data
import android.annotation.SuppressLint
import android.app.Activity
import android.app.AlertDialog
import android.content.Context
import android.content.Intent
import android.database.sqlite.SQLiteDatabase
import android.net.Network
import androidx.recyclerview.widget.RecyclerView
import android.net.NetworkCapabilities
import android.os.Bundle
import android.util.Log
import android.view.Window
import android.widget.ImageView
import android.os.Build
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.content.ContextCompat
import androidx.lifecycle.lifecycleScope
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.appnative_db.R
import com.example.appnative_db.adapter.ItemAdapter
import com.example.appnative_db.client.CityBreakAPI
import com.example.appnative_db.database.DatabaseRepository

import android.net.ConnectivityManager
import androidx.annotation.RequiresApi
import com.example.appnative_db.database.Utils
import com.example.appnative_db.model.CityBreak
import com.example.appnative_db.service.AddCityBreakActivity
import kotlinx.coroutines.delay
import kotlinx.coroutines.launch
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response


class ListViewCityBreak : AppCompatActivity() {
    private lateinit var readableDatabase: SQLiteDatabase
    private lateinit var writableDatabase: SQLiteDatabase

    private lateinit var cityBreakRepository: DatabaseRepository;
//    private val cityBreaks = mutableListOf<CityBreak>()
    lateinit var addButton: ImageView
    private lateinit var dbHelper: Utils
    private var context=this;
    private lateinit var recyclerView: RecyclerView


    fun isNetworkConnected(): Boolean {
        //check if the device is connected to the internet or not
        val connectivityManager =
            getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            val activeNetwork = connectivityManager.activeNetwork
            val networkCapabilities = connectivityManager.getNetworkCapabilities(activeNetwork)
            val isConnected = networkCapabilities != null &&
                    networkCapabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)

            Log.d("Network Status", "Connected: $isConnected")
            return isConnected
        }else {
            val networkInfo = connectivityManager.activeNetworkInfo
            val isConnected = networkInfo != null && networkInfo.isConnected
            Log.d("Network Status", "Connected: $isConnected")
            return isConnected
        }

//        return networkCapabilities != null &&
//                networkCapabilities.hasCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)

    }

//    private lateinit var binding: ActivityListCitybreakBinding // ViewBinding
//
//    var citybreaksToObserve = MutableLiveData<MutableList<CityBreak>>()
//    private lateinit var citybreaks: MutableList<CityBreak>
//    private lateinit var context: Context

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onCreate(savedInstanceState: Bundle?) {
        val str = "LIST ACTIVITY"
        Log.i(str, "We are in list")

        super.onCreate(savedInstanceState)

        setContentView(R.layout.activity_list_citybreak)


        recyclerView = findViewById(R.id.recyclerView)

        //binding = ActivityListCitybreakBinding.inflate(layoutInflater) // Initialize ViewBinding
        //val view = binding.root
        //setContentView(view)


        supportActionBar?.hide()
        val window: Window = this@ListViewCityBreak.window
        window.statusBarColor = ContextCompat.getColor(this@ListViewCityBreak, R.color.black)

        //initCityBreaks()
        dbHelper = Utils(this)
        readableDatabase = dbHelper.readableDatabase;
        writableDatabase = dbHelper.writableDatabase;
        cityBreakRepository = DatabaseRepository.getInstance(readableDatabase, writableDatabase)!!;


        lifecycleScope.launch {
            recyclerView.layoutManager = LinearLayoutManager(context)
            recyclerView.adapter = ItemAdapter(context)
        }

        if (!isNetworkConnected()) {
            //if not connected to internet show the dialog to warn the user
            showDialog()
        }

        //allow the app to check the network status and changes
        //callbacks methods triggered when the network status changes
        //listens for changes
        //When the network becomes available it triggers an asynchronous operation using Retrofit to retrieve city breaks from the server.
        val connectivityManager =
            getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        connectivityManager.registerDefaultNetworkCallback(object :
            ConnectivityManager.NetworkCallback() {
            override fun onAvailable(network: Network) {
                //called when a network is available
                lifecycleScope.launch {
                    //delay(5000)
                    CityBreakAPI.retrofitService.retrieveAllCityBreaks()  //get the obj
                        .enqueue(object : Callback<List<CityBreak>?> {
                            override fun onResponse(
                                call: Call<List<CityBreak>?>,
                                response: Response<List<CityBreak>?>
                            ) {

                                val cityBreaksServer = response.body()!!
                                Log.d("CityBreaks server", cityBreaksServer.toString())
                                val cityBreaksDatabase = cityBreakRepository.getCityBreaks();

                                //compare the data from the server to the local one and for each city break not
                                // found on the server generate a request to the server

                                for (s1: CityBreak in cityBreaksDatabase) {
                                    var exists = false
                                    for (s2: CityBreak in cityBreaksServer) {
                                        if (s1.id!!.equals(s2.id)) {
                                            exists = true
                                        }
                                    }

                                    if (!exists) {
                                        CityBreakAPI.retrofitService.createCityBreak(s1)
                                            .enqueue(object : Callback<CityBreak?> {
                                                override fun onResponse(
                                                    call: Call<CityBreak?>,
                                                    response: Response<CityBreak?>
                                                ) {
                                                    Log.d(
                                                        "Added item from local db",
                                                        "Success: " + s1
                                                    )
                                                }

                                                override fun onFailure(
                                                    call: Call<CityBreak?>,
                                                    t: Throwable
                                                ) {
                                                    Log.e("Retrofit Failure", t.message, t)
                                                    Toast.makeText(
                                                        context,
                                                        "Failed to add item from local db!",
                                                        Toast.LENGTH_SHORT
                                                    ).show()
                                                    Log.d(
                                                        "Added item from local db",
                                                        "Failed: " + t.message
                                                    )
                                                }
                                            })
                                    }

                                }


                                //For each item on the server not found in the local database, it sends a request to delete that item from the server.
                                for (s2: CityBreak in cityBreaksServer) {
                                    var exists = false
                                    for (s1: CityBreak in cityBreaksDatabase) {
                                        if (s1.id!!.equals(s2.id)) {
                                            exists = true
                                        }
                                    }

                                    if (!exists) {
                                        CityBreakAPI.retrofitService.deleteCityBreak(s2.id!!)
                                            .enqueue(object : Callback<CityBreak?> {
                                                override fun onResponse(
                                                    call: Call<CityBreak?>,
                                                    response: Response<CityBreak?>
                                                ) {


                                                    Log.d(
                                                        "Deleted item from server",
                                                        "Success!"
                                                    )
                                                }

                                                override fun onFailure(
                                                    call: Call<CityBreak?>,
                                                    t: Throwable
                                                ) {
                                                    Toast.makeText(
                                                        context,
                                                        "Failed to remove item from server!",
                                                        Toast.LENGTH_SHORT
                                                    ).show()
                                                    Log.d(
                                                        "Deleted item from server",
                                                        "Failed! " + t.message
                                                    )
                                                }
                                            })
                                    }
                                }

                                //For each item found in both the local database and the server but with differences in data, it sends a request to update that item on the server

                                for (s1: CityBreak in cityBreaksDatabase) {
                                    var different = false
                                    for (s2: CityBreak in cityBreaksServer) {
                                        if (s1.id!!.equals(s2.id) && (!s1.city.equals(s2.city) || !s1.country.equals(
                                                s2.country
                                            ) || !s1.startDate.equals(s2.startDate) || !s1.endDate.equals(s2.endDate) ||
                                                    !s1.description.equals(s2.description) || !s1.accommodation.equals(
                                                s2.accommodation
                                            ) || !s1.budget.equals(s2.budget))
                                        ) {
                                            different = true
                                            Log.d(
                                                "Updated item from the server",
                                                "Success: " + s2
                                            )
                                        }
                                    }

                                    if (different) {
                                        CityBreakAPI.retrofitService.updateCityBreak(s1.id!!, s1)
                                            .enqueue(object : Callback<CityBreak?> {
                                                override fun onResponse(
                                                    call: Call<CityBreak?>,
                                                    response: Response<CityBreak?>
                                                ) {
                                                    Log.d(
                                                        "Updated item from the server",
                                                        "Success: " + s1
                                                    )
                                                }

                                                override fun onFailure(
                                                    call: Call<CityBreak?>,
                                                    t: Throwable
                                                ) {
                                                    Toast.makeText(
                                                        context,
                                                        "Failed to update item from server!",
                                                        Toast.LENGTH_SHORT
                                                    ).show()
                                                    Log.d(
                                                        "Updated item from the server",
                                                        "Failed: " + t.message
                                                    )
                                                }
                                            })
                                    }

                                }
                            }

                            override fun onFailure(call: Call<List<CityBreak>?>, t: Throwable) {
                                lifecycleScope.launch {
                                    Toast.makeText(
                                        context,
                                        "Failed to check differences between local db and server!",
                                        Toast.LENGTH_SHORT
                                    ).show()
                                    Log.d(
                                        "Check for differences between local db and server",
                                        "Failed: " + t.message
                                    )
                                }
                            }
                        })
                }
            }
        }
        )

        addButton = findViewById(R.id.addCityBreak)

        addButton.setOnClickListener {
            val intent = Intent(applicationContext, AddCityBreakActivity::class.java)
            startActivityForResult(intent, 3);
        }


    }

    private fun showDialog() {
        AlertDialog.Builder(this).setTitle("No Internet Connection")
            .setMessage("Fallback on local DB")
            .setPositiveButton(android.R.string.ok) { _, _ -> }
            .setIcon(android.R.drawable.ic_dialog_alert).show()
    }

    @RequiresApi(Build.VERSION_CODES.O)
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == 3) {
            if (resultCode == Activity.RESULT_OK) {
                if (data != null) {
                    val bundle = data.getBundleExtra("cityBreakBundle")
                    val cityBreak = bundle?.getParcelable<CityBreak>("cityBreak")
                    if (cityBreak != null) {
                        addCityBreak(cityBreak)
                    }
                }
                Toast.makeText(this, "Added!", Toast.LENGTH_SHORT).show()
            }
        } else if (requestCode == 5) {
            if (resultCode == Activity.RESULT_OK) {
                if (data != null) {
                    val bundle = data.getBundleExtra("cityBreakBundle")
                    val cityBreak = bundle?.getParcelable<CityBreak>("cityBreak")
                    val id = data.getLongExtra("id", -1)
                    if (cityBreak != null && id != (-1).toLong()) {
                        updateCityBreak(cityBreak, id)
                        Toast.makeText(this, "Updated!", Toast.LENGTH_SHORT).show()
                    }
                }
            }
        }
    }

    @SuppressLint("NotifyDataSetChanged")
    fun deleteCityBreak(id: Long) {
        if (isNetworkConnected()) {
            lifecycleScope.launch {
                CityBreakAPI.retrofitService.deleteCityBreak(id).enqueue(object : Callback<CityBreak?> {
                    override fun onResponse(call: Call<CityBreak?>, response: Response<CityBreak?>) {
                        cityBreakRepository.delete(id)
                        recyclerView.adapter?.notifyDataSetChanged()
                        Log.d("Delete city break action - server", "Success: " + response.body())
                    }

                    override fun onFailure(call: Call<CityBreak?>, t: Throwable) {
                        Toast.makeText(
                            context,
                            "Failed to delete city break" + t.message,
                            Toast.LENGTH_SHORT
                        ).show()
                        Log.d("Delete city break action - server", "Failed: " + t.message)
                    }
                })
            }

        } else {
            showDialog()
            cityBreakRepository.delete(id)
            Log.d("Delete city break action - local database", "Success!")
        }
        recyclerView.adapter?.notifyDataSetChanged()

    }

    fun updateCityBreak(cityBreak: CityBreak, id: Long) {
        if (isNetworkConnected()) {
            lifecycleScope.launch {
                CityBreakAPI.retrofitService.updateCityBreak(id, cityBreak).enqueue(object : Callback<CityBreak?> {
                    @SuppressLint("NotifyDataSetChanged")
                    override fun onResponse(call: Call<CityBreak?>, response: Response<CityBreak?>) {
                        cityBreakRepository.update(cityBreak, id)
                        recyclerView.adapter?.notifyDataSetChanged()
                        Log.d("Update city break action - server", "Success: " + response.body())
                    }

                    override fun onFailure(call: Call<CityBreak?>, t: Throwable) {
                        Toast.makeText(
                            context,
                            "Failed to update city break!" + t.message,
                            Toast.LENGTH_SHORT
                        ).show()
                        Log.d("Update city break action - server", "Failed: " + t.message)
                    }
                })
            }
        } else {
            showDialog()
            cityBreakRepository.update(cityBreak, id)
            recyclerView.adapter?.notifyDataSetChanged()
            Log.d("Update city break action - local database", "Success!")
        }
    }

    fun addCityBreak(cityBreak: CityBreak) {

        var cityBreakId = cityBreakRepository.add(cityBreak)

        cityBreak.id = cityBreakId

        if (isNetworkConnected()) {
            lifecycleScope.launch {
                CityBreakAPI.retrofitService.createCityBreak(cityBreak).enqueue(object : Callback<CityBreak?> {
                    override fun onResponse(call: Call<CityBreak?>, response: Response<CityBreak?>) {
                        recyclerView.adapter?.notifyDataSetChanged()
                        Log.d("Add city break action - server", "Success: " + response.body().toString())
                    }

                    override fun onFailure(call: Call<CityBreak?>, t: Throwable) {
                        Toast.makeText(
                            context,
                            "Failed to add city break!" + t.message,
                            Toast.LENGTH_SHORT
                        ).show()
                        Log.d("Add city break action - server", "Failed: " + t.message)
                    }
                })
            }
        } else {
            showDialog()
            recyclerView.adapter?.notifyDataSetChanged()
            Log.d("Add city break action - local database", "Success!")
        }
    }
}

//    private fun updateCityBreak(cityBreak: CityBreak, id: Number) {
//        //update
//        for(i in 0 until cityBreaks.size){
//            if(cityBreaks[i].id == id){
//                cityBreaks[i] = cityBreak
//                Toast.makeText(this, "Updated!", Toast.LENGTH_SHORT).show()
//                binding.recyclerView.adapter?.notifyItemChanged(i)
//            }
//        }
//    }
//
//    private fun addCityBreakToList(cityBreak: CityBreak) {
//        //add
//        cityBreaks.add(cityBreak)
//        val position = cityBreaks.size - 1
//        binding.recyclerView.adapter?.notifyItemInserted(position)
//        Log.d("AddCityBreakToList", "City break added: $cityBreak")
//    }


//    @RequiresApi(Build.VERSION_CODES.O)
//    private fun initCityBreaks() {
//
//        val formatter = DateTimeFormatter.ofPattern("dd-MM-yyyy")
//
//        val cityBreak1 = CityBreak(
//            "Paris",
//            "France",
//            LocalDate.parse("19-06-2023", formatter),
//            LocalDate.parse("24-06-2023", formatter),
//            "Very beautiful city.",
//            "Palace Hotel",
//            199
//        )
//        val cityBreak2 = CityBreak(
//            "Rome",
//            "Italy",
//            LocalDate.parse("19-06-2023", formatter),
//            LocalDate.parse("24-06-2023", formatter),
//            "Very beautiful city.",
//            "Palace Hotel",
//            200
//        )
//        val cityBreak3 = CityBreak(
//            "London",
//            "UK",
//            LocalDate.parse("19-06-2023", formatter),
//            LocalDate.parse("24-06-2023", formatter),
//            "Very beautiful city.",
//            "Palace Hotel",
//            200
//        )
//        val cityBreak4 = CityBreak(
//            "Napoli",
//            "Italy",
//            LocalDate.parse("19-06-2023", formatter),
//            LocalDate.parse("24-06-2023", formatter),
//            "Very beautiful city.",
//            "Palace Hotel",
//            200
//        )
//        val cityBreak5 = CityBreak(
//            "Bucharest",
//            "Romania",
//            LocalDate.parse("19-06-2023", formatter),
//            LocalDate.parse("24-06-2023", formatter),
//            "Very beautiful city.",
//            "Palace Hotel",
//            200
//        )
//        val cityBreak6 = CityBreak(
//            "Madrid",
//            "Spain",
//            LocalDate.parse("19-06-2023", formatter),
//            LocalDate.parse("24-06-2023", formatter),
//            "Very beautiful city.",
//            "Palace Hotel",
//            200
//        )
//        val cityBreak7 = CityBreak(
//            "Amsterdam",
//            "Netherlands",
//            LocalDate.parse("19-06-2023", formatter),
//            LocalDate.parse("24-06-2023", formatter),
//            "Very beautiful city.",
//            "Palace Hotel",
//            200
//        )
//
//
//        cityBreaks.add(cityBreak1)
//        cityBreaks.add(cityBreak2)
//        cityBreaks.add(cityBreak3)
//        cityBreaks.add(cityBreak4)
//        cityBreaks.add(cityBreak5)
//        cityBreaks.add(cityBreak6)
//        cityBreaks.add(cityBreak7)
//    }


