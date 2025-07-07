import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motapp/app/theme/light/light_colors.dart';
import 'package:motapp/app/widgets/form_field_widget.dart';

class FormProductComponent extends StatefulWidget {
  const FormProductComponent({super.key, required this.id});
  final Object? id;

  @override
  State<FormProductComponent> createState() => _FormProductComponentState();
}

class _FormProductComponentState extends State<FormProductComponent> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController product = TextEditingController();
  final TextEditingController amount = TextEditingController();

  void getDocumentById(String id) async {
    await FirebaseFirestore.instance.collection('produtos').doc(id).get().then((
      valor,
    ) {
      product.text = valor.get('Produto');
      amount.text = valor.get('Quantidade').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.id != null) {
      if (product.text == '' && amount.text == '') {
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
          child: Column(
            children: [
              FormFieldWidget(
                nameLabel: 'Produto',
                nameField: product,
                inputFormatter: FilteringTextInputFormatter.singleLineFormatter,
                message: 'Preencha o nome do produto ',
              ),
              SizedBox(height: 12),
              FormFieldWidget(
                nameLabel: 'Quantidade',
                nameField: amount,
                inputFormatter: FilteringTextInputFormatter.singleLineFormatter,
                message: 'Preencha o nome do produto ',
              ),
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
                      db.collection('produtos').add({
                        'Produto': product.text,
                        'Quantidade': amount.text,
                      });
                    } else {
                      //ATUALIZA DOCUMENTO
                      db
                          .collection('produtos')
                          .doc(widget.id.toString())
                          .update({
                            'Produto': product.text,
                            'Quantidade': amount.text,
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
                  'SALVAR PRODUTO',
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
