import 'package:flutter/material.dart';
import 'package:motapp/app/model/vehicle_model.dart';
import 'package:motapp/app/pages/vehicles/register_vehicle_page.dart';

class ShowVehicleComponent extends StatefulWidget {
  const ShowVehicleComponent({super.key, required this.snapshot});

  final dynamic snapshot;

  @override
  State<ShowVehicleComponent> createState() => _ShowVehicleComponentState();
}

class _ShowVehicleComponentState extends State<ShowVehicleComponent> {
  @override
  Widget build(BuildContext context) {
    VehicleModel vehicles = VehicleModel.fromJson(
      widget.snapshot.data(),
      widget.snapshot.id,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        color: Colors.white,
        child: SizedBox(
          child: Column(
            children: [
              ListTile(
                title: Text(
                  '${vehicles.fabricante}\n${vehicles.modelo} - ${vehicles.ano}',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  vehicles.placa,
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                trailing: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => RegisterVehiclePage(),
                      settings: RouteSettings(arguments: vehicles.id),
                    ),
                  ),
                  child: Icon(Icons.edit_outlined, size: 30),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
