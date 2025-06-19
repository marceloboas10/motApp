import 'package:flutter/material.dart';
import 'package:motapp/app/model/vehicle_model.dart';

class ShowVehiclesComponent extends StatefulWidget {
  const ShowVehiclesComponent({super.key, required this.snapshot});

  final dynamic snapshot;

  @override
  State<ShowVehiclesComponent> createState() => _ShowVehiclesComponentState();
}

class _ShowVehiclesComponentState extends State<ShowVehiclesComponent> {
  @override
  Widget build(BuildContext context) {
    VehicleModel vehicles = VehicleModel.fromJson(
      widget.snapshot.data(),
      widget.snapshot.id,
    );

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        color: Colors.white,
        child: SizedBox(
          height: 85,
          child: Column(
            children: [
              ListTile(
                title: Text(
                  '${vehicles.modelo} - ${vehicles.ano}',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  vehicles.placa,
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit_outlined),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
