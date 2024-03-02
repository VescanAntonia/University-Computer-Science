package com.example.appnative_db.database


import android.content.ContentValues
import android.database.sqlite.SQLiteDatabase
import android.os.Build
import android.util.Log
import androidx.annotation.RequiresApi
import com.example.appnative_db.model.CityBreak


class DatabaseRepository private constructor(
    private var readableDatabase: SQLiteDatabase,
    private var writableDatabase: SQLiteDatabase
){
    private var citybreakList: MutableList<CityBreak> = ArrayList();

    @RequiresApi(Build.VERSION_CODES.O)
    fun getCityBreaks(): MutableList<CityBreak> {
        val data: MutableList<CityBreak> = ArrayList()
        val cursor = readableDatabase.query(Utils.TABLE_NAME, null, null, null, null, null, null);

        while(cursor.moveToNext()){
            val id = cursor.getLong(cursor.getColumnIndexOrThrow("id"))
            val city = cursor.getString(cursor.getColumnIndexOrThrow("city"))
            val country = cursor.getString(cursor.getColumnIndexOrThrow("country"))
            val startDate =cursor.getString(cursor.getColumnIndexOrThrow("startDate"))
            val endDate = cursor.getString(cursor.getColumnIndexOrThrow("endDate"))
            val description = cursor.getString(cursor.getColumnIndexOrThrow("description"))
            val accommodation = cursor.getString(cursor.getColumnIndexOrThrow("accommodation"))
//            val budget = cursor.getString(cursor.getColumnIndexOrThrow("budget")).toIntOrNull() ?: 0
            val budget = cursor.getString(cursor.getColumnIndexOrThrow("budget"))
//
            Log.d("DatabaseRepository", "ID: $id, City: $city, ...")
            val citybreak = CityBreak(city,country,startDate,endDate, description,accommodation,budget, id)

            data.add(citybreak)
        }

        cursor.close()

        citybreakList = data

        return citybreakList.toMutableList()
    }

    fun add(citybreak: CityBreak): Long {
        val values = ContentValues()
        values.put(Utils.COL_CITY, citybreak.city)
        values.put(Utils.COL_COUNTRY, citybreak.country)
        values.put(Utils.COL_STARTDATE, citybreak.startDate.toString())
        values.put(Utils.COL_ENDDATE, citybreak.endDate.toString())
        values.put(Utils.COL_DESCRIPTION, citybreak.description)
        values.put(Utils.COL_ACCOMMODATION, citybreak.accommodation)
        values.put(Utils.COL_BUDGET, citybreak.budget)

        val result = writableDatabase.insert(Utils.TABLE_NAME,null, values)

        if(result == (-1).toLong()){
            val str = "DATABASE -> ADD"
            Log.i(str, "An Error appeared when inserting the element to the database!")
            return -1
        }

        return result
    }

    fun delete(id: Long): Boolean {
        val selection: String = Utils.COL_ID + " = ?"
        val selectionArgs = arrayOf(id.toString())

        val result = writableDatabase.delete(Utils.TABLE_NAME, selection, selectionArgs)

        if(result == -1){
            val str = "DATABASE -> Delete"
            Log.i(str, "An Error appeared when deleting the element from the database!")
            return false
        }

        return true
    }

    fun update(citybreak: CityBreak,id: Long): CityBreak? {
        val values = ContentValues()
        values.put(Utils.COL_CITY, citybreak.city)
        values.put(Utils.COL_COUNTRY, citybreak.country)
        values.put(Utils.COL_STARTDATE, citybreak.startDate.toString())
        values.put(Utils.COL_ENDDATE, citybreak.endDate.toString())
        values.put(Utils.COL_DESCRIPTION, citybreak.description)
        values.put(Utils.COL_ACCOMMODATION, citybreak.accommodation)
        values.put(Utils.COL_BUDGET, citybreak.budget)

        val selection: String = Utils.COL_ID + " = ?"
        val selectionArgs = arrayOf(id.toString())

        val result = writableDatabase.update(Utils.TABLE_NAME, values, selection, selectionArgs)

        if(result == -1){
            val str = "DATABASE -> Update"
            Log.i(str, "An Error appeared when updating the element from the database!")
            return null
        }

        return citybreak
    }

    fun getById(id: Long): CityBreak? {
        for(i in citybreakList.indices){
            if(id == citybreakList[i].id){
                return citybreakList[i]
            }
        }
        return null
    }

    fun getIndexById(id: Long): Int {
        for (i in citybreakList.indices) {
            if (id == citybreakList[i].id) {
                return i
            }
        }
        return -1
    }


    companion object{
        private var instance: DatabaseRepository? = null
        fun getInstance(readableDatabase: SQLiteDatabase, writableDatabase: SQLiteDatabase): DatabaseRepository? {
            if(instance == null) instance = DatabaseRepository(readableDatabase, writableDatabase)
            return instance
        }
    }

}