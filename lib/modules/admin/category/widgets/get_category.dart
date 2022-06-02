import 'package:e_comarce/home/cubit/cubit.dart';
import 'package:e_comarce/home/cubit/states.dart';
import 'package:e_comarce/models/category_model.dart';
import 'package:e_comarce/modules/admin/admin_screen.dart';
import 'package:e_comarce/modules/admin/products/product_items.dart';
import 'package:e_comarce/modules/admin/products/products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animations/loading_animations.dart';

import '../../../../shared/components/conistance.dart';

Widget getCategoryItems(CategoryModel categori, context) {
  return InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(
        builder: (context)=> ProductItems(model: categori,)));
    },
    child: Container(
      height: 100,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(width: .2),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 20, 10, 3),
        child: Column(
          children: [

            Image.network(
              '${categori.picture}',
              fit: BoxFit.contain,
              height: 100,
              width: double.infinity,
            ),
            SizedBox(height: 10,),
            Text('${categori.name}',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            ),
          ],
        ),
      ),
    ),
  );
}


