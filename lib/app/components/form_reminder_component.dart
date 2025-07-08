import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motapp/app/core/shared/utils/mask_form_formatter.dart';
import 'package:motapp/app/theme/light/light_colors.dart';
import 'package:motapp/app/widgets/form_field_widget.dart';

class FormReminderComponent extends StatefulWidget {
  const FormReminderComponent({super.key, required this.id});
  final Object? id;

  @override
  State<FormReminderComponent> createState() => _FormReminderComponentState();
}

class _FormReminderComponentState extends State<FormReminderComponent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController reminder = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController date = TextEditingController();

  void getDocumentById(String id) async {
    await FirebaseFirestore.instance.collection('lembretes').doc(id).get().then(
      (valor) {
        reminder.text = valor.get('Lembrete');
        description.text = valor.get('Descrição').toString();
        date.text = valor.get('Data').toString();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.id != null) {
      if (reminder.text == '' && description.text == '' && date.text == '') {
        getDocumentById(widget.id.toString());
      }
    }

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
                nameLabel: 'Lembrete',
                nameField: reminder,
                inputFormatter: FilteringTextInputFormatter.singleLineFormatter,
                message: 'Preencha o lembrete ',
              ),
              SizedBox(height: 12),
              FormFieldWidget(
                nameLabel: 'Descrição',
                nameField: description,
                maxLine: 3,
                inputFormatter: FilteringTextInputFormatter.singleLineFormatter,
                message: 'Preencha a descrição ',
              ),
              SizedBox(height: 12),
              FormFieldWidget(
                nameLabel: 'Data',
                nameField: date,
                inputFormatter: MaskFormFormatter().date,
                message: 'Preencha o lembrete ',
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
                    if (widget.id == null) {
                      //ADICIONA UM NOVO DOCUMENTO
                      db.collection('lembretes').add({
                        'Lembrete': reminder.text,
                        'Descrição': description.text,
                        'Data': date.text,
                      });
                    } else {
                      //ATUALIZA DOCUMENTO
                      db
                          .collection('lembretes')
                          .doc(widget.id.toString())
                          .update({
                            'Lembrete': reminder.text,
                            'Descrição': description.text,
                            'Data': date.text,
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
                  'SALVAR LEMBRETE',
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
