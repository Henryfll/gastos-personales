import 'package:flutter/material.dart';
import 'package:gastos/app/utils/colors/colors.dart';
import 'package:gastos/views/category_view.dart';
import 'package:gastos/views/goal_view.dart';
import 'package:gastos/views/home_view.dart';
import 'package:gastos/views/perfil_view.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../atoms/texts/body/sm_p.dart';

class Footer extends StatefulWidget {
  final int page;
  const Footer({
    super.key,
    required this.page,
  });

  @override
  State<Footer> createState() => _Footer();
}

class _Footer extends State<Footer> {

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {

    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    navigator(int i) {
      switch (i) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomeView()),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const GoalView()),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const CategoryView()),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const PerfilView()),
          );
          break;
      }
    }

    return Container(
        decoration: BoxDecoration(
            border: Border(top: BorderSide(color: colorsUI.primary20))),
        child: SalomonBottomBar(
          currentIndex: widget.page,
          onTap: (i) {
            navigator(i);
          },
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: const Icon(Icons.home),
              title: SmP(
                  title: 'Home',
                  color: colorsUI.secondary500,
                  align: TextAlign.center,
                  fontWeight: FontWeight.bold),
              selectedColor: colorsUI.secondary500,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: const Icon(Icons.flag_outlined),
              title: SmP(
                  title: 'Metas',
                  color: colorsUI.secondary500,
                  align: TextAlign.center,
                  fontWeight: FontWeight.bold),
              selectedColor: colorsUI.secondary500,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: Icon(PhosphorIcons.listStar()),
              title: SmP(
                  title: 'Categorias',
                  color: colorsUI.secondary500,
                  align: TextAlign.center,
                  fontWeight: FontWeight.bold),
              selectedColor: colorsUI.secondary500,
            ),
            /// Create Perfume
            SalomonBottomBarItem(
              icon: const Icon(Icons.person_outline),
              title: SmP(
                  title: 'Perfil',
                  color: colorsUI.secondary500,
                  align: TextAlign.center,
                  fontWeight: FontWeight.bold),
              selectedColor: colorsUI.secondary500,
            ),
          ],
        ));
  }
}
