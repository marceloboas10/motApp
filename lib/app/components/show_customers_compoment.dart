import 'package:flutter/material.dart';
import 'package:motapp/app/model/customer_model.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class ShowCustomersCompoment extends StatefulWidget {
  const ShowCustomersCompoment({super.key, required this.snapshot});
  final dynamic snapshot;

  @override
  State<ShowCustomersCompoment> createState() => _ShowCustomersCompomentState();
}

class _ShowCustomersCompomentState extends State<ShowCustomersCompoment> {
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
          height: 125,
          child: Column(
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    'https://media.licdn.com/dms/image/v2/C4D03AQHW9KH-hxDGfQ/profile-displayphoto-shrink_100_100/profile-displayphoto-shrink_100_100/0/1663117292082?e=1755734400&v=beta&t=cbHpnAIAp93tCWaawOjkOQmPU__Ici-yi6_jyjVsSJw',
                  ),
                ),
                title: Text(customer.nome),
                subtitle: Text(customer.telefone),
                trailing: Icon(Icons.edit),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Color(0xFFccfbf1),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(customer.motoAlugada.toString()),
                    ),
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: LightColors.buttonRed,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text('Pagamento Pendente'),
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
