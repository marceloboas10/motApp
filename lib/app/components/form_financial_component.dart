import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:motapp/app/core/shared/utils/mask_form_formatter.dart';
import 'package:motapp/app/theme/light/light_colors.dart';
import 'package:motapp/app/widgets/form_field_widget.dart';

class FormFinancialComponent extends StatefulWidget {
  const FormFinancialComponent({super.key, required this.id});
  final Object? id;

  @override
  State<FormFinancialComponent> createState() => _FormFinancialComponentState();
}

class _FormFinancialComponentState extends State<FormFinancialComponent> {
  final _formKey = GlobalKey<FormState>();
  var descriptionTxt = TextEditingController();
  var valueTransactionTxt = TextEditingController();
  var dateTransationTxt = TextEditingController();
  final _dateController = TextEditingController();
  DateTime? _selectedDate;
  String? selectedType;

  List<DropdownMenuItem> typePayment = [
    DropdownMenuItem(value: 'entrada', child: Text('Entrada')),
    DropdownMenuItem(value: 'saida', child: Text('Saída')),
  ];

  void getDocumentById(String id) async {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) return;

    await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(userId)
        .collection('transacoes')
        .doc(id)
        .get()
        .then((valor) {
          selectedType = valor.get('Tipo');
          descriptionTxt.text = valor.get('Descrição').toString();
          valueTransactionTxt.text = valor.get('Valor').toString();
          final ts = valor.get('Data');
          if (ts != null && ts is Timestamp) {
            _selectedDate = ts.toDate();
            _dateController.text = DateFormat(
              'dd/MM/yyyy',
            ).format(_selectedDate!);
          } else {
            _selectedDate = null;
            _dateController.text = '';
          }
        });
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Tipo movimentação'),
                  Container(height: 7),
                  DropdownButtonFormField<dynamic>(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: LightColors.iconColorGreen,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffe2e8f0)),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    dropdownColor: Colors.white,
                    items: typePayment,
                    onChanged: (typeSelected) {
                      setState(() {
                        selectedType = typeSelected;
                      });
                    },
                    initialValue: selectedType,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Selecione um tipo de pagamento';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 12),
                  FormFieldWidget(
                    nameLabel: 'Descrição',
                    nameField: descriptionTxt,
                    inputFormatter:
                        FilteringTextInputFormatter.singleLineFormatter,
                    message: 'Preencha a descrição',
                  ),
                  SizedBox(height: 12),
                  FormFieldWidget(
                    nameLabel: 'Valor (R\$)',
                    nameField: valueTransactionTxt,
                    inputFormatter:
                        FilteringTextInputFormatter.singleLineFormatter,
                    keyboardType: TextInputType.numberWithOptions(),
                    message: 'Preencha o valor',
                  ),
                  SizedBox(height: 12),
                  FormFieldWidget(
                    nameLabel: 'Data da transação',
                    hintText: 'dd/ mm / aaaa',
                    nameField: _dateController,
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) {
                        setState(() {
                          _selectedDate = picked;
                          _dateController.text = DateFormat(
                            'dd/MM/yyyy',
                          ).format(picked);
                        });
                      }
                    },
                    inputFormatter: MaskFormFormatter().date,
                    message: 'Preencha a data ',
                  ),
                ],
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
                      .collection('transacoes');

                  double? valor;
                  try {
                    valor = double.parse(
                      valueTransactionTxt.text.replaceAll(',', '.'),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: LightColors.buttonRed,
                        content: Text('Valor inválido'),
                      ),
                    );
                    return;
                  }

                  if (formValid) {
                    if (widget.id == null) {
                      //ADICIONA UM NOVO DOCUMENTO
                      db.add({
                        'Tipo': selectedType,
                        'Descrição': descriptionTxt.text,
                        'Valor': valor,
                        'Data': _selectedDate != null
                            ? Timestamp.fromDate(_selectedDate!)
                            : Timestamp.fromDate(DateTime.now()),
                      });
                    } else {
                      //ATUALIZA DOCUMENTO
                      db.doc(widget.id.toString()).update({
                        'Tipo': selectedType,
                        'Descrição': descriptionTxt.text,
                        'Valor': valor,
                        'Data': _selectedDate != null
                            ? Timestamp.fromDate(_selectedDate!)
                            : Timestamp.fromDate(DateTime.now()),
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
                  'SALVAR TRANSAÇÃO',
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
