import 'package:flutter/material.dart';
import 'package:gastos/app/utils/colors/colors.dart';
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
         // routes.dashboard(context: context);
          break;
        case 1:
      //    routes.search(context: context);
          break;
        case 2:
        //  routes.mainExplore(context: context);
          break;
        case 3:
        //  routes.cart(context: context);
          break;
        case 4:
         // routes.profilePage(context: context);
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
                  title: 'Inicio',
                  color: colorsUI.secondary500,
                  align: TextAlign.center,
                  fontWeight: FontWeight.bold),
              selectedColor: colorsUI.secondary500,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: const Icon(Icons.search),
              title: SmP(
                  title: 'Buscar',
                  color: colorsUI.secondary500,
                  align: TextAlign.center,
                  fontWeight: FontWeight.bold),
              selectedColor: colorsUI.secondary500,
            ),

            /// Create Perfume
            SalomonBottomBarItem(
              icon: const Icon(Icons.add_circle_outline),
              title: SmP(
                  title: 'Crear Perfume',
                  color: colorsUI.secondary500,
                  align: TextAlign.center,
                  fontWeight: FontWeight.bold),
              selectedColor: colorsUI.secondary500,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: Icon(PhosphorIcons.shoppingCart()),
              title: SmP(
                  title: 'Compras',
                  color: colorsUI.secondary500,
                  align: TextAlign.center,
                  fontWeight: FontWeight.bold),
              selectedColor: colorsUI.secondary500,
            ),
          ],
        ));
  }
}
