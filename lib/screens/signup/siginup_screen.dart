import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '/helpers/validators.dart';
import '/models/user.dart';
import '/models/user_manager.dart';


class SignupScreen extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  final User user = User();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: const Text("Criar Conta"),
        centerTitle: true,
      ),
      body: Center(
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: formKey,
            child: Consumer<UserManager>(
              builder: (_, usermanager, __) {
                return ListView(
                  padding: const EdgeInsets.all(16.0),
                  shrinkWrap: true,
                  children: [
                    TextFormField(
                      enabled: !usermanager.loading,
                      decoration: const InputDecoration(
                        hintText: 'Nome Completo',
                      ),
                      validator: (name) {
                        if (name.isEmpty) {
                          return 'Campo Obrigatório';
                        } else if (name.trim().split(' ').length <= 1) {
                          return 'Preencha seu nome Completo';
                        }
                        return null;
                      },
                      onSaved: (name) => user.name = name,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      enabled: !usermanager.loading,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: 'E-mail',
                      ),
                      validator: (email) {
                        if (email.isEmpty)
                          return 'Campo Obrigatório';
                        else if (!emailValid(email)) return "E-mail Inválido";

                        return null;
                      },
                      onSaved: (email) => user.email = email,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      enabled: !usermanager.loading,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Senha',
                      ),
                      validator: (pass) {
                        if (pass.isEmpty) {
                          return 'Campo Obrigatório';
                        } else if (pass.length < 6) {
                          return 'Senha muito curta';
                        }
                        return null;
                      },
                      onSaved: (pass) => user.password = pass,
                    ),
                    const SizedBox(height: 16.0),
                    TextFormField(
                      enabled: !usermanager.loading,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Repita a senha',
                      ),
                      validator: (pass) {
                        if (pass.isEmpty) {
                          return 'Campo Obrigatório';
                        } else if (pass.length < 6) {
                          return 'Senha muito curta';
                        }
                        return null;
                      },
                      onSaved: (pass) => user.confirmPassword = pass,
                    ),
                    const SizedBox(height: 16.0),
                    SizedBox(
                      height: 44,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor),
                        onPressed: usermanager.loading
                            ? null
                            : () {
                                if (formKey.currentState.validate()) {
                                  formKey.currentState.save();

                                  if (user.password != user.confirmPassword) {
                                    // ignore: deprecated_member_use
                                    scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                        content: Text('as senhas não combinam'),
                                        backgroundColor: Colors.red,
                                      ),
                                    );
                                    return;
                                  }
                                  usermanager.signUp(
                                        user: user,
                                        onSuccess: () {
                                          Navigator.of(context).pop();
                                        },
                                        onFail: (e) {
                                          // ignore: deprecated_member_use
                                          scaffoldKey.currentState.showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Falha ao Cadastrar: $e'),
                                              backgroundColor: Colors.red,
                                            ),
                                          );
                                        },
                                      );
                                }
                              },
                        child: usermanager.loading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              )
                            : const Text(
                                'Criar Conta',
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
