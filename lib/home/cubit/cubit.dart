// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:ui';

import 'package:e_comarce/home/home_layout.dart';
import 'package:e_comarce/models/order_model.dart';
import 'package:e_comarce/modules/favourite/favourite_product.dart';
import 'package:e_comarce/modules/productDetails/noSql/nosql.dart' as nosql;
import 'package:e_comarce/shared/components/components.dart';
import 'package:e_comarce/shared/components/conistance.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:e_comarce/home/cubit/states.dart';
import 'package:e_comarce/models/cart_model.dart';
import 'package:e_comarce/models/category_model.dart';
import 'package:e_comarce/models/product_model.dart';
import 'package:e_comarce/modules/carts/carts_screen.dart';
import 'package:e_comarce/modules/home_page/home_page_screen.dart';
import 'package:e_comarce/modules/settings/settings_screen.dart';
import 'package:e_comarce/shared/network/local.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutStates> {
  HomeLayoutCubit() : super(initialHomeLayoutState());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  List<Widget> Screens = [
    Home(),
    Carts(),
    Favourite(),
    SettingsScreen(),
  ];

  int currentIndex = 0;

  void changeIndex(index) {
    currentIndex = index;
    emit(changeIndexSuccessfully());
  }

  // List<CategoryModel>? categoryModel = [];
  //
  // void getCategories() {
  //   categoryModel = [];
  //   emit(getCategoriesLoadingState());
  //   FirebaseFirestore.instance.collection('categories').get().then((value) {
  //     value.docs.forEach((element) {
  //       categoryModel!.add(CategoryModel.fromJson(element.data()));
  //     });
  //     if (categoryModel!.length == value.docs.length)
  //       emit(getCategoriesSuccessState());
  //   }).catchError((e) {
  //     print(e);
  //     emit(getCategoriesErrorState());
  //   });
  // }

  // List<ProdcutModel>? productModel = [];

  // void getProducts() {
  //   emit(getProductsLoadingState());
  //   productModel = [];
  //   emit(getProductsLoadingState());
  //   FirebaseFirestore.instance.collection('products').get().then((value) {
  //     value.docs.forEach((element) {
  //       productModel!.add(ProdcutModel.fromJson(element.data()));
  //     });
  //     if (productModel!.length == value.docs.length)
  //       emit(getProductsSuccessState());
  //   }).catchError((e) {
  //     print(e);
  //     emit(getProductsErrorState());
  //   });
  // }

  // List<ProdcutModel>? categoruProductModel = [];
  // void getCategoryProductModel(String id) {
  //   emit(getCategoruProductModelLoadingState());
  //   categoruProductModel = [];
  //   emit(getCategoruProductModelLoadingState());
  //   FirebaseFirestore.instance.collection('categories').doc(id).collection('products').get().then((value) {
  //    value.docs.forEach((element) {
  //      categoruProductModel!.add(ProdcutModel.fromJson(element.data()));
  //    });
  //     // if (categoruProductModel!.length == value.docs.length)
  //       emit(getCategoruProductModelSuccessState());
  //   }).catchError((e) {
  //     print(e);
  //     emit(getCategoruProductModelErrorState());
  //   });
  // }
  File? imageProduct;
  void addProduct({
    required name,
    required price,
    required category,
    required details,
    required description,
    String? image,
    String? size,
    String? color,
  }) {
    ProdcutModel model = ProdcutModel(
        disc: description,
        size: size,
        name: name,
        pic: image,
        price: price,
        category: category,
        details: details);
    emit(AddCategoryLoading());
    FirebaseFirestore.instance
        .collection(kProduct)
        .add(model.toMap())
        .then((value) {
      emit(AddCategorySucsses());
    }).catchError((er) {
      emit(AddCategoryError());
      print(er.toString());
    });
  }

  Future setImageProduct() async {
    emit(SetImageProductLoading());
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageProduct = File(image.path);
      emit(SetImageProductSucsses());
    } else {
      print('no image');
      emit(SetImageProductError());
    }
  }

  ProdcutModel? productModel;
  void saveImageProduct({
    required name,
    required price,
    required category,
    required details,
    required description,
    required size,
  }) {
    emit(SaveImageProductLoading());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('Product/${Uri.file(imageProduct!.path).pathSegments.last}')
        .putFile(imageProduct!)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        addProduct(
          details: details,
          name: name,
          image: value,
          category: category,
          description: description,
          color: color,
          price: price,
          size: size,
        );
        emit(SaveImageProductSucsses());
        removeImageProduct();
      }).catchError((er) {
        emit(SaveImageProductError());

        print(er.toString());
      });
    }).catchError((er) {
      emit(SaveImageProductError());

      print(er.toString());
    });
  }


  CategoryModel? categoryModel;

  void removeImageProduct() {
    imageProduct = null;
    emit(RemoveImageCategorySucsses());
  }

  List<ProdcutModel> productsModel = [];
  void getProducts({String? name}) {
    emit(GetCategoryLoading());
    FirebaseFirestore.instance.collection(kProduct).snapshots().listen((event) {
      productsModel = [];
      event.docs.forEach((element) {
       if (element.data()['category'] == name)
        productsModel.add(ProdcutModel.fromJson(element.data()));
        emit(GetCategorySucsses());
      });
    });
  }

  List<ProdcutModel> products = [];
  void getProductsModel() {
    emit(GetCategoryLoading());
    FirebaseFirestore.instance.collection(kProduct).snapshots().listen((event) {
      products = [];
      event.docs.forEach((element) {
       // if (element.data()['category'] == name)
          products.add(ProdcutModel.fromJson(element.data()));
        emit(GetCategorySucsses());
      });
    });
  }

  void deleteProduct(id){
    FirebaseFirestore.instance.collection(kProduct).doc(id).delete()
        .then((value) {
      getProducts();
    }).catchError((er){print(er.toString());});
  }

  bool isAdmin = false;
  getAdmin() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      if (value.data()!['isAdmin'] == true) isAdmin = true;
      emit(getAdminState());
    });
  }

  void addCategory({
    required String title,
    required String image,
  }) {
    CategoryModel model = CategoryModel(
      picture: image,
      name: title,
    );
    emit(AddCategoryLoading());
    FirebaseFirestore.instance
        .collection(kCategory)
        .add(model.toMap())
        .then((value) {
      emit(AddCategorySucsses());
    }).catchError((er) {
      emit(AddCategoryError());
      print(er.toString());
    });
  }

  File? imageCategory;
  var picker = ImagePicker();

  Future setImageCategory() async {
    emit(SetImageCategoryLoading());
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageCategory = File(image.path);
      emit(SetImageCategorySucsses());
    } else {
      print('no image');
      emit(SetImageCategoryError());
    }
  }

  void saveImageCategory({required String title}) {
    emit(SaveImageCategoryLoading());

    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('category/${Uri.file(imageCategory!.path).pathSegments.last}')
        .putFile(imageCategory!)
        .then((val) {
      val.ref.getDownloadURL().then((value) {
        addCategory(title: title, image: value);
        emit(SaveImageCategorySucsses());
        removeImageCategory();
      }).catchError((er) {
        emit(SaveImageCategoryError());

        print(er.toString());
      });
    }).catchError((er) {
      emit(SaveImageCategoryError());

      print(er.toString());
    });
  }

  void removeImageCategory() {
    imageCategory = null;
    emit(RemoveImageCategorySucsses());
  }

  List<CategoryModel> categories = [];
  void getCategoriesModel() {
    emit(GetCategoryLoading());
    FirebaseFirestore.instance
        .collection(kCategory)
        .snapshots()
        .listen((event) {
      categories = [];
      event.docs.forEach((element) {
        categories.add(CategoryModel.fromJson(element.data()));
        emit(GetCategorySucsses());
      });
    });
  }

