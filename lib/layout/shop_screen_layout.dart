import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:shop_app/modules/login/login_screen.dart';
import 'package:shop_app/shared/component/component.dart';
import 'package:shop_app/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'salla',
        ),
      ),
      body: TextButton(
        onPressed: () {
          CacheHelper.removeData(key: 'token').then((value) {
            navigateAndFInish(context, LoginScreen());
          });
        },
        child: Text('SIGN OUT'),
      ),
    );
  }
}
