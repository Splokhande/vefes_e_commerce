import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vefes_e_commerce/constant.dart';
import 'package:vefes_e_commerce/riverpod/product.dart';
import 'package:vefes_e_commerce/screen/my_cart.dart';
import 'package:vefes_e_commerce/screen/product_detail.dart';
import 'package:vefes_e_commerce/widgets.dart';

class ProductList extends StatelessWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => Mycart()));
              },
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: kBackgroundColor,
              ))
        ],
      ),
      body: Container(
        height: 0.85.sh,
        width: 1.sw,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [ProductListPod()],
        ),
      ),
    );
  }
}

class ProductListPod extends ConsumerWidget {
  const ProductListPod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var prod = ref.watch(productPro);
    AsyncValue product = ref.watch(productFuture);
    return product.when(
        data: (data) => Container(
              height: 0.85.sh,
              width: 1.sw,
              decoration: const BoxDecoration(),
              child: GridView.builder(
                itemCount: prod.productList.length,
                shrinkWrap: true,
                addAutomaticKeepAlives: true,
                itemBuilder: (_, i) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ProductDetail(
                                    detail: prod.productList[i],
                                    tag: 'product_image$i',
                                  )));
                    },
                    child: CustomCard(
                      detail: prod.productList[i],
                      tag: 'product_image$i',
                    ),
                  );
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: 0.9,
                ),
              ),
            ),
        error: (_, __) => Container(
              width: 1.sw,
              height: 0.8.sh,
              child: Center(
                child: Text(
                  "Something went wrong",
                  style: TextStyle(
                      color: kPrimaryTextColor, fontSize: fsTextFontSize),
                ),
              ),
            ),
        loading: () => Container(
            width: 1.sw,
            height: 0.8.sh,
            child: Center(child: CircularProgressIndicator())));
  }
}
