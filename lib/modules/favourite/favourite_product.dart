import 'package:e_comarce/home/cubit/cubit.dart';
import 'package:e_comarce/home/cubit/states.dart';
import 'package:e_comarce/modules/productDetails/noSql/nosql.dart';
import 'package:e_comarce/modules/productDetails/product_details.dart';
import 'package:e_comarce/shared/components/conistance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:loading_animations/loading_animations.dart';

import '../productDetails/noSql/nosql.dart' as nosql;

Widget Favourite() => ValueListenableBuilder(
    valueListenable:
        Hive.box<ProdcutModel>('fov')
            .listenable(),
    builder: (context, Box<ProdcutModel> box, _) {
      if (box.values.length == 0) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/emptyCart.png',
                width: 250,
              ),
              Text(
                "Favourite is Empty".tr,
                style: GoogleFonts.merriweatherSans(fontSize: 25),
              ),
            ],
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  " Favourite".tr,
                  style: GoogleFonts.merriweatherSans(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 26),
                ),
              ),
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisSpacing: 4,
                mainAxisSpacing: 4,
                childAspectRatio: 1 / 1.3,
                children: List.generate(
                  box.values.length,
                  (index) {
                    var favBox = box.getAt(index);
                    print(favBox!.id);
                    return InkWell(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          height: 150,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                child: Image.network(
                                  (favBox.pic ?? ""),
                                  fit: BoxFit.cover,
                                  width: 180,
                                  height: 130,
                                ),
                                borderRadius: BorderRadius.circular(7),
                              ),
                              Text("${favBox.name}".tr,
                                  style: GoogleFonts.merriweatherSans(
                                      color: Colors.black,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w300)),
                              SizedBox(
                                height: 3,
                              ),
                              Text("${favBox.disc}",
                                  style: GoogleFonts.merriweatherSans(
                                      color: Colors.black54,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w100)),
                              SizedBox(
                                height: 3,
                              ),
                              Text("\$${favBox.price}",
                                  style: GoogleFonts.merriweatherSans(
                                      color: HexColor(color),
                                      fontSize: 20,
                                      fontWeight: FontWeight.w300)),
                              SizedBox(
                                height: 3,
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Get.to(ProductDetails(
                          price: favBox.price,
                          pic: favBox.pic,
                          disc: favBox.disc,
                          name: favBox.name,
                          id: favBox.id,
                          details: favBox.details,
                          size: favBox.size,
                          color: favBox.color,
                        ));
                      },
                    );
                  },
                ),
                crossAxisCount: 2,
              ),
            ],
          ),
        );
      }
    });
