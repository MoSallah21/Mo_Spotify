import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mospotify/core/theme/app_pallete.dart';
import 'package:mospotify/core/widgets/loader.dart';
import 'package:mospotify/core/widgets/utils.dart';
import 'package:mospotify/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:mospotify/features/auth/view/widgets/custom_field.dart';
import 'package:mospotify/features/auth/viewmodel/auth_viewmodel.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final formKey =GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
    formKey.currentState!.validate();
  }
  @override
  Widget build(BuildContext context) {
    final isLoading=ref.watch(authViewmodelProvider)?.isLoading==true;
    ref.listen(authViewmodelProvider, (_,next){
      next?.when(
          data: (data){
            //TODO: Navigate to home page
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context)=> const HomePage()
            //     ));
          },
          error: (error,st){
            showSnackBar(context, error.toString());
          },
          loading: (){});
    });


    return  Scaffold(
      appBar: AppBar(),
      body: isLoading?Loader():Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Sign In.',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 30,),
                  const SizedBox(height: 15,),
                  CustomField(
                      controller: emailController,
                      hintText:
                      'Email'
                  ),
                  const SizedBox(height: 15,),
                  CustomField(
                      isObscureText: true ,
                      controller: passwordController,
                      hintText:
                      'Password'
                  ),
                  const SizedBox(height: 20,),
                  AuthGradientButton(buttonText: 'Log In',onTap: ()async{
                    if(formKey.currentState!.validate()) {
                      await ref.
                      read(authViewmodelProvider.notifier).
                      logInUser(
                          email: emailController.text,
                          password: passwordController.text);
                    }
                  },),
                  const SizedBox(height: 20,),
                  RichText(
                      text: TextSpan(
                          text: 'Don\'t have an account?',
                          style: Theme.of(context).textTheme.titleMedium,
                          children: [
                            TextSpan(
                                text: '  Sign Up',
                                style:TextStyle(
                                  color: Pallete.gradient2,
                                  fontWeight: FontWeight.bold,

                                )
                            )
                          ]

                      )),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
