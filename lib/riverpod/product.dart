import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vefes_e_commerce/model/product_detail.dart';
import 'package:vefes_e_commerce/screen/product_list.dart';
import 'package:vefes_e_commerce/sqflite/helper.dart';
import 'package:vefes_e_commerce/widgets.dart';

var productFuture =
    FutureProvider.autoDispose<List<ProductDetailModel>>((ref) async {
  await ref.watch(productPro).getList();
  return ref.watch(productPro).productList;
});

var productPro = ChangeNotifierProvider<ProductPod>((ref) => ProductPod(ref));

class ProductPod extends ChangeNotifier {
  Ref ref;

  ProductPod(this.ref) {
    if (cartList.isEmpty) getCartList();
  }
  final dbHelper = MyCartHelper.instance;
  ProductDetailModel detail = ProductDetailModel();
  List<ProductDetailModel> productList = [];
  List<ProductDetailModel> cartList = [];
  List<ProductDetailModel> dbCartList = [];
  String total = "0";

  CustomWidget customWidget = CustomWidget();
  getList() async {
    String data = await rootBundle.loadString('assets/product.json');
    var jsonResult = json.decode(data);
    productList.clear();
    print(jsonResult);
    for (int i = 0; i < jsonResult.length; i++) {
      ProductDetailModel detail = ProductDetailModel.fromJson(jsonResult[i]);
      productList.add(detail);
    }
  }

  addToCart(int id) async {
    ProductDetailModel detail =
        productList.firstWhere((element) => element.id == id);
    if (!cartList.any((element) => element.id == id)) {
      detail.quantity = 1;
      cartList.add(detail);
      await dbHelper.insert(detail);

      customWidget.toast("Added to cart");
    } else {
      int i = cartList.indexWhere((element) => element.id == id);
      increaseQuantity(i);
      await dbHelper.update(cartList[i]);
      customWidget.toast("Quantity increased by 1");
    }
    calculateTotal();
  }

  getCartList() async {
    var data = await dbHelper.queryAllRows();
    for (int i = 0; i < data.length; i++) {
      cartList.add(ProductDetailModel.fromJson(data[i]));
    }
    calculateTotal();
  }

  increaseQuantity(int i) async {
    cartList[i].quantity = cartList[i].quantity! + 1;
    await dbHelper.update(cartList[i]);
    calculateTotal();
  }

  reduceQuantity(int i) async {
    if (cartList[i].quantity == 1) {
      await dbHelper.delete(cartList[i].id!);
      cartList.removeAt(i);
    } else {
      cartList[i].quantity = cartList[i].quantity! - 1;
      await dbHelper.update(cartList[i]);
    }
    calculateTotal();
  }

  calculateTotal() {
    total = "0";
    for (int i = 0; i < cartList.length; i++) {
      total =
          (double.parse(total) + (cartList[i].price! * cartList[i].quantity!))
              .toStringAsFixed(2);
    }
    notifyListeners();
  }

  checkout() async {
    cartList.clear();
    await dbHelper.clearTable();
    Get.to(ProductList());
    notifyListeners();
  }
}
