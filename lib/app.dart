import 'package:ecommerce_user/features/auth/ui/auth_page.dart';
import 'package:ecommerce_user/features/dashboard/ui/dashboard_page.dart';
import 'package:ecommerce_user/features/product/ui/product_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ProductPage();
          } else {
            return AuthPage();
          }
        });
  }
}
