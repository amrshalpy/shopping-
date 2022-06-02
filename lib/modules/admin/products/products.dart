import 'package:e_comarce/home/cubit/cubit.dart';
import 'package:e_comarce/home/cubit/states.dart';
import 'package:e_comarce/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Products extends StatelessWidget {
  Products({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeLayoutCubit()..getCategoriesModel(),
      child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 3,
                    ),
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: cubit.categories.length,
                    itemBuilder: (context, index) =>
                        getProduct(cubit.categories[index], context),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget getProduct(CategoryModel model, context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
          ),
          borderRadius: BorderRadius.circular(16),
          color: Colors.grey[200],
        ),
        height: 140,
        width: double.infinity,
        child: Column(
          children: [
            Image.network(
              '${model.picture}',
              fit: BoxFit.fill,
              height: 100,
              width: double.infinity,
            ),
            SizedBox(
              height: 10,
            ),

              Text('${model.name}'),
          ],
        ),
      ),
    );
  }
}
