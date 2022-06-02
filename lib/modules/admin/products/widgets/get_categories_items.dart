import 'package:e_comarce/models/category_model.dart';
import 'package:flutter/material.dart';

class GetCategoriesItems extends StatelessWidget {
  CategoryModel? model;
  GetCategoriesItems(this.model, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        height: 140,
        width: double.infinity,
        child: Column(
          children: [
            Image.network(
              '${model!.picture}',
              fit: BoxFit.fill,
              height: 100,
              width: double.infinity,
            ),
            SizedBox(
              height: 10,
            ),

              Text( '${model!.name}'),

          ],
        ),
      ),
    );
  }
}
