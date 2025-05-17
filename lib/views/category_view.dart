import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gastos/app/utils/colors/colors.dart';
import 'package:gastos/app/utils/paths/icons/icons.dart';
import 'package:gastos/viewmodels/category_view_model.dart';
import 'package:gastos/viewmodels/user_viewmodel.dart';
import 'package:gastos/widgets/molecules/buttons/add_new_button.dart';
import 'package:gastos/widgets/templates/cards/category_card.dart';
import 'package:gastos/widgets/templates/footer/footer.dart';
import 'package:gastos/widgets/templates/headers/topbar.dart';
import 'package:provider/provider.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  void _showAddCategoryModal(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final _categoryController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Theme(
          data: Theme.of(context).copyWith(
            inputDecorationTheme:  InputDecorationTheme(
              labelStyle: TextStyle(color: colorsUI.primary500),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorsUI.primary500),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: colorsUI.primary500),
              ),
            ),
            textSelectionTheme:  TextSelectionThemeData(
              cursorColor: colorsUI.primary500,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
              left: 16.0,
              right: 16.0,
              top: 16.0,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   Text(
                    'Agregar nueva categoría',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: colorsUI.primary500,
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _categoryController,
                    style:  TextStyle(color: colorsUI.primary500),
                    decoration: const InputDecoration(
                      labelText: 'Nombre de la categoría',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Por favor ingresa un nombre';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        child:  Text('Cancelar',
                          style: TextStyle(color: colorsUI.primary500),
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        child:  Text('Guardar', style: TextStyle(color: colorsUI.primary500),),
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final nombre = _categoryController.text.trim();
                            final userViewModel = Provider.of<UserViewModel>(context, listen: false);
                            final categoryViewModel = Provider.of<CategoryViewModel>(context, listen: false);
                            await categoryViewModel.addCategory(userViewModel.usuario!.uid,nombre);
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

    @override
  Widget build(BuildContext context) {
    final userViewModel = Provider.of<UserViewModel>(context);
    final usuario = userViewModel.usuario;

    if (usuario == null) {
      return const Scaffold(
        body: Center(child: Text('Usuario no autenticado')),
      );
    }

    final categoryViewModel = Provider.of<CategoryViewModel>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: TopBar(
            imageUrl: usuario?.photoUrl ?? '', userName: usuario?.name ?? ''),
        toolbarHeight: 70.0,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AddNewButton(onPressed: () => _showAddCategoryModal(context), texto: "Agregar Categoría"),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder<List<String>>(
                stream: categoryViewModel.categoriesStream(usuario.uid),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final categorias = snapshot.data ?? [];

                  if (categorias.isEmpty) {
                    return const Center(child: Text('No hay categorías registradas.'));
                  }

                  return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                        childAspectRatio: 1 / 1.1,
                      ),
                      itemCount: categorias.length,
                      itemBuilder: (context,index){
                        return CategoryCard(
                          name: categorias[index],
                          imagePath: iconsUI.emptyCart,
                          onTap: () {
                            print('Tapped on ${categorias[index]}');

                          },
                        );
                      }
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Footer(page: 2),
    );
  }
}
