import 'package:delta_team/features/homepage/provider/showModalProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NavbarHomePage extends StatefulWidget {
  const NavbarHomePage({super.key});

  @override
  State<NavbarHomePage> createState() => _NavbarHomePageState();
}

class _NavbarHomePageState extends State<NavbarHomePage> {
  @override
  Widget build(BuildContext context) {
    final showModalProvider = Provider.of<ShowModal>(context, listen: false);
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          key: const Key("user_icon_key"),
          onTap: () {
            setState(() {
              showModalProvider.toggleModal();
            });
          },
          child: const Icon(
            Icons.account_circle_rounded,
            color: Colors.green,
            size: 50,
          ),
        ),
      ],
    );
  }
}
