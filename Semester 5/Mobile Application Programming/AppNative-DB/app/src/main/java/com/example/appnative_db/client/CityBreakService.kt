package com.example.appnative_db.client
import com.example.appnative_db.model.CityBreak
import retrofit2.Call
import retrofit2.http.*

interface CityBreakService {
    @GET("/cityBreaks/{id}")
    fun retrieveCityBreak(@Path("id") id: Int) : Call<CityBreak>
    @GET("/cityBreaks")
    fun retrieveAllCityBreaks() : Call<List<CityBreak>>
    @DELETE("/cityBreaks/{id}")
    fun deleteCityBreak(@Path("id") id: Long) : Call<CityBreak>
    @POST("/cityBreaks")
    fun createCityBreak(@Body cityBreak: CityBreak) : Call<CityBreak>
    @PUT("/cityBreaks/{id}")
    fun updateCityBreak(@Path("id") id: Long, @Body cityBreak: CityBreak) : Call<CityBreak>
}