package com.example.appnative_db.client
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

object CityBreakAPI {
//    private const val BASE_URL = "http://192.168.1.6:51838"
    private const val BASE_URL = "http://10.0.2.2:8085"
    private val retrofit = Retrofit.Builder()
        .addConverterFactory(GsonConverterFactory.create())
        .baseUrl(BASE_URL)
        .build()
    val retrofitService: CityBreakService by lazy {
        retrofit.create(CityBreakService::class.java)
    }
}