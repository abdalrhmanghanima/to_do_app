import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/core/di/di.dart';
import 'package:to_do_app/core/routing/app_routes.dart';
import 'package:to_do_app/firebase_options.dart';
import 'package:to_do_app/presentation/auth/cubit/auth_cubit.dart';
import 'package:to_do_app/presentation/auth/screens/sign_up_screen.dart';
import 'package:to_do_app/presentation/home/cubit/to_do_cubit.dart';
import 'package:to_do_app/presentation/home/screens/home_screen.dart';
import 'package:to_do_app/presentation/auth/screens/sign_in_screen.dart';
import 'package:to_do_app/presentation/profile/screens/change_password_screen.dart';
import 'package:to_do_app/presentation/profile/screens/profile_screen.dart';
import 'package:to_do_app/presentation/todo_details/screens/todo_detail_screen.dart';
import 'package:to_do_app/presentation/widgets/auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await configureDependencies();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<AuthCubit>()..listenToAuthChanges()),

        BlocProvider(create: (_) => sl<TodoCubit>()..listenToTodos()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        routes: {
          AppRoutes.signUp: (_) => const SignUpScreen(),
          AppRoutes.signIn: (_) => const SignInScreen(),
          AppRoutes.homeScreen: (_) => const HomeScreen(),
          AppRoutes.todoDetail: (_) => const TodoDetailScreen(),
          AppRoutes.profile: (_) => const ProfileScreen(),
          AppRoutes.changePassword: (_) => ChangePasswordScreen(),
        },

        home: const AuthGate(),
      ),
    );
  }
}
