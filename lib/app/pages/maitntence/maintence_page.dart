import 'package:flutter/material.dart';
import 'package:motapp/app/components/app_bar_component.dart';
import 'package:motapp/app/components/dropdown_vehicle_maintence_component.dart';
import 'package:motapp/app/components/product_selected_maintence_component.dart';
import 'package:motapp/app/components/product_used_maintence_component.dart';
import 'package:motapp/app/pages/maitntence/register_maintence_page.dart';

class MaintencePage extends StatefulWidget {
  const MaintencePage({super.key});

  @override
  State<MaintencePage> createState() => _MaintencePageState();
}

class _MaintencePageState extends State<MaintencePage> {
  String? vehicleSelected;
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> productsSelected = [];

  @override
  void dispose() {
    super.dispose();
    searchController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        title: 'Manutenção',
        page: RegisterMaintencePage(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownVehicleMaintenceComponent(vehicleSelected: vehicleSelected),
            SizedBox(height: 8),
            ProductUsedMaintenceComponent(
              searchController: searchController,
              onProductsChanged: (products) {
                setState(() {
                  productsSelected = products;
                });
              },
            ),
            SizedBox(height: 8),
            ProductSelectedMaintenceComponent(
              list: productsSelected,
              onRemoveProduct: (index) {
                setState(() {
                  productsSelected.removeAt(index);
                });
              },
              onUpdateQuantity: (index, newQuantity) {
                setState(() {
                  productsSelected[index]['quantidade'] = newQuantity;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
