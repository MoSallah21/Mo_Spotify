import 'package:fpdart/fpdart.dart';
import 'package:mospotify/features/auth/model/user_model.dart';
import 'package:mospotify/features/auth/repositories/auth_local_repository.dart';
import 'package:mospotify/features/auth/repositories/auth_remote_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewmodel extends _$AuthViewmodel{
  late AuthRemoteRepository _authRemoteRepository;
  late AuthLocalRepository _authLocalRepository;

  @override
  AsyncValue<UserModel>? build(){
    _authRemoteRepository=ref.watch(authRemoteRepositoryProvider);
    _authLocalRepository=ref.watch(authLocalRepositoryProvider);
    return null;
  }
  Future<void>initSharedPreferences()async{
    await _authLocalRepository.init();
  }
  Future<void>signUpUser({
    required String name,
    required String email,
    required String password,
})async{
    state= const AsyncValue.loading();
    final res=await _authRemoteRepository.signup(
        name: name,
        email: email,
        password: password);
    final val = switch(res){
      Left(value:final l)=>state=AsyncValue.error(l.message, StackTrace.current),
      Right(value:final r)=>state=AsyncValue.data(r),
    };
    print(val);
  }
  Future<void>logInUser(
  {
    required String email,
    required String password,
}
      )async{
    state =const AsyncValue.loading();
    final res=await _authRemoteRepository.login(
        email: email,
        password: password);
    final val = switch(res){
      Left(value:final l)=>state=AsyncValue.error(l.message, StackTrace.current),
      Right(value:final r)=>state=AsyncValue.data(r),
    };
    print(val);
  }
  AsyncValue<UserModel>?_loginSuccess(UserModel user){
    _authLocalRepository.setToken(user.token);
   return state=AsyncValue.data(user);


  }


}