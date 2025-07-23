import 'package:flutter/material.dart';
import 'package:motapp/app/theme/light/light_colors.dart';

class CustomTabSelectorWidget extends StatefulWidget {
  final Function(String)? onFilterChanged;

  const CustomTabSelectorWidget({super.key, this.onFilterChanged});

  @override
  State<CustomTabSelectorWidget> createState() =>
      _CustomTabSelectorWidgetState();
}

class _CustomTabSelectorWidgetState extends State<CustomTabSelectorWidget> {
  String _filtroAtivo = 'todos';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildTab('Todos', 'todos'),
        SizedBox(width: 8),
        _buildTab('Entradas', 'entradas'),
        SizedBox(width: 8),
        _buildTab('Saídas', 'saidas'),
      ],
    );
  }

  Widget _buildTab(String texto, String valor) {
    final isAtivo = _filtroAtivo == valor;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _filtroAtivo = valor;
          });
          if (widget.onFilterChanged != null) {
            widget.onFilterChanged!(valor);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isAtivo ? Colors.teal : LightColors.lightGray,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            texto,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isAtivo ? Colors.white : Colors.black,
              fontWeight: isAtivo ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
