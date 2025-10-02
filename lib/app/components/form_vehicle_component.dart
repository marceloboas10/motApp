import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motapp/app/theme/light/light_colors.dart';
import 'package:motapp/app/widgets/form_field_widget.dart';

class FormVehicleComponent extends StatefulWidget {
  const FormVehicleComponent({super.key, required this.id});
  final Object? id;

  @override
  State<FormVehicleComponent> createState() => _FormVehicleComponentState();
}

class _FormVehicleComponentState extends State<FormVehicleComponent> {
  final _formKey = GlobalKey<FormState>();
  final yearVehicleTxt = TextEditingController();
  final manufacturerVehicleTxt = TextEditingController();
  final modelVehicleTxt = TextEditingController();
  final plateVehicleTxt = TextEditingController();
  final colorVehicleTxt = TextEditingController();
  final renavamVehicleTxt = TextEditingController();

  void getDocumentById(String id) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(userId)
        .collection('veiculos')
        .doc(id)
        .get()
        .then((valor) {
          yearVehicleTxt.text = valor.get('Ano');
          manufacturerVehicleTxt.text = valor.get('Fabricante');
          modelVehicleTxt.text = valor.get('Modelo');
          plateVehicleTxt.text = valor.get('Placa');
          colorVehicleTxt.text = valor.get('Cor');
          renavamVehicleTxt.text = valor.get('Renavam');
        });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.id != null) {
      if (yearVehicleTxt.text == '' &&
          manufacturerVehicleTxt.text == '' &&
          modelVehicleTxt.text == '' &&
          plateVehicleTxt.text == '' &&
          colorVehicleTxt.text == '' &&
          renavamVehicleTxt.text == '') {
        getDocumentById(widget.id.toString());
      }
    }

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsetsGeometry.all(5),
            child: ListView(
              shrinkWrap: true,
              children: [
                FormFieldWidget(
                  nameLabel: 'Ano',
                  nameField: yearVehicleTxt,
                  keyboardType: TextInputType.number,
                  inputFormatter:
                      FilteringTextInputFormatter.singleLineFormatter,
                  message: 'Preencha o ano',
                ),
                FormFieldWidget(
                  nameLabel: 'Fabricante',
                  nameField: manufacturerVehicleTxt,
                  inputFormatter:
                      FilteringTextInputFormatter.singleLineFormatter,
                  message: 'Preencha o fabricante',
                ),
                FormFieldWidget(
                  nameLabel: 'Modelo',
                  nameField: modelVehicleTxt,
                  inputFormatter:
                      FilteringTextInputFormatter.singleLineFormatter,
                  message: 'Preencha o modelo',
                ),
                FormFieldWidget(
                  nameLabel: 'Placa',
                  nameField: plateVehicleTxt,
                  inputFormatter:
                      FilteringTextInputFormatter.singleLineFormatter,
                  message: 'Preencha a placa',
                ),
                FormFieldWidget(
                  nameLabel: 'Cor',
                  nameField: colorVehicleTxt,
                  inputFormatter:
                      FilteringTextInputFormatter.singleLineFormatter,
                  message: 'Preencha a cor',
                ),
                FormFieldWidget(
                  nameLabel: 'Renavam',
                  nameField: renavamVehicleTxt,
                  keyboardType: TextInputType.number,
                  inputFormatter:
                      FilteringTextInputFormatter.singleLineFormatter,
                  message: 'Preencha o renavam',
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  style: ButtonStyle(
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                      LightColors.iconColorGreen,
                    ),
                  ),
                  onPressed: () {
                    var formValid = _formKey.currentState?.validate() ?? false;
                    var mensagemSnack = 'Formulário Incompleto';
                    final userId = FirebaseAuth.instance.currentUser?.uid;

                    if (userId == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: LightColors.buttonRed,
                          content: Text('Usuário não autenticado.'),
                        ),
                      );
                      return;
                    }

                    var db = FirebaseFirestore.instance
                        .collection('usuarios')
                        .doc(userId)
                        .collection('veiculos');

                    if (formValid) {
                      if (widget.id == null) {
                        //ADICIONA UM NOVO DOCUMENTO
                        db.add({
                          'Ano': yearVehicleTxt.text,
                          'Cor': colorVehicleTxt.text,
                          'Fabricante': manufacturerVehicleTxt.text,
                          'Modelo': modelVehicleTxt.text,
                          'Placa': plateVehicleTxt.text,
                          'Renavam': renavamVehicleTxt.text,
                        });
                      } else {
                        //ATUALIZA DOCUMENTO
                        db.doc(widget.id.toString()).update({
                          'Ano': yearVehicleTxt.text,
                          'Cor': colorVehicleTxt.text,
                          'Fabricante': manufacturerVehicleTxt.text,
                          'Modelo': modelVehicleTxt.text,
                          'Placa': plateVehicleTxt.text,
                          'Renavam': renavamVehicleTxt.text,
                        });
                      }
                      Navigator.pop(context);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: LightColors.buttonRed,
                          content: Text(mensagemSnack),
                        ),
                      );
                    }
                  },
                  child: Text(
                    'SALVAR VEÍCULO',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
