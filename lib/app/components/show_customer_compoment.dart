import 'package:flutter/material.dart';
import 'package:motapp/app/model/customer_model.dart';
import 'package:motapp/app/pages/register_customer_page.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class ShowCustomerCompoment extends StatefulWidget {
  const ShowCustomerCompoment({super.key, required this.snapshot});
  final dynamic snapshot;

  @override
  State<ShowCustomerCompoment> createState() => _ShowCustomerCompomentState();
}

class _ShowCustomerCompomentState extends State<ShowCustomerCompoment> {
  @override
  Widget build(BuildContext context) {
    CustomerModel customer = CustomerModel.fromJson(
      widget.snapshot.data(),
      widget.snapshot.id,
    );

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        color: Colors.white,
        child: SizedBox(
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    'https://img.a.transfermarkt.technology/portrait/big/8198-1748102259.jpg?lm=1',
                  ),
                ),
                title: Text(
                  customer.nome,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                subtitle: Text(
                  customer.celular,
                  style: TextStyle(fontWeight: FontWeight.w400),
                ),
                trailing: InkWell(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => RegisterCustomerPage(),
                      settings: RouteSettings(arguments: customer.id),
                    ),
                  ),
                  child: Icon(Icons.edit_outlined, size: 30),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Visibility(
                      visible: customer.motoAlugada!.length > 2,
                      child: Container(
                        margin: EdgeInsets.only(left: 16, right: 24),
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Color(0xFFccfbf1),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(customer.motoAlugada.toString()),
                      ),
                    ),
                    Visibility(
                      visible: customer.pagamentoPendente!,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: LightColors.buttonRed,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text('Pagamento Pendente'),
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
