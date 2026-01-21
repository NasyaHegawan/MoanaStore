import 'package:flutter/material.dart';
import 'package:toko_onlie_postman/views/dashboard.dart';
import 'package:toko_onlie_postman/views/login_view.dart';
import 'package:toko_onlie_postman/views/register_user_view.dart';

void main() {
  runApp(MaterialApp(
initialRoute: '/login',
routes: {
'/': (context) => RegisterUserView(),
'/login':(context) => LoginView(),
'/dashboard':(context) => DashboardView(),
},
));
}