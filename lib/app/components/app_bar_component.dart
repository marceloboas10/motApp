import 'package:flutter/material.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class AppBarComponent extends StatelessWidget implements PreferredSizeWidget {
  const AppBarComponent({super.key, required this.title, required this.page});

  final String title;
  final Widget page;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(title),
      actionsPadding: EdgeInsets.only(right: 8),
      actions: [
        IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => page),
            );
          },
          icon: Icon(
            Icons.add_circle,
            size: 40,
            color: LightColors.iconColorGreen,
          ),
        ),
      ],
    );
  }
  
  @override
 Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
