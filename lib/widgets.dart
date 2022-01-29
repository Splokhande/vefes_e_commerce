import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vefes_e_commerce/constant.dart';
import 'package:vefes_e_commerce/model/product_detail.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vefes_e_commerce/riverpod/product.dart';

class CustomWidget {
  toast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        backgroundColor: kPrimaryColor,
        textColor: kPrimaryTextColor,
        gravity: ToastGravity.BOTTOM);
  }
}

class CustomCard extends StatelessWidget {
  ProductDetailModel detail;
  String tag;
  CustomCard({Key? key, required this.detail, required this.tag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(

          // borderRadius: BorderRadius.circular(15),
          // border: Border.all(color: kPrimaryTextColor, width: 1)s
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Container(
              height: 0.4.sw,
              width: 0.4.sw,
              color: kBackgroundColor,
              child: CustomImage(
                tag: tag,
                image: detail.image!,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
            child: Text(
              detail.title!,
              maxLines: 1,
              style: TextStyle(fontSize: fsSmallFontSize),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("\u{20B9}${detail.price!}"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.star,
                      size: fsTextFontSize,
                    ),
                    Text("${detail.rating!.rate!}"),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomImage extends StatelessWidget {
  String? image;
  String? tag;
  CustomImage({Key? key, this.image, this.tag}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag!,
      child: CachedNetworkImage(
        imageUrl: image!,
        fit: BoxFit.contain,
        placeholder: (_, i) {
          return SizedBox(
              width: 0.05.sw,
              height: 0.05.sw,
              child: const Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}

class CustomTile extends HookConsumerWidget {
  ProductDetailModel detail;
  int index;
  CustomTile({Key? key, required this.detail, required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var prod = ref.watch(productPro);
    return Container(
      width: 1.sw,
      height: 0.15.sh,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 0.1.sh,
            height: 0.1.sh,
            child: CustomImage(
              image: detail.image,
              tag: '${detail.id}',
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    detail.title!,
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
                  ),
                  SizedBox(
                    height: 0.02.sh,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Rs. ${detail.price!}",
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 12.sp),
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await prod.increaseQuantity(index);
                            },
                            child: Container(
                              height: 0.075.sw,
                              width: 0.075.sw,
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Icon(
                                  Icons.add,
                                  color: kBackgroundColor,
                                  size: 12.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 0.1.sw,
                            child: Center(
                              child: Text(
                                "${detail.quantity!}",
                                style: TextStyle(fontSize: 15.sp),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await prod.reduceQuantity(index);
                            },
                            child: Container(
                              height: 0.075.sw,
                              width: 0.075.sw,
                              decoration: BoxDecoration(
                                  color: kPrimaryColor,
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: Text(
                                  "-",
                                  style: TextStyle(
                                      color: kBackgroundColor, fontSize: 12.sp),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
