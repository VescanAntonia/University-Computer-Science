package com.example.appnative_db.database


import android.content.Context
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteOpenHelper


class Utils(context: Context?) :
    SQLiteOpenHelper(
        context,
        DATABASE_NAME,
        null,
        DATABASE_VERSION
    ) {

    override fun onCreate(db: SQLiteDatabase) {
        db.execSQL(SQL_CREATE_ENTRIES)
    }

    override fun onUpgrade(
        db: SQLiteDatabase,
        oldVersion: Int,
        newVersion: Int
    ) {
        // This database is only a cache for online data, so its upgrade policy is
        // to simply to discard the data and start over
        db.execSQL(SQL_DELETE_ENTRIES)
        onCreate(db)
    }

    override fun onDowngrade(
        db: SQLiteDatabase,
        oldVersion: Int,
        newVersion: Int
    ) {
        onUpgrade(db, oldVersion, newVersion)
    }

    companion object {
        // If you change the database schema, you must increment the database version.
        const val DATABASE_VERSION = 2
        const val DATABASE_NAME = "citybreaks.db"
        const val TABLE_NAME = "citybreak"
        const val COL_ID = "id"
        const val COL_CITY = "city"
        const val COL_COUNTRY = "country"
        const val COL_STARTDATE = "startDate"
        const val COL_ENDDATE = "endDate"
        const val COL_DESCRIPTION = "description"
        const val COL_ACCOMMODATION = "accommodation"
        const val COL_BUDGET = "budget"

        private const val SQL_CREATE_ENTRIES =
            "CREATE TABLE " + TABLE_NAME + " (" +
                    COL_ID + " INTEGER PRIMARY KEY AUTOINCREMENT ," +
                    COL_CITY + " TEXT, " +
                    COL_COUNTRY + " TEXT, " +
                    COL_STARTDATE + " TEXT, " +
                    COL_ENDDATE + " TEXT, " +
                    COL_DESCRIPTION + " TEXT, " +
                    COL_ACCOMMODATION + " TEXT, " +
                    COL_BUDGET + " TEXT)"

        private const val SQL_DELETE_ENTRIES =
            "DROP TABLE IF EXISTS " + TABLE_NAME
    }
}