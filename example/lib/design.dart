import 'package:flutter/material.dart';

class SectionTitle extends StatefulWidget {
  final String text;

  const SectionTitle(this.text, {super.key});

  @override _SectionTitleState createState() => _SectionTitleState(text); 
}

class _SectionTitleState extends State<SectionTitle> {
  String text;

  _SectionTitleState(this.text);
  
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.headlineSmall);
  }
}