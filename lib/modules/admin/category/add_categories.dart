import 'package:e_comarce/home/cubit/cubit.dart';
import 'package:e_comarce/home/cubit/states.dart';
import 'package:e_comarce/modules/admin/add_category.dart';
import 'package:e_comarce/modules/admin/add_image_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddCategory extends StatelessWidget {
  const AddCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
        return SafeArea(
          child: Scaffold(
            body: Column(
              children: [
                SizedBox(
                  height: 25,
                ),
                AddImage(),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: Container(
                      height: 80,
                      width: double.infinity,
                      child: BuildCategory()),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
