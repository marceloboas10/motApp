import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motapp/app/core/shared/utils/mask_form_formatter.dart';
import 'package:motapp/app/services/cep_result_service.dart';
import 'package:motapp/app/theme/light/light_colors.dart';
import 'package:motapp/app/widgets/form_field_widget.dart';

class FormCustomerComponent extends StatefulWidget {
  const FormCustomerComponent({super.key, required this.id});
  final Object? id;

  @override
  State<FormCustomerComponent> createState() => _FormCustomerComponentState();
}

class _FormCustomerComponentState extends State<FormCustomerComponent> {
  final _formKey = GlobalKey<FormState>();
  var nameTxt = TextEditingController();
  var cpfTxt = TextEditingController();
  var rgTxt = TextEditingController();
  var validateChnTxt = TextEditingController();
  var cellphoneTxt = TextEditingController();
  var cellphone2Txt = TextEditingController();
  var phoneTxt = TextEditingController();
  var cepTxt = TextEditingController();
  var streetTxt = TextEditingController();
  var streetNumberTxt = TextEditingController();
  var complementTxt = TextEditingController();
  var districtTxt = TextEditingController();
  var cityTxt = TextEditingController();
  String? placaSelecionadaTxt;
  bool pagamentoPendenteTxt = false;
  final CepResultService _cepResultService = CepResultService();

