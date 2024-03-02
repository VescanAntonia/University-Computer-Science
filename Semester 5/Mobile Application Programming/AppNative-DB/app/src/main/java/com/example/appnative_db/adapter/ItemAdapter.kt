package com.example.appnative_db.adapter


import android.annotation.SuppressLint
import android.app.Dialog
import android.app.LauncherActivity.ListItem
import android.content.Intent
import android.os.Build
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View

import android.view.ViewGroup
import android.widget.TextView
import android.widget.Toast
import androidx.annotation.RequiresApi
import androidx.recyclerview.widget.RecyclerView
import com.example.appnative_db.R
import com.example.appnative_db.data.ListViewCityBreak
import com.example.appnative_db.database.DatabaseRepository
import com.example.appnative_db.database.Utils
import com.example.appnative_db.databinding.ListItemBinding
import com.example.appnative_db.service.EditCityBreakActivity


class ItemAdapter(private val context: ListViewCityBreak): RecyclerView.Adapter<ItemAdapter.ItemViewHolder>() {

    var dbHelper = Utils(this.context)
    var cityBreaksRepository = DatabaseRepository.getInstance(dbHelper.readableDatabase, dbHelper.writableDatabase)!!


    inner class ItemViewHolder(val binding:ListItemBinding): RecyclerView.ViewHolder(binding.root)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ItemViewHolder {
        val binding = ListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
//
//        in.from(parent.context).inflate(R.layout.list_item, parent, false)
        return ItemViewHolder(binding)
    }

    @SuppressLint("SetTextI18n")
    @RequiresApi(Build.VERSION_CODES.O)
    override fun onBindViewHolder(holder: ItemViewHolder, position: Int) {

        val item = cityBreaksRepository.getCityBreaks()[position]
        holder.binding.apply {
            cityID.text = item.city;
            countryID.text = item.country;
            accomodationID.text = item.accommodation;
        }

        // Update the deleteButton based on network connectivity
        holder.binding.deleteButton.isEnabled = context.isNetworkConnected()

        holder.binding.deleteButton.setOnClickListener{

            if (context.isNetworkConnected()) {
            val dialog = Dialog(context)
            dialog.setCancelable(true)
            dialog.setContentView(R.layout.delete_popup)

            val titleLabel = dialog.findViewById(R.id.cityLabel) as TextView
            titleLabel.text = "${cityBreaksRepository.getCityBreaks()[position].city} ?"


            val yesView = dialog.findViewById(R.id.yesButton) as View

            val noView = dialog.findViewById(R.id.noButton) as View

            yesView.setOnClickListener {
                context.deleteCityBreak(item.id!!)
                dialog.dismiss()
            }

            noView.setOnClickListener {
                dialog.dismiss()
            }

            dialog.show()
            } else {
                // Show a message or handle accordingly when no internet
                Toast.makeText(context, "Internet connection not available. Remove feature is disabled.", Toast.LENGTH_SHORT).show()
            }
        }

        holder.binding.editButton.isEnabled = context.isNetworkConnected()
        holder.binding.editButton.setOnClickListener(){
            if (context.isNetworkConnected()) {
            val bundle = Bundle();
            val intent = Intent(context, EditCityBreakActivity::class.java)

            bundle.putParcelable("cityBreak", cityBreaksRepository.getCityBreaks()[position]);
            intent.putExtra("cityBreakBundle", bundle);
            intent.putExtra("id", cityBreaksRepository.getCityBreaks()[position].id);

            context.startActivityForResult(intent, 5)
            } else {
                // Show a message or handle accordingly when no internet
                Toast.makeText(context, "Internet connection not available. Update feature is disabled.", Toast.LENGTH_SHORT).show()
            }
        }

    }


    @RequiresApi(Build.VERSION_CODES.O)
    override fun getItemCount(): Int {
        return cityBreaksRepository.getCityBreaks().size
    }

}