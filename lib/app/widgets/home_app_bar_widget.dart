import 'package:flutter/material.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class HomeAppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBarWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AppBar(
        backgroundColor: LightColors.scafoldBackgroud,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: theme.textTheme.titleLarge),
                Text(subtitle, style: theme.textTheme.titleMedium),
              ],
            ),
            SizedBox(height: 12),
            Icon(Icons.notifications_none),
            CircleAvatar(
              backgroundColor: LightColors.iconColorGreen,
              child: Text('U', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(70);
}
