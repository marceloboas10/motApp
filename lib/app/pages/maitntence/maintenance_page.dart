import 'package:flutter/material.dart';
import 'package:motapp/app/components/app_bar_component.dart';
import 'package:motapp/app/components/dropdown_vehicle_maintenance_component.dart';
import 'package:motapp/app/components/maintenance_history_component.dart';
import 'package:motapp/app/components/product_selected_maintenance_component.dart';
import 'package:motapp/app/components/product_used_maintenance_component.dart';
import 'package:motapp/app/pages/maitntence/register_maintence_page.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class MaintenancePage extends StatefulWidget {
  const MaintenancePage({super.key});

  @override
  State<MaintenancePage> createState() => _MaintencePageState();
}

class _MaintencePageState extends State<MaintenancePage> {
  String? vehicleSelected;
  TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> productsSelected = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        title: 'Manutenção',
        page:
            RegisterMaintencePage(), // Este botão pode ser removido se o fluxo for sempre pela página principal
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownVehicleMaintenanceComponent(
                vehicleSelected: vehicleSelected,
                onChanged: (value) {
                  setState(() {
                    vehicleSelected = value;
                  });
                },
              ),
              SizedBox(height: 8),
              ProductUsedMaintenanceComponent(
                searchController: searchController,
                onProductsChanged: (products) {
                  setState(() {
                    productsSelected = products;
                  });
                },
              ),
              SizedBox(height: 8),
              ProductSelectedMaintenanceComponent(
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
              SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final productsToSend = productsSelected
                        .where((p) => (p['quantidade'] as int? ?? 0) > 0)
                        .toList();

                    if (vehicleSelected != null &&
                        vehicleSelected != '0' &&
                        productsToSend.isNotEmpty) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterMaintencePage(),
                          settings: RouteSettings(
                            arguments: {
                              'vehicleId': vehicleSelected,
                              'products': productsToSend,
                            },
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: LightColors.buttonRed,
                          content: Text(
                            'Selecione um veículo e defina a quantidade de ao menos um produto.',
                          ),
                        ),
                      );
                    }
                  },
                  style: ButtonStyle(
                    fixedSize: WidgetStatePropertyAll(Size.fromHeight(50)),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                      LightColors.iconColorGreen,
                    ),
                  ),
                  child: Text(
                    'Registrar Manutenção',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
              MaintenanceHistoryComponent(vehicleId: vehicleSelected),
            ],
          ),
        ),
      ),
    );
  }
}
