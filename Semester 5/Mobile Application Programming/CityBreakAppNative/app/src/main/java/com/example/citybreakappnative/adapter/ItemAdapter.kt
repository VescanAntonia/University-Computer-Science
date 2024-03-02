package com.example.citybreakappnative.adapter

import android.app.Dialog
import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.activity.result.ActivityResultLauncher
import androidx.recyclerview.widget.RecyclerView
import com.example.citybreakappnative.R
import com.example.citybreakappnative.data.ListViewCityBreak
import com.example.citybreakappnative.databinding.ListItemBinding // Import the generated ViewBinding class
import com.example.citybreakappnative.model.CityBreak
import com.example.citybreakappnative.service.EditCityBreakActivity



class ItemAdapter(private val context: ListViewCityBreak, private val cityBreaks: MutableList<CityBreak>) :
    RecyclerView.Adapter<ItemAdapter.ItemViewHolder>() {

    inner class ItemViewHolder(val binding: ListItemBinding) : RecyclerView.ViewHolder(binding.root)

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ItemViewHolder {
        val binding = ListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        return ItemViewHolder(binding)
    }

    override fun onBindViewHolder(holder: ItemViewHolder, position: Int) {
        //populate the view and sets the buttons
        val item = cityBreaks[position]

        // Access views through the ViewBinding
        with(holder.binding) {
            ID.text = item.id.toString()
            cityID.text = item.city
            countryID.text = item.country
            accomodationID.text = item.accommodation.toString()

            // Delete button click handling
            deleteButton.setOnClickListener { showDeleteDialog(position) }

            // Edit button click handling
            editButton.setOnClickListener { editCityBreak(position) }
        }
    }

    override fun getItemCount(): Int {
        //get nr of items in the list
        return cityBreaks.size
    }

    private fun showDeleteDialog(position: Int) {
        //display the custom dialog for confirming the deletion
        val dialog = Dialog(context)
        dialog.setCancelable(true)
        dialog.setContentView(R.layout.delete_popup)

        val titleLabel = dialog.findViewById(R.id.cityLabel) as TextView
        titleLabel.text = "${cityBreaks[position].city} ?"

        val yesView = dialog.findViewById(R.id.yesButton) as View
        val noView = dialog.findViewById(R.id.noButton) as View

        yesView.setOnClickListener {
            cityBreaks.removeAt(position)
            notifyDataSetChanged()
            dialog.dismiss()
        }

        noView.setOnClickListener {
            dialog.dismiss()
        }

        dialog.show()
    }

    private fun editCityBreak(position: Int) {
        val bundle = Bundle()
        val intent = Intent(context, EditCityBreakActivity::class.java)

        bundle.putParcelable("cityBreak", cityBreaks[position])
        intent.putExtra("cityBreakBundle", bundle)

        context.startActivityForResult(intent, 5)
    }
}