import 'package:flutter/material.dart';

import 'models/LoginData.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  final Logindata _logindata = Logindata();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 48),
                    child: Center(
                      child: Text(
                        "Rosey",
                        style: TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ), // Other widgets go below the title
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 2),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? inValue) {
                          if (inValue == null || inValue.isEmpty) {
                            return "Campo obrigatório";
                          }
                          
                          return null;
                        },
                        onSaved: (String? inValue) {
                          _logindata.username = inValue!;
                        },
                        decoration: InputDecoration(
                          hintText: "none@none.com",
                          labelText: "Email"
                        ),
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFormField(
                        obscureText: true,
                        validator: (String? inValue) { 
                          if (inValue == null || inValue.isEmpty) {
                            return "Campo obrigatório";
                          } 
                          return null;
                        },
                        onSaved: (String? inValue) {
                          _logindata.password = inValue!;
                          print(_logindata.password);
                        }, 
                        decoration: InputDecoration(
                          hintText: "Senha",
                          labelText: "Senha"
                        )
                      ),
                      SizedBox(height: 8),
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text('Lembrar senha'),
                        value: _logindata.rememberPassword,
                        onChanged: (bool? inValue) {                        
                          setState(() {
                            _logindata.rememberPassword = inValue!;
                          });
                        },
                      ),
                      SizedBox(height: 8),
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF3B82F6),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                          onPressed: () {
                            final form = _formKey.currentState;
                            if (form == null || !form.validate()) return;

                            form.save();

                            print("dados do form");
                            print(_logindata.username);
                            print(_logindata.password);
                            print(_logindata.rememberPassword);
                          },
                          child: Text("Entrar"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
