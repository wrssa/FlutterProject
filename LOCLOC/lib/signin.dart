import 'package:flutter/material.dart';
import 'home.dart';
//import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  SigninFormState createState() => SigninFormState();
}

// ignore: mixin_inherits_from_not_object
class SigninFormState extends State<SignInForm>
    with SingleTickerProviderStateMixin {
  final IconData mail = const IconData(0xe158, fontFamily: 'MaterialIcons');
  // ignore: non_constant_identifier_names
  final IconData lock_outline =
      const IconData(0xe899, fontFamily: 'MaterialIcons');
  final IconData signinicon =
      const IconData(0xe315, fontFamily: 'MaterialIcons');
  final IconData signupicon =
      const IconData(0xe316, fontFamily: 'MaterialIcons');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LOCLOC ',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const MyLoginPage(title: 'LOCLOC : LoginPage'),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key, required this.title});
  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLoginPage> {
//   //Error text for Email field
//   String? get _errorTextEmail {
//     _formWasEdited = true;
//     final text = _controller.value.text;
//     if (text.isEmpty) {
//       return 'Please Enter the Email';
//     }
//     if (text.length < 4) {
//       return 'Invalid Email';
//     }
//     return null;
//   }

// //Error text for Password field
//   String? get _errorTextPwd {
//     _formWasEdited = true;
//     final text = _controller.value.text;
//     if (text.isEmpty) {
//       return 'Please Enter the Password';
//     }
//     if (text.length < 4) {
//       return 'Invalid Password';
//     }
//     return null;
//   }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        //margin: const EdgeInsets.only(left: 20, right: 20),
        padding: const EdgeInsets.all(20),
        alignment: Alignment.center,
        // height: double.infinity,
        // width: double.infinity,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 41, 41, 41),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Image(
              image: AssetImage('assets/logo.png'),
              width: 100,
              height: 100,
            ),
            // const HtmlWidget(
            //     """<h1 style='color:rgb(186, 0, 0); text-align:center; font-size: 40px; '>LOG IN</h1>"""),
            const SizedBox(
              height: 16,
            ),
            const TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                iconColor: Colors.white,
                labelText: 'E-mail',
                //errorText: _errorTextEmail,
                labelStyle: TextStyle(color: Colors.white),
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.password),
                iconColor: Colors.white,
                labelText: 'Password',
                //errorText: _errorTextPwd,
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  borderSide: BorderSide(color: Colors.white, width: 2.0),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: FilledButton(
                style: const ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            const SizedBox(
              width: 200,
              height: 50,
              child: FilledButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
                ),
                onPressed: null,
                child: Text(
                  'SignUp',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
