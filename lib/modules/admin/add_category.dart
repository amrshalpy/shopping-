import 'package:e_comarce/home/cubit/cubit.dart';
import 'package:e_comarce/home/cubit/states.dart';
import 'package:e_comarce/shared/components/conistance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class BuildCategory extends StatelessWidget {
  BuildCategory({Key? key}) : super(key: key);
  var titleController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(listener: (context, state) {
      if (state is SaveImageCategorySucsses) {
        titleController.clear();
      }
    }, builder: (context, state) {
      return Scaffold(
        body: Column(
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      child: TextField(
                        controller: titleController,
                        decoration: InputDecoration(
                          hintText: 'category name',
                          labelText: 'category name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    )
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12),

                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: HexColor(color),
                      ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            HomeLayoutCubit.get(context)
                                .saveImageCategory(title: titleController.text);
                          }
                        },
                        child: Text('Add Category')),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
