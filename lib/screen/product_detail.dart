import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vefes_e_commerce/constant.dart';
import 'package:vefes_e_commerce/model/product_detail.dart';
import 'package:vefes_e_commerce/riverpod/product.dart';

class ProductDetail extends StatelessWidget {
  ProductDetailModel detail;
  String tag;
  ProductDetail({Key? key, required this.detail, required this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
      ),
      backgroundColor: kBackgroundColor,
      body: Container(
        width: 1.sw,
        height: 1.sh,
        child: Stack(
          children: [
            Positioned(
              right: 10,
              top: 0.15.sh,
              height: 0.3.sh,
              width: 0.4.sw,
              child: Hero(
                tag: tag,
                child: CachedNetworkImage(
                  imageUrl: detail.image!,
                ),
              ),
            ),
            Positioned(
                top: 0.05.sh,
                left: 0,
                height: 1.2.sh,
                width: 1.sw,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 1.sw,
                      height: 0.42.sh,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                              // title: Text("Product:"),
                              subtitle: Text(
                            detail.title!,
                            style: TextStyle(
                                fontSize: fsSubtitleFontSize,
                                fontWeight: FontWeight.w600),
                          )),
                          ListTile(
                              title: Text("Price"),
                              subtitle: Text(
                                "\u{20B9}${detail.price!}",
                                style: TextStyle(fontSize: fsMediumFontSize),
                              )),
                          ListTile(
                              title: Text("Ratings"),
                              subtitle: Text(
                                "${detail.rating!.rate!}",
                                style: TextStyle(fontSize: fsMediumFontSize),
                              )),
                          ListTile(
                              title: Text("Category"),
                              subtitle: Text(
                                detail.category!,
                                style: TextStyle(fontSize: fsMediumFontSize),
                              )),
                        ],
                      ),
                    ),
                    const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
                      child: Divider(
                        color: kPrimaryHintColor,
                        height: 1,
                      ),
                    ),
                    SizedBox(height: 0.01.sh),
                    Container(
                      width: 1.sw,
                      height: 0.5.sh,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        detail.description!,
                        style: TextStyle(fontSize: fsMediumFontSize),
                        softWrap: true,
                        textAlign: TextAlign.justify,
                      ),
                    )
                  ],
                )),
          ],
        ),
      ),
      floatingActionButton: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          var prod = ref.watch(productPro);
          return FloatingActionButton(
            backgroundColor: kPrimaryColor,
            onPressed: () async {
              await prod.addToCart(detail.id!);
            },
            child: Center(
              child: Icon(
                Icons.add_shopping_cart_rounded,
                color: kBackgroundColor,
                size: 20.sp,
              ),
            ),
          );
        },
      ),
    );
  }
}
