import 'package:flutter/material.dart';

class RenderPage extends StatefulWidget {
  const RenderPage({
    Key? key,
    required this.label,
    required this.index,
  }) : super(key: key);

  final int index;
  final String label;

  @override
  State<RenderPage> createState() => _RenderPageState();
}

class _RenderPageState extends State<RenderPage> {
  @override
  Widget build(BuildContext context) {
    switch (widget.index) {
      case 0:
        return Center(
          child: Text(
              'Criar a page de acordo com o necessario. Home vai ter o que?'),
        );
        break;
      case 1:
        return Center(
          child: Text('Caso de novidade'),
        );
        break;
      case 2:
        return Center(
          child: Text('Caso para perfil.'),
        );
        break;
    }

    return Center(
      child: Text(
        'This is the ${widget.label} ${widget.index}',
        style: const TextStyle(fontSize: 26),
      ),
    );
  }
}
