import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotelapp/features/auth/data/express_auth_repo.dart';
import 'package:hotelapp/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:hotelapp/features/auth/presentation/pages/auth_page.dart';
import 'package:hotelapp/theme/light_mode.dart';

// class MyApp extends StatelessWidget {
//   // final authRepo = ExpressAuthRepo();


//   MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//       return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: lightMode,
//         home: LoginPage(),
//     );
//   }
// }
class MyApp extends StatelessWidget {
  final authRepo = ExpressAuthRepo();


  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(authRepo: authRepo)..checkAuth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightMode,
        home: AuthPage(),
      ),
    );
  }
}