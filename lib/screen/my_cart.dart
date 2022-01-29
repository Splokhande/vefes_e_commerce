import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:vefes_e_commerce/constant.dart';
import 'package:vefes_e_commerce/riverpod/product.dart';
import 'package:vefes_e_commerce/widgets.dart';

class Mycart extends ConsumerStatefulWidget {
  Mycart({Key? key}) : super(key: key);

  @override
  _MycartState createState() => _MycartState();
}

class _MycartState extends ConsumerState<Mycart> {
  @override
  Widget build(BuildContext context) {
    var pro = ref.watch(productPro);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
        ),
        body: Container(
          width: 1.sw,
          height: 1.sh,
          child: ListView.builder(
              itemCount: pro.cartList.length,
              shrinkWrap: true,
              addAutomaticKeepAlives: true,
              itemBuilder: (_, i) {
                return CustomTile(
                    detail: ref.watch(productPro).cartList[i], index: i);
              }),
        ),
        bottomNavigationBar: Container(
          width: 0.8.sw,
          height: 0.075.sh,
          decoration: const BoxDecoration(
            color: kPrimaryColor,
          ),
          child: Row(
            children: [
              Container(
                width: 0.7.sw,
                height: 0.075.sh,
                decoration: const BoxDecoration(
                    // borderRadius: BorderRadius.circular(15),
                    color: kBackgroundColor),
                child: Center(
                  child: Text(
                    'Checkout',
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: 0.1.sw,
                  height: 0.075.sh,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: kBackgroundColor),
                      ),
                      Text(
                        'Rs ${pro.total}',
                        style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            color: kBackgroundColor),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
