import 'package:flutter/material.dart';
import 'package:medical_managment_app/data_access/models/supply.dart';
import 'package:medical_managment_app/widgets/supply_info_widget.dart';

class SupplyListWidget extends StatelessWidget {
  final List<Supply> supplies;
  final Function(Supply) onSupplySelected;

  const SupplyListWidget({super.key, required this.supplies,required this.onSupplySelected});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: supplies.length,
      itemBuilder: (context, index) {
        return SupplyInfoWidget(
          supply: supplies[index],
          onSupplySelected: () => onSupplySelected(supplies[index]), // Pass the selected date to the callback
        );
      },
    );
  }
}
