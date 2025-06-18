import 'package:flutter/material.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class ShowCustomersCompoment extends StatefulWidget {
  const ShowCustomersCompoment({super.key});

  @override
  State<ShowCustomersCompoment> createState() => _ShowCustomersCompomentState();
}

class _ShowCustomersCompomentState extends State<ShowCustomersCompoment> {
  @override
  Widget build(BuildContext context) {
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
                    'https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg',
                  ),
                ),
                title: Text('Marcelo'),
                subtitle: Text('(16)99135-4260'),
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
                      child: Text('Moto Alugada'),
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
