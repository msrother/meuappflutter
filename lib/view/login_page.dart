import 'package:flutter/material.dart';
import 'package:meuapp/view/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  bool showPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color(0xFF1E1E1E),
      body: Center(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Image.asset("logotipo_firma.png"),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5, // Ajuste aqui
                  child: TextFormField(
                    //style: TextStyle(color: Color(0xFF979797)),
                    controller: null,
                    maxLength: 30,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                        filled: true,
                        //fillColor: Color(0xFF212C34),
                        hintText: 'Insira seu email',
                        //hintStyle: TextStyle(color: Color(0xFF979797)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email é obrigatório';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5, // Ajuste aqui
                  child: TextFormField(
                    obscureText: showPassword,
                    //style: TextStyle(color: Color(0xFF979797)),
                    controller: null,
                    maxLength: 30,
                    decoration: InputDecoration(
                        suffixIcon: Container(
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                showPassword = !showPassword;
                              });
                            },
                            icon: showPassword == false
                                ? Icon(Icons.visibility,
                                    color: Colors.white, size: 18)
                                : Icon(Icons.visibility_off,
                                    color: Colors.white, size: 18),
                          ),
                        ),
                        filled: true,
                        // fillColor: Color(0xFF212C34),
                        hintText: 'Insira a senha',
                        //hintStyle: TextStyle(color: Color(0xFF979797)),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Senha é obrigatória';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width * 0.2,
                  child: ElevatedButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(12),
                      backgroundColor: Colors.deepOrangeAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        //poderia add validação de login/senha
                        //navega para a home
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePage(),
                          ),
                        );
                      }
                    },
                    child: Text("Entrar"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
