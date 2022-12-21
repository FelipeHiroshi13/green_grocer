import 'package:flutter/material.dart';
import 'package:greengrocer/src/pages/common_widgets/custom_text_field.dart';
import 'package:greengrocer/src/config/app_data.dart' as app_data;

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Perfil do usuário"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
        children: [
          //Email
          CustomTextField(
            initialValue: app_data.user.email,
            icon: Icons.email,
            label: "Email",
          ),

          //Nome
          CustomTextField(
            initialValue: app_data.user.name,
            icon: Icons.person,
            label: "Nome",
          ),

          //Celular
          CustomTextField(
            initialValue: app_data.user.phone,
            icon: Icons.phone,
            label: "Celular",
            isReadOnly: true,
          ),

          //Cpf
          CustomTextField(
            initialValue: app_data.user.cpf,
            icon: Icons.copy,
            label: "CPF",
            isReadOnly: true,
            isSecret: true,
          ),

          //Atualizar CPF
          SizedBox(
            height: 50,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.green),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                updatePassword();
              },
              child: const Text(
                'Atualizar senha',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool?> updatePassword() {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Atualização de senha',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const CustomTextField(
                        icon: Icons.lock,
                        label: 'Senha atual',
                        isSecret: true,
                      ),
                      const CustomTextField(
                        icon: Icons.lock_outline,
                        label: 'Nova senha',
                        isSecret: true,
                      ),
                      const CustomTextField(
                        icon: Icons.lock,
                        label: 'Confirmar nova senha',
                        isSecret: true,
                      ),

                      //Botao de Confirmacao
                      SizedBox(
                        height: 45,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {},
                          child: const Text('Atualizar'),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  right: 5,
                  top: 5,
                  child: IconButton(
                    onPressed: (){},
                    icon: const Icon(Icons.close),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
