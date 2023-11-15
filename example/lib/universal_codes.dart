import 'package:flutter/material.dart';
import 'package:glassfy_flutter/glassfy_flutter.dart';

import 'design.dart';

class UniversalCodesSection extends StatefulWidget {
  const UniversalCodesSection({super.key});

  @override
  _UniversalCodesSectionState createState() => _UniversalCodesSectionState();
}

class _UniversalCodesSectionState extends State<UniversalCodesSection> {
  String code = "";

  void connect() async {
    try {
      await Glassfy.connectGlassfyUniversalCode(code, false);
      debugPrint('Connected $code');
      code = "";
    } catch (error) {
      debugPrint('Error connecting $code: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Universal Codes'),
        const Text('Test connect Universal Codes'),
        TextField(
          decoration: const InputDecoration(
            labelText: 'Enter Universal Code',
            hintText: 'ABC123',
          ),
          onChanged: (newCode) {
            setState(() {
              code = newCode;
            });
          },
        ),
        ElevatedButton(
          onPressed: () {
            connect();
          },
          child: const Text('Connect'),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
