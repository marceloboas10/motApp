import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:motapp/app/core/shared/utils/mask_form_formatter.dart';
import 'package:motapp/app/theme/light/light_colors.dart';
import 'package:motapp/app/widgets/form_field_widget.dart';

class FormMaintenceComponent extends StatefulWidget {
  final String? vehicleId;
  final List<Map<String, dynamic>>? productsUsed;

  const FormMaintenceComponent({
    super.key,
    required this.vehicleId,
    required this.productsUsed,
  });

  @override
  State<FormMaintenceComponent> createState() => _FormMaintenceComponentState();
}

class _FormMaintenceComponentState extends State<FormMaintenceComponent> {
  final _formKey = GlobalKey<FormState>();
  final serviceDescriptionTxt = TextEditingController();
  final _dateController = TextEditingController();
  DateTime? _selectedDate;

  // Função para buscar os detalhes do veículo pelo ID
  Future<DocumentSnapshot> _getVehicleDetails() {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    return FirebaseFirestore.instance
        .collection('usuarios')
        .doc(userId)
        .collection('veiculos')
        .doc(widget.vehicleId)
        .get();
  }

  @override
  void dispose() {
    serviceDescriptionTxt.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          children: [
            // Seção para mostrar o veículo selecionado
            Text('Veículo da Manutenção:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            FutureBuilder<DocumentSnapshot>(
              future: _getVehicleDetails(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Carregando dados do veículo...',
                      style: TextStyle(fontSize: 16));
                }
                if (!snapshot.hasData || snapshot.data?.data() == null) {
                  return Text('Veículo não encontrado',
                      style: TextStyle(fontSize: 16, color: Colors.red));
                }
                final vehicleData =
                    snapshot.data!.data() as Map<String, dynamic>;
                return Text(
                    '${vehicleData['Modelo']} - Placa: ${vehicleData['Placa']}',
                    style: TextStyle(fontSize: 16));
              },
            ),
            SizedBox(height: 20),

            // Seção para mostrar os produtos e quantidades
            Text('Produtos Utilizados:',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            if (widget.productsUsed != null && widget.productsUsed!.isNotEmpty)
              ...widget.productsUsed!.map((product) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(product['Produto'],
                      style: TextStyle(fontSize: 16)),
                  trailing: Text('Quantidade: ${product['quantidade']}',
                      style: TextStyle(fontSize: 16)),
                );
              }).toList()
            else
              Text('Nenhum produto selecionado.',
                  style: TextStyle(fontSize: 16)),

            Divider(height: 30),

            // Campos para preenchimento do usuário
            FormFieldWidget(
              nameLabel: 'Descrição do Serviço',
              nameField: serviceDescriptionTxt,
              maxLine: 3,
              inputFormatter: FilteringTextInputFormatter.singleLineFormatter,
              message: 'Descreva o serviço realizado',
            ),
            SizedBox(height: 12),
            FormFieldWidget(
              nameLabel: 'Data da Manutenção',
              hintText: 'dd/mm/aaaa',
              nameField: _dateController,
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(), // Não permite data futura
                );
                if (picked != null) {
                  setState(() {
                    _selectedDate = picked;
                    _dateController.text =
                        DateFormat('dd/MM/yyyy').format(picked);
                  });
                }
              },
              inputFormatter: MaskFormFormatter().date,
              message: 'Informe a data da manutenção',
            ),
            SizedBox(height: 24),

            ElevatedButton(
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
              onPressed: () {
                var formValid = _formKey.currentState?.validate() ?? false;
                if (formValid) {
                  final userId = FirebaseAuth.instance.currentUser?.uid;
                  if (userId == null) return;

                  var db = FirebaseFirestore.instance
                      .collection('usuarios')
                      .doc(userId)
                      .collection('manutencoes');

                  // Salva o novo documento de manutenção
                  db.add({
                    'servico': serviceDescriptionTxt.text,
                    'data': _selectedDate != null
                        ? Timestamp.fromDate(_selectedDate!)
                        : Timestamp.now(),
                    'vehicleId': widget.vehicleId,
                    'produtosUsados': widget.productsUsed,
                  });

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: LightColors.iconColorGreen,
                      content: Text('Manutenção salva com sucesso!'),
                    ),
                  );

                  // Volta para a tela principal de manutenção
                  int count = 0;
                  Navigator.of(context).popUntil((_) => count++ >= 2);
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
    );
  }
}