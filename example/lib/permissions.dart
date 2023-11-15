import 'package:flutter/material.dart';
import 'package:glassfy_flutter/glassfy_flutter.dart';
import 'package:glassfy_flutter/models.dart';

import 'design.dart';
import 'permission.dart';

class PermissionsSection extends StatefulWidget {
  const PermissionsSection({super.key});

  @override
  _PermissionsSectionState createState() => _PermissionsSectionState();
}

class _PermissionsSectionState extends State<PermissionsSection> {
  List<GlassfyPermission> permissions = [];

  @override
  void initState() {
    super.initState();
    getPermissions();
  }

  void getPermissions() async {
    try {
      debugPrint('Fetching permissions');
      var result = await Glassfy.permissions();
      debugPrint('Got ${result.all?.length} permissions');
      setState(() {
        permissions = result.all ?? List.empty();
      });
    } catch (error) {
      debugPrint('Error getting Permissions: $error');
      setState(() {
        permissions = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Permissions'),
        Text('Found ${permissions.length} permissions'),
        const SizedBox(height: 10),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: permissions.length,
          itemBuilder: (context, index) {
            var permission = permissions[index];
            return InkWell(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  child: PermissionItem(permission)),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