  void getDocumentById(String id) async {
    await FirebaseFirestore.instance.collection('clientes').doc(id).get().then((
      valor,
    ) {
      setState(() {
        nameTxt.text = valor.get('Nome');
        rgTxt.text = valor.get('RG');
        cpfTxt.text = valor.get('CPF');
        cellphoneTxt.text = valor.get('Celular');
        cellphone2Txt.text = valor.get('Celular_2');
        phoneTxt.text = valor.get('Telefone_Referencia');
        validateChnTxt.text = valor.get('Validade_CNH');
        cepTxt.text = valor.get('CEP');
        streetTxt.text = valor.get('Endereço');
        streetNumberTxt.text = valor.get('Numero_Residencia');
        complementTxt.text = valor.get('Complemento');
        districtTxt.text = valor.get('Bairro');
        cityTxt.text = valor.get('Cidade');
        placaSelecionadaTxt = valor.get('Moto_Alugada');
        pagamentoPendenteTxt = valor.get('Pagamento_Pendente');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.id != null) {
      if (nameTxt.text == '' &&
          rgTxt.text == '' &&
          cpfTxt.text == '' &&
          cellphoneTxt.text == '' &&
          streetTxt.text == '') {
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
                nameLabel: 'Nome',
                nameField: nameTxt,
                inputFormatter: FilteringTextInputFormatter.singleLineFormatter,
                message: 'Preencha o nome',
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: FormFieldWidget(
                      nameLabel: 'CPF',
                      nameField: cpfTxt,
                      inputFormatter: MaskFormFormatter().cpf,
                      keyboardType: TextInputType.number,
                      message: 'Preencha o CPF',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: FormFieldWidget(
                      nameLabel: 'RG',
                      nameField: rgTxt,
                      inputFormatter: MaskFormFormatter().rg,
                      keyboardType: TextInputType.number,
                      message: 'Preencha o RG',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: FormFieldWidget(
                      nameLabel: 'Celular',
                      nameField: cellphoneTxt,
                      inputFormatter: MaskFormFormatter().celular,
                      keyboardType: TextInputType.number,
                      message: 'Preencha o celular',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: FormFieldWidget(
                      nameLabel: 'Celular 2',
                      nameField: cellphone2Txt,
                      inputFormatter: MaskFormFormatter().celular,
                      keyboardType: TextInputType.number,
                      message: 'Preencha o celular 2',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: FormFieldWidget(
                      nameLabel: 'Telefone Residencial',
                      nameField: phoneTxt,
                      inputFormatter: MaskFormFormatter().telefoneResidencial,
                      keyboardType: TextInputType.number,
                      message: 'Preencha o telefone residêncial',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: FormFieldWidget(
                      nameLabel: 'Validade CNH',
                      nameField: validateChnTxt,
                      inputFormatter: MaskFormFormatter().validadeCnh,
                      keyboardType: TextInputType.number,
                      message: 'Preencha a validade da CNH',
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              FormFieldWidget(
                nameLabel: 'CEP',
                nameField: cepTxt,
                inputFormatter: MaskFormFormatter().cep,
                keyboardType: TextInputType.number,
                message: 'Preencha o CEP',
                onChange: (String value) async {
                  var cep = value;
                  if (cep.length > 5) {
                    final result = await _cepResultService.buscarCep(cep);

                    if (result.error != null) {
                      streetTxt.text = result.error!;
                      districtTxt.text = '';
                      cityTxt.text = '';
                      complementTxt.text = '';
                    } else {
                      streetTxt.text = result.logradouro ?? '';
                      districtTxt.text = result.bairro ?? '';
                      cityTxt.text = result.cidade ?? '';
                      complementTxt.text = result.complemento ?? '';
                      cepTxt.text = cep;
                    }
                  }
                },
              ),
              SizedBox(height: 12),
              FormFieldWidget(
                nameLabel: 'Endereço',
                nameField: streetTxt,
                inputFormatter: FilteringTextInputFormatter.singleLineFormatter,
                message: 'Preencha o endereço',
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: FormFieldWidget(
                      nameLabel: 'Número',
                      nameField: streetNumberTxt,
                      inputFormatter:
                          FilteringTextInputFormatter.singleLineFormatter,
                      keyboardType: TextInputType.number,
                      message: 'Preencha o número da residência',
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: FormFieldWidget(
                      nameLabel: 'Complemento',
                      nameField: complementTxt,
                      inputFormatter:
                          FilteringTextInputFormatter.singleLineFormatter,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: FormFieldWidget(
                      nameLabel: 'Bairro',
                      nameField: districtTxt,
                      inputFormatter:
                          FilteringTextInputFormatter.singleLineFormatter,
                      message: 'Preencha o bairro',
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: FormFieldWidget(
                      nameLabel: 'Cidade',
                      nameField: cityTxt,
                      inputFormatter:
                          FilteringTextInputFormatter.singleLineFormatter,
                      message: 'Preencha a cidade',
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(height: 7),
                  Text('Moto Alugada'),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('veiculos')
                        .snapshots(),
                    builder: (context, snapshotVeiculos) {
                      if (!snapshotVeiculos.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }

                      return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('clientes')
                            .snapshots(),
                        builder: (context, snapshotClientes) {
                          List<DropdownMenuItem> placasVeiculos = [];

                          if (!snapshotClientes.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }

                          // Lista de placas já alugadas (exceto o cliente atual se estiver editando)
                          List<String> placasAlugadas = [];
                          for (var cliente in snapshotClientes.data!.docs) {
                            final motoAlugada = cliente.get('Moto_Alugada');

                            // Se não é o cliente atual (evita conflito na edição)
                            if (widget.id == null ||
                                cliente.id != widget.id.toString()) {
                              if (motoAlugada != null &&
                                  motoAlugada != '0' &&
                                  motoAlugada.toString().isNotEmpty) {
                                placasAlugadas.add(motoAlugada.toString());
                              }
                            }
                          }

                          // Adiciona opção "Nenhuma"
                          placasVeiculos.add(
                            const DropdownMenuItem(
                              value: '0',
                              child: Text('Nenhuma'),
                            ),
                          );

                          // Adiciona apenas motos disponíveis (não alugadas)
                          final veiculos = snapshotVeiculos.data!.docs;
                          for (var veiculo in veiculos) {
                            final placa = veiculo.get('Placa');

                            // Só adiciona se a moto não estiver alugada
                            if (!placasAlugadas.contains(placa)) {
                              placasVeiculos.add(
                                DropdownMenuItem(
                                  value: placa,
                                  child: Text(placa),
                                ),
                              );
                            }
                          }

                          return DropdownButtonFormField<dynamic>(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: LightColors.iconColorGreen,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xffe2e8f0),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            dropdownColor: Colors.white,
                            items: placasVeiculos,
                            onChanged: (placaValue) {
                              setState(() {
                                placaSelecionadaTxt = placaValue;
                              });
                            },
                            initialValue:
                                placasVeiculos.any(
                                  (item) => item.value == placaSelecionadaTxt,
                                )
                                ? placaSelecionadaTxt
                                : null,
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Text('Pagamento Pendente?'),
                  Switch(
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: LightColors.lightGray,
                    activeTrackColor: LightColors.buttonRed,
                    thumbColor: WidgetStatePropertyAll(Colors.white),
                    value: pagamentoPendenteTxt,
                    onChanged: (value) {
                      setState(() {
                        pagamentoPendenteTxt = value;
                      });
                    },
                  ),
                ],
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
                        content: Text('Usuário não autenticado'),
                      ),
                    );
                    return;
                  }
                  var db = FirebaseFirestore.instance
                      .collection('usuarios')
                      .doc(userId)
                      .collection('clientes');
                  if (formValid) {
                    placaSelecionadaTxt ??= '0';
                    if (widget.id == null) {
                      //ADICIONA UM NOVO DOCUMENTO
                      db.add({
                        'Nome': nameTxt.text,
                        'RG': rgTxt.text,
                        'CPF': cpfTxt.text,
                        'Telefone_Referencia': cellphoneTxt.text,
                        'Celular_2': cellphone2Txt.text,
                        'Celular': cellphoneTxt.text,
                        'Validade_CNH': validateChnTxt.text,
                        'CEP': cepTxt.text,
                        'Endereço': streetTxt.text,
                        'Numero_Residencia': streetNumberTxt.text,
                        'Complemento': complementTxt.text,
                        'Bairro': districtTxt.text,
                        'Cidade': cityTxt.text,
                        'Moto_Alugada': placaSelecionadaTxt,
                        'Pagamento_Pendente': pagamentoPendenteTxt,
                      });
                    } else {
                      //ATUALIZA DOCUMENTO
                      db.doc(widget.id.toString()).update({
                        'Nome': nameTxt.text,
                        'RG': rgTxt.text,
                        'CPF': cpfTxt.text,
                        'Celular': cellphoneTxt.text,
                        'Celular_2': cellphone2Txt.text,
                        'Telefone_Residencial': phoneTxt.text,
                        'Validade_CNH': validateChnTxt.text,
                        'CEP': cepTxt.text,
                        'Endereço': streetTxt.text,
                        'Numero_Casa': streetNumberTxt.text,
                        'Complemento': complementTxt.text,
                        'Bairro': districtTxt.text,
                        'Cidade': cityTxt.text,
                        'Moto_Alugada': placaSelecionadaTxt,
                        'Pagamento_Pendente': pagamentoPendenteTxt,
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
                  'SALVAR CLIENTE',
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
    );
  }
}
