import 'package:delta_team/common/colors.dart';
import 'package:delta_team/features/onboarding/onboarding_mobile/mobile_providers/role_provider_mobile.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../mobile_models/role_mobile.dart';
import '../mobile_models/role_white_items_mobile.dart';

class RoleWidget extends StatefulWidget {
  final Role role;
  final RoleWhite roleWhite;
  const RoleWidget({
    Key? key,
    required this.role,
    required this.roleWhite,
  }) : super(key: key);

  @override
  State<RoleWidget> createState() => _RoleWidgetState();
}

class _RoleWidgetState extends State<RoleWidget> {
  @override
  Widget build(BuildContext context) {
    var myItem = Provider.of<MyItem>(context);
    var nizSaRolama = Provider.of<MyItem>(context).myItems;
    var isSelected = myItem.hasRole(widget.role);
    selectedItem() {
      if (isSelected || nizSaRolama.length >= 2) {
        myItem.remove(widget.role);
      } else {
        myItem.add(widget.role);
      }
    }

    return GestureDetector(
      key: const Key('RoleButtonKey'),
      onTap: () {
        selectedItem();
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4.0),
            width: double.infinity,
            height: 50,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primarySecond : Colors.white,
              border: isSelected ? Border.all(width: 0) : Border.all(width: 1),
              borderRadius: BorderRadius.circular(3.0),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: isSelected
                      ? SvgPicture.asset(
                          widget.role.image,
                          width: 21,
                          height: 18,
                          color: Colors.white,
                        )
                      : SvgPicture.asset(
                          widget.role.image,
                          width: 21,
                          height: 18,
                          color: Colors.black,
                        ),
                ),
                Text(
                  widget.role.id,
                  style: GoogleFonts.notoSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: isSelected ? Colors.white : AppColors.primarySecond,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
        ],
      ),
    );
  }
}
