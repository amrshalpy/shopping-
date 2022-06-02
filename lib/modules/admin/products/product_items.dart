import 'package:e_comarce/home/cubit/cubit.dart';
import 'package:e_comarce/home/cubit/states.dart';
import 'package:e_comarce/models/category_model.dart';
import 'package:e_comarce/models/product_model.dart';
import 'package:e_comarce/modules/admin/category/add_product/add_product.dart';
import 'package:e_comarce/shared/components/conistance.dart';
import 'package:e_comarce/shared/components/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

class ProductItems extends StatelessWidget {
  CategoryModel? model;
  ProductItems({Key? key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeLayoutCubit>(
      create: (context) => HomeLayoutCubit()..getProductsModel()..getCategoriesModel()..getProducts(name: model!.name),
      child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          HomeLayoutCubit cubit = HomeLayoutCubit.get(context);
          return Scaffold(
            body:

            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
                    child: Text('${model!.name}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                    )
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: ElevatedButton(onPressed: (){

                        nextPage(context: context, page: AddProducts(model: model,));
                      },style:ElevatedButton.styleFrom(primary: HexColor(color),),
                          child: Text('Add Product')),
                    ),
                  ),
                  cubit.productsModel.isNotEmpty?
                  GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1 / 1.6,
                      crossAxisSpacing: 3,
                      mainAxisSpacing: 3,
                    ),
                    itemCount: cubit.productsModel.length,
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) =>
                        getProductitems(cubit.productsModel[index], context),
                  ):Center(child: CircularProgressIndicator()),
                ],
              ),
            ),

          );
        },
      ),
    );
  }
  Widget getProductitems(ProdcutModel product, context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Container(
        height: 170,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all( width: .2),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Column(
            children: [
              Image(
                image: NetworkImage('${product.pic}'),
                height: 140,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
    SizedBox(height: 10,),
                Text( '${product.name}',
                style: TextStyle(
                  color: HexColor(color),
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
                ),

              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                   Text('\$${product.price}',
                     style: TextStyle(
                       color: Colors.black,

                       fontWeight: FontWeight.w700,
                       fontSize: 17,
                     ),
                   ),
                  // IconButton(onPressed: (){
                  // },
                  //     icon: Icon(Icons.delete,
                  //     color: Colors.red,
                  //     ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
