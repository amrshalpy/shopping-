import 'dart:io';

import 'package:e_comarce/home/cubit/cubit.dart';
import 'package:e_comarce/home/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:google_fonts/google_fonts.dart';

class AddImage extends StatelessWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
          return Stack(
            children: [
              Container(
                height: 180,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: .8,
                  ),
                ),
                child:
                cubit.imageCategory !=null?
                Image.file(File(cubit.imageCategory!.path),
                fit: BoxFit.contain,
                ):
                     Column(
                      children: [

                        Image.asset(
                          'assets/images/emptyCart.png',
                          width: 200,
                          height: 120,
                          fit: BoxFit.contain,
                        ),
                        Text(
                          "No products here".tr,
                          style: GoogleFonts.merriweatherSans(fontSize: 25),
                        ),
                      ],
                    )

              ),
              IconButton(
                onPressed: () {
                  cubit.setImageCategory();
                },
                icon: Icon(Icons.edit),
              )
            ],
          );
        });
  }
}