//   List<ProdcutModel>? categoruProductMenModel = [];
//    getCategoryProductMenModel(String id) {
//     emit(getCategoruProductModelLoadingState());
//     categoruProductMenModel = [];
//     emit(getCategoruProductModelLoadingState());
//     FirebaseFirestore.instance.collection('categories').doc(id).collection('products').get().then((value) {
//       value.docs.forEach((element) {
//         categoruProductMenModel!.add(ProdcutModel.fromJson(element.data()));
//       });
//       emit(getCategoruProductModelSuccessState());
//     }).catchError((e) {
//       print(e);
//       emit(getCategoruProductModelErrorState());
//     });
//   }
//
//   List<ProdcutModel>? categoruProductGamingModel = [];
//    getCategoryProductGamingModel(String id) {
//     emit(getCategoruProductModelLoadingState());
//     categoruProductGamingModel = [];
//     emit(getCategoruProductModelLoadingState());
//     FirebaseFirestore.instance.collection('categories').doc(id).collection('products').get().then((value) {
//       value.docs.forEach((element) {
//         categoruProductGamingModel!.add(ProdcutModel.fromJson(element.data()));
//       });
//       emit(getCategoruProductModelSuccessState());
//     }).catchError((e) {
//       print(e);
//       emit(getCategoruProductModelErrorState());
//     });
//   }
//
//   List<ProdcutModel>? categoruProductWomenModel = [];
//    getCategoryProductWomenModel(String id) {
//     emit(getCategoruProductModelLoadingState());
//     categoruProductWomenModel = [];
//     emit(getCategoruProductModelLoadingState());
//     FirebaseFirestore.instance.collection('categories').doc(id).collection('products').get().then((value) {
//       value.docs.forEach((element) {
//         categoruProductWomenModel!.add(ProdcutModel.fromJson(element.data()));
//       });
//       // if (categoruProductModel!.length == value.docs.length)
//       emit(getCategoruProductModelSuccessState());
//     }).catchError((e) {
//       print(e);
//       emit(getCategoruProductModelErrorState());
//     });
//   }
//
//
//   List<ProdcutModel>? categoruProductDeviceModel = [];
//    getCategoryProductDeviceModel(String id) {
//     emit(getCategoruProductModelLoadingState());
//     categoruProductDeviceModel = [];
//     emit(getCategoruProductModelLoadingState());
//     FirebaseFirestore.instance.collection('categories').doc(id).collection('products').get().then((value) {
//       value.docs.forEach((element) {
//         categoruProductDeviceModel!.add(ProdcutModel.fromJson(element.data()));
//       });
//       // if (categoruProductModel!.length == value.docs.length)
//       emit(getCategoruProductModelSuccessState());
//     }).catchError((e) {
//       print(e);
//       emit(getCategoruProductModelErrorState());
//     });
//   }
//
//
//   List<ProdcutModel>? categoruProductGadgetModel = [];
//    getCategoryProductGadgetModel(String id) {
//     emit(getCategoruProductModelLoadingState());
//     categoruProductGadgetModel = [];
//     emit(getCategoruProductModelLoadingState());
//     FirebaseFirestore.instance.collection('categories').doc(id).collection('products').get().then((value) {
//       value.docs.forEach((element) {
//         categoruProductGadgetModel!.add(ProdcutModel.fromJson(element.data()));
//       });
//       // if (categoruProductModel!.length == value.docs.length)
//       emit(getCategoruProductModelSuccessState());
//     }).catchError((e) {
//       print(e);
//       emit(getCategoruProductModelErrorState());
//     });
//   }
//
// getAll({menId, WomenId, deviceId, ganmingId, gadgetId}){
//   getCategoryProductGadgetModel(gadgetId);
//   getCategoryProductDeviceModel(deviceId);
//   getCategoryProductWomenModel(WomenId);
//   getCategoryProductGamingModel(ganmingId);
//   getCategoryProductMenModel(menId);
//   emit(getAllState());
// }
  List<CartModel>? cartModel = [];

  getAllCarts() {
    cartModel = [];
    emit(getCartsLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cart')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        cartModel!.add(CartModel.fromJson(element.data()));
      });
      if (cartModel!.length == value.docs.length) emit(getCartsSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(getCartsErrorState());
    });
  }

  List<int> numper = [];
  int? sum;

  getTotalPrice() {
    sum = 0;
    int x = 0;
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cart')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        numper.add(element.data()['howMany']);
        x = element.data()['price'] * element.data()['howMany'];
        sum = (sum! + x);
      });
      emit(getCartsSuccessState());
      print(sum.toString());
    }).catchError((e) {
      print(e.toString());
      emit(getCartsErrorState());
    });
  }

  void increaseUi(index) {
    numper[index]++;
    emit(increaseUiState());
  }

  void decreaseUi(index) {
    if (numper[index] != 1) numper[index]--;
    emit(decreaseUiState());
  }

  void increaseInFire(id, index) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cart')
        .doc(id)
        .update({
      'howMany': numper[index],
    }).then((value) {
      getTotalPrice();
      emit(increaseUiState());
    }).catchError((e) {
      print(e.toString());
    });
  }

  void decreaseInFire(id, index) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cart')
        .doc(id)
        .update({
      'howMany': numper[index],
    }).then((value) {
      getTotalPrice();
      emit(increaseUiState());
    }).catchError((e) {
      print(e.toString());
    });
  }

  deleteFromCart(id, index) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cart')
        .doc(id)
        .delete()
        .then((value) {
      emit(deleteState());
    }).catchError((e) {
      print(e.toString());
    });
  }

  getUserdata() {
    emit(saveUserDataLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      CacheHelper.saveData(key: "Name", value: value.data()!['name']);

      CacheHelper.saveData(key: "Picture", value: value.data()!['pic']);
      CacheHelper.saveData(key: "Email", value: value.data()!['email'] ?? "");
      CacheHelper.saveData(key: "Uid", value: value.data()!['uid']);
      emit(saveUserDataSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(saveUserDataErrorState());
    });
  }

  String? value;

  changeradio(val) {
    value = val;
    print(value);
    emit(changedState());
  }

  File? profileImage;

  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(getProfileImagePickerSuccessState());
    } else {
      print('No image selected.');
      emit(getProfileImagePickerErrorState());
    }
  }

  File? image;

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      emit(getProfileImagePickerSuccessState());
    } else {
      print('No image selected.');
      emit(getProfileImagePickerErrorState());
    }
  }

  updateData(
      {required TextEditingController emailController,
      required TextEditingController nameController}) {
    emit(LoadingUpdateState());
    if (profileImage == null) {
      emit(LoadingUpdateState());
      return FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'email': emailController.text,
        'name': nameController.text,
      }).then((value) {
        FirebaseAuth.instance.currentUser!.updateEmail(emailController.text);
        FirebaseAuth.instance.currentUser!
            .updateDisplayName(nameController.text);
        emit(SuccessUpdateState());
        CacheHelper.saveData(key: "Name", value: nameController.text);
        CacheHelper.saveData(key: "Email", value: emailController.text);
        Get.offAll(HomeLayout());
        profileImage = null;
      }).catchError((e) {
        print(e.toString());
        emit(ErrorUpdateState());
      });
    } else {
      emit(LoadingUpdateState());
      return firebase_storage.FirebaseStorage.instance
          .ref()
          .child(
              'usersImages/${Uri.file(profileImage!.path).pathSegments.last}')
          .putFile((profileImage as File))
          .then((val) {
        emit(LoadingUpdateState());
        val.ref.getDownloadURL().then((valuee) {
          emit(LoadingUpdateState());
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({
            'email': emailController.text,
            'name': nameController.text,
            'pic': valuee,
          }).then((value) {
            FirebaseAuth.instance.currentUser!
                .updateEmail(emailController.text);
            FirebaseAuth.instance.currentUser!
                .updateDisplayName(nameController.text);
            emit(SuccessUpdateState());
            CacheHelper.saveData(key: "Name", value: nameController.text);
            CacheHelper.saveData(key: "Email", value: emailController.text);
            CacheHelper.saveData(key: "Picture", value: valuee);
            Get.offAll(HomeLayout());
            profileImage = null;
          }).catchError((e) {
            print(e.toString());
            emit(ErrorUpdateState());
          });
        });
      });
    }
  }

  List<OrderModel> orders = [];
  getAllAddress() {
    orders = [];
    emit(getOrdersLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('orders')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        orders.add(OrderModel.fromJson(element.data()));
      });
      emit(getOrdersSuccessState());
    }).catchError((e) {
      emit(getOrdersErrorState());
    });
  }

  deleteOrder(context, model) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('orders')
        .doc(model.orderId)
        .delete()
        .then((value) {
      getAllAddress();
      emit(deletedSuccessfullyState());
      Toast(
          text: "Deleted Successfully".tr,
          color: Colors.green,
          context: context);
    });
  }

  void onPressFav(
      {required String name,
      required String id,
      required String details,
      required String disc,
      required String pic,
      required int price,
      required String color,
      required String size,
      context}) async {
    var favBox = Hive.box<nosql.ProdcutModel>('fov');
    if (favBox.containsKey(id)) {
      favBox.delete(id).then((value) {
        Toast(
            text: "Removed from favourite successfully".tr,
            color: Colors.green,
            context: context);
        emit(removedFromFavSuccess());
      }).catchError((e) {
        print(e.toString());
        emit(removedFromFavError());
      });
    } else {
      favBox.put(
          id,
          nosql.ProdcutModel(
              name: name,
              disc: disc,
              pic: pic,
              price: price,
              color: color,
              size: size,
              details: details,
              id: id));
      Toast(
          text: "Added to favourite successfully".tr,
          color: Colors.green,
          context: context);
      emit(addFavState());
    }
  }

  Color? col;
  changeColor(id, favBox) {
    if (favBox.containsKey(id)) {
      col = Colors.red;
      emit(changed());
    } else {
      col = Colors.grey;
      emit(changed());
    }
  }
}
