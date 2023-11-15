
import 'package:flutter/material.dart';
import 'package:glassfy_flutter/models.dart';
import 'package:glassfy_flutter_example/accountable_sku.dart';

class PermissionItem extends StatefulWidget {
  final GlassfyPermission permission;

  const PermissionItem(this.permission, {super.key});

  @override
  _PermissionItemState createState() => _PermissionItemState(permission);
}

class _PermissionItemState extends State<PermissionItem> {
  GlassfyPermission permission;

  _PermissionItemState(this.permission);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(children: [
          Semantics(
            label: 'permission',
            value: 'permission',
            child: Text('${permission.permissionId}'),
          ),
          const Text(' ('),
          Semantics(
            label: 'numberOfSkus',
            value: 'numberOfSkus',
            child: Text('${permission.accountableSkus?.length ?? 0}'),
          ),
          const Text(' skus)'),
          const Spacer(),
          Text('${permission.entitlement.toString().substring(19)} ')
        ]),
        const SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: permission.accountableSkus?.length ?? 0,
          itemBuilder: (context, index) {
            var sku = permission.accountableSkus![index];
            return InkWell(
              child: Container(
                  padding: const EdgeInsets.all(10),
                  child: AccountableSkuItem(sku)),
            );
          },
        ),
      ],
    );
  }
}
