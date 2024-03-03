import 'package:flutter/material.dart';

class FullSizePage extends StatefulWidget {
  final Widget child;
  final EdgeInsets? padding;
  const FullSizePage({super.key, required this.child, this.padding});

  @override
  State<FullSizePage> createState() => _FullSizePageState();
}

class _FullSizePageState extends State<FullSizePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
      child: widget.child,
    );
  }
}
