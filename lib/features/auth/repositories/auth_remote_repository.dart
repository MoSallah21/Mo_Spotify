import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:mospotify/core/constants/server_constants.dart';
import 'package:mospotify/core/failure/app_failure.dart';
import 'package:mospotify/features/auth/model/user_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'auth_remote_repository.g.dart';

//here remote that for connect with server it's provider
@riverpod
AuthRemoteRepository authRemoteRepository(AuthRemoteRepositoryRef ref){
  return AuthRemoteRepository();
}
class AuthRemoteRepository {
  Future<Either<AppFailure,UserModel>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    // Send a POST request to the server
    try{
      final response = await http.post(
        Uri.parse('${ServerConstants.serverURL}/auth/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({ // Encode the data to JSON format
          'name': name,
          'email': email,
          'password': password,
        }),
      );
      final resBodyMap =jsonDecode(response.body) as Map<String,dynamic>;
      if(response.statusCode!=201){
        //handle error
        return Left(AppFailure(resBodyMap['detail']));
      }
      return Right(UserModel.fromMap(resBodyMap));
    }
    catch(e){
      return Left(AppFailure(e.toString()));
    }

  }
  Future<Either<AppFailure,UserModel>> login({
    required String email,
    required String password
})async {
    try{
      final response=await http.post(Uri.parse(
          '${ServerConstants.serverURL}/auth/login'
      ),
        body: jsonEncode({
          'email':email,
          'password':password
        }),
        headers: {'Content-Type': 'application/json'}, // Set the content type to JSON
      );
      final resBodyMap =jsonDecode(response.body) as Map<String,dynamic>;
      if(response.statusCode!=200){
        return Left(AppFailure(resBodyMap['detail']));
      }
      return Right(UserModel.fromMap(resBodyMap['user']).copyWith(
        token: resBodyMap['token']
      ));
    }
    catch(e){
      return Left(AppFailure(e.toString()));
    }

  }

}