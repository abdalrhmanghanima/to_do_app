// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:google_sign_in/google_sign_in.dart' as _i116;
import 'package:injectable/injectable.dart' as _i526;
import 'package:to_do_app/core/di/di.dart' as _i131;
import 'package:to_do_app/data/auth/data_source/auth_remote_data_source.dart'
    as _i720;
import 'package:to_do_app/data/auth/data_source/auth_remote_data_source_impl.dart'
    as _i570;
import 'package:to_do_app/data/auth/repositories/auth_repo_impl.dart' as _i671;
import 'package:to_do_app/data/home/data_source/todo_remote_data_source.dart'
    as _i703;
import 'package:to_do_app/data/home/data_source/todo_remote_data_source_impl.dart'
    as _i1070;
import 'package:to_do_app/data/home/repositories/todo_repo_impl.dart' as _i177;
import 'package:to_do_app/domain/auth/repositories/auth_repo.dart' as _i1051;
import 'package:to_do_app/domain/auth/use_cases/auth_state_changes_use_case.dart'
    as _i887;
import 'package:to_do_app/domain/auth/use_cases/logout_use_case.dart' as _i667;
import 'package:to_do_app/domain/auth/use_cases/sign_in_with_google_use_case.dart'
    as _i473;
import 'package:to_do_app/domain/auth/use_cases/signIn_use_case.dart' as _i564;
import 'package:to_do_app/domain/auth/use_cases/signup_use_case.dart' as _i158;
import 'package:to_do_app/domain/home/repositories/todo_repo.dart' as _i599;
import 'package:to_do_app/presentation/auth/cubit/auth_cubit.dart' as _i181;
import 'package:to_do_app/presentation/home/cubit/to_do_cubit.dart' as _i362;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => registerModule.firestore);
    gh.lazySingleton<_i116.GoogleSignIn>(() => registerModule.googleSignIn);
    gh.lazySingleton<_i720.AuthRemoteDataSource>(
      () => _i570.AuthRemoteDataSourceImpl(
        gh<_i59.FirebaseAuth>(),
        gh<_i974.FirebaseFirestore>(),
        gh<_i116.GoogleSignIn>(),
      ),
    );
    gh.lazySingleton<_i1051.AuthRepository>(
      () => _i671.AuthRepositoryImpl(gh<_i720.AuthRemoteDataSource>()),
    );
    gh.factory<_i473.SignInWithGoogleUseCase>(
      () => _i473.SignInWithGoogleUseCase(gh<_i1051.AuthRepository>()),
    );
    gh.factory<_i887.AuthStateChangesUseCase>(
      () => _i887.AuthStateChangesUseCase(gh<_i1051.AuthRepository>()),
    );
    gh.factory<_i667.LogoutUseCase>(
      () => _i667.LogoutUseCase(gh<_i1051.AuthRepository>()),
    );
    gh.factory<_i564.SignInUseCase>(
      () => _i564.SignInUseCase(gh<_i1051.AuthRepository>()),
    );
    gh.factory<_i158.SignUpUseCase>(
      () => _i158.SignUpUseCase(gh<_i1051.AuthRepository>()),
    );
    gh.factory<_i181.AuthCubit>(
      () => _i181.AuthCubit(
        gh<_i564.SignInUseCase>(),
        gh<_i158.SignUpUseCase>(),
        gh<_i667.LogoutUseCase>(),
        gh<_i887.AuthStateChangesUseCase>(),
        gh<_i473.SignInWithGoogleUseCase>(),
      ),
    );
    gh.lazySingleton<_i703.TodoRemoteDataSource>(
      () => _i1070.TodoRemoteDataSourceImpl(
        gh<_i974.FirebaseFirestore>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.lazySingleton<_i599.TodoRepository>(
      () => _i177.TodoRepositoryImpl(gh<_i703.TodoRemoteDataSource>()),
    );
    gh.factory<_i362.TodoCubit>(
      () => _i362.TodoCubit(gh<_i599.TodoRepository>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i131.RegisterModule {}
