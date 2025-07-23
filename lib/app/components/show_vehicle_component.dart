import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motapp/app/model/vehicle_model.dart';
import 'package:motapp/app/pages/vehicles/register_vehicle_page.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

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
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              RegisterVehiclePage(),
                          settings: RouteSettings(arguments: vehicles.id),
                        ),
                      ),
                      child: Icon(Icons.edit_outlined, size: 30),
                    ),
                    SizedBox(width: 8),
                    InkWell(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text(
                              "Excluir Lembrete",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            content: Text(
                              "Tem certeza que deseja excluir ${vehicles.placa}?",
                              style: TextStyle(fontSize: 18),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "Não",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Veículo ${vehicles.placa} excluído com sucesso!',
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  );
                                  FirebaseFirestore.instance
                                      .collection('veiculos')
                                      .doc(vehicles.id)
                                      .delete();
                                  Navigator.of(context).pop();
                                },
                                child: const Text(
                                  "Sim",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Icon(
                        Icons.delete_outlined,
                        size: 30,
                        color: LightColors.buttonRed,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
