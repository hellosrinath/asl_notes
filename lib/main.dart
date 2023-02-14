import 'package:asl_notes/feature_1/presentation/cubit/auth/auth_cubit.dart';
import 'package:asl_notes/feature_1/presentation/cubit/note/note_cubit.dart';
import 'package:asl_notes/feature_1/presentation/cubit/user/user_cubit.dart';
import 'package:asl_notes/feature_1/presentation/pages/sign_in_page.dart';
import 'package:asl_notes/on_generate_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feature_1/presentation/pages/home_page.dart';
import 'injection_container.dart' as di;
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
            create: (_) => di.sl<AuthCubit>()..appStarted()),
        BlocProvider<UserCubit>(create: (_) => di.sl<UserCubit>()),
        BlocProvider<NoteCubit>(create: (_) => di.sl<NoteCubit>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.deepOrange),
        initialRoute: '/',
        onGenerateRoute: OnGenerateRoute.route,
        routes: {
          "/": (context) {
            return BlocBuilder<AuthCubit, AuthState>(
                builder: (context, authState) {
              if (authState is Authenticated) {
                return HomePage(
                  uid: authState.uid,
                );
              }
              if (authState is UnAuthenticated) {
                return const SignInPage();
              }

              return const CircularProgressIndicator();
            });
          }
        },
      ),
    );
  }
}
