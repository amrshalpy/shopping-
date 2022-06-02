import 'dart:io';

import 'package:e_comarce/home/cubit/cubit.dart';
import 'package:e_comarce/home/cubit/states.dart';
import 'package:e_comarce/models/category_model.dart';
import 'package:e_comarce/modules/admin/admin_screen.dart';
import 'package:e_comarce/shared/components/components.dart';
import 'package:e_comarce/shared/components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';

class AddProducts extends StatelessWidget {
  CategoryModel? model;

  AddProducts({Key? key, this.model}) : super(key: key);
  TextEditingController priceController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController discController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = HomeLayoutCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Column(children: [
                    SizedBox(height: 70,),
                    Center(
                      child: Stack(
                        alignment: AlignmentDirectional.bottomEnd,
                        children: [
                          Container(
                            child: HomeLayoutCubit.get(context).imageProduct == null
                                ? SizedBox()
                                : Image(
                                    image: FileImage(HomeLayoutCubit.get(context)
                                        .imageProduct as File),
                                  ),
                            width: 180,
                            height: 220,
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: CircleAvatar(
                              child: IconButton(
                                onPressed: () {
                                  HomeLayoutCubit.get(context).setImageProduct();
                                },
                                icon: Icon(Icons.add),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 15,
                                ),

                                SizedBox(height: 10,),

                                item(text: "Name".tr, controller: nameController),
                                item(
                                    text: "Price".tr,
                                    controller: priceController,
                                    type: TextInputType.number),
                                item(
                                    text: "Description".tr, controller: discController),
                                item(text: "Details".tr, controller: detailsController),
                                item(text: "Size".tr, controller: sizeController),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 40,
                      child: button(
                          text: "Add".tr,
                          function: () {
                            if (formKey.currentState!.validate()) {}
                            cubit.saveImageProduct(
                                name: nameController.text,
                                price:  priceController.text,
                                category: model!.name,
                                details: detailsController.text,
                                description: discController.text,
                                size: sizeController.text);
                            pop(context: context);

                          }
                        ),
                    ),
                  ]),
                ],
              ),
            ),
          );
        });
  }
}
