package com.example.appnative_db.database
import android.provider.BaseColumns

class TableEntry
private constructor(){
    object Entry : BaseColumns {
        const val TABLE_NAME = "cityBreak"
        const val COLUMN_NAME_ID = "id"
        const val COLUMN_NAME_CITY = "city"
        const val COLUMN_NAME_COUNTRY = "country"
        const val COLUMN_NAME_STARTDATE = "startDate"
        const val COLUMN_NAME_ENDDATE = "endDate"
        const val COLUMN_NAME_DESCRIPTION = "description"
        const val COLUMN_NAME_ACCOMMODATION = "accommodation"
        const val COLUMN_NAME_BUDGET = "budget"
    }
}