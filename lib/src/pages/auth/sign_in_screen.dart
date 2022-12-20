import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../config/custom_color.dart';
import '../base/base_screen.dart';
import 'components/custom_text_field.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: CustomColors.customSwatchColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    // Nome do app
                    Text.rich(
                        TextSpan(
                          style: const TextStyle(
                            fontSize: 40,
                          ),
                          children: [
                            const TextSpan(
                              text: 'Green',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )
                            ),
                            TextSpan(
                                text: 'grocer',
                                style: TextStyle(
                                  color: CustomColors.customContrastColor,
                                  fontWeight: FontWeight.bold,
                                )
                            ),
                          ]
                        )
                    ),
                    // Categorias
                    SizedBox(
                      height: 50,
                      child: DefaultTextStyle(
                        style: const TextStyle(
                          fontSize: 25
                        ),
                        child: AnimatedTextKit(
                          repeatForever: true,
                          pause: Duration.zero,
                          animatedTexts: [
                            FadeAnimatedText('Frutas'),
                            FadeAnimatedText('Verduras'),
                            FadeAnimatedText('Legumes'),
                            FadeAnimatedText('Carnes'),
                            FadeAnimatedText('Cereias'),
                            FadeAnimatedText('Laticíneos'),
                          ]
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(top: Radius.circular(45))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const CustomTextField(
                          icon: Icons.email,
                          label: "Email"
                      ),
                      const CustomTextField(
                          icon: Icons.lock,
                          label: "Senha",
                          isSecret: true),
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)
                              )
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context){
                                  return BaseScreen();
                                })
                              );
                            },
                            child: const Text('Entrar',
                              style: TextStyle(fontSize: 18),
                            )
                        ),
                      ),

                      //Esqueceu a senha
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(onPressed: (){},
                            child:  Text(
                                "Esqueceu a senha?",
                                style: TextStyle(color:  CustomColors.customContrastColor),
                            ),
                        ),
                      ),

                      //Divisor
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                            const Padding(
                              padding:  EdgeInsets.only(bottom: 10.0),
                              child:  Text("Ou", style: TextStyle(color: Colors.grey),),
                            ),
                            Expanded(
                              child: Divider(
                                color: Colors.grey.withAlpha(90),
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 50,
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)
                              ),
                              side: const BorderSide(
                                width: 2,
                                color: Colors.green
                              )
                            ),
                            onPressed: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context){
                                      return SignUpScreen();
                                    }
                                ),
                              );
                            },
                            child: const Text(
                              "Criar conta",
                              style: TextStyle(fontSize: 18),)
                        ),
                      )
                    ],
                  ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
