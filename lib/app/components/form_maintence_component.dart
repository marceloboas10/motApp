import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:motapp/app/core/shared/utils/mask_form_formatter.dart';
import 'package:motapp/app/theme/light/light_colors.dart';
import 'package:motapp/app/widgets/form_field_widget.dart';

class FormMaintenceComponent extends StatefulWidget {
  const FormMaintenceComponent({super.key});

  @override
  State<FormMaintenceComponent> createState() => _FormMaintenceComponentState();
}

class _FormMaintenceComponentState extends State<FormMaintenceComponent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController serviceName = TextEditingController();
  final TextEditingController totalCoast = TextEditingController();
  final TextEditingController observation = TextEditingController();
  final _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
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
                nameLabel: 'Nome do Serviço',
                hintText: 'Ex: Troca de óleo e filtro',
                nameField: serviceName,
                inputFormatter: FilteringTextInputFormatter.singleLineFormatter,
                message: 'Preencha o lembrete ',
              ),

              SizedBox(height: 12),
              FormFieldWidget(
                nameLabel: 'Data de Vencimento',
                hintText: 'dd/ mm / aaaa',
                nameField: _dateController,
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2025),
                    lastDate: DateTime(2100),
                  );
                  if (picked != null) {
                    setState(() {
                      _dateController.text = DateFormat(
                        'dd/MM/yyyy',
                      ).format(picked);
                    });
                  }
                },
                inputFormatter: MaskFormFormatter().date,
                message: 'Preencha o lembrete ',
              ),
              SizedBox(height: 12),
              FormFieldWidget(
                nameLabel: 'Observações',
                nameField: observation,
                maxLine: 3,
                inputFormatter: FilteringTextInputFormatter.singleLineFormatter,
                message: 'Preencha a descrição ',
              ),
              SizedBox(height: 12),
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
                  var db = FirebaseFirestore.instance;
                  if (formValid) {
                    //ADICIONA UM NOVO DOCUMENTO
                    db.collection('lembretes').add({
                      'Lembrete': serviceName.text,
                      'Descrição': observation.text,
                    });
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
                  'SALVAR MANUTENÇÃO',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
