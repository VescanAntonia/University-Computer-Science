package com.example.appnative_db.model

import android.util.Log
import android.os.Parcelable
import kotlinx.android.parcel.Parcelize
//import org.threeten.bp.LocalDate
//import kotlinx.parcelize.Parcelize
import java.time.LocalDate

@Parcelize
data class CityBreak(
    var city:String, var country: String, var startDate: String,
    var endDate: String, var description: String, var accommodation: String, var budget: String,
    var id: Long?): Parcelable{
//    companion object{
//        var currentId = 0
//    }
//    constructor(city: String, country:String, startDate:LocalDate, endDate:LocalDate, description: String, accommodation: String, budget: Int): this(city,country, startDate, endDate, description, accommodation, budget,
//        currentId++){
//        Log.i("Model CityBreak Class: ", "CurrentId is $currentId")
//    }
//
//    override fun describeContents(): Int {
//        TODO("Not yet implemented")
//    }


}