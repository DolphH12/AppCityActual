import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

import '../stores/login_store.dart';
import '../theme.dart';
import '../widgets/loader_hud.dart';


class LogintoPage extends StatefulWidget {
  const LogintoPage({Key key}) : super(key: key);
  @override
  _LogintoPageState createState() => _LogintoPageState();
}

class _LogintoPageState extends State<LogintoPage> {
  TextEditingController phoneController = TextEditingController();
  String _phoneNumber;

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginStore>(
      builder: (_, loginStore, __) {
        return Observer(
          builder: (_) => LoaderHUD(
            inAsyncCall: loginStore.isLoginLoading,
            child: Stack(
                  children: [Scaffold(
                  resizeToAvoidBottomPadding: false,
                  //backgroundColor: Colors.white,
                  key: loginStore.loginScaffoldKey,
                  body: SafeArea(
                    child: SingleChildScrollView(
                      child: Stack(
                        children: [
                          _crearFondo(context),
                          _contenidoApp(context, loginStore),]
                    ),
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }

  Container _contenidoApp(BuildContext context, LoginStore loginStore) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          _logoTitle(),
          _inputNumber(loginStore, context)
        ],
      ),
    );
  }

  Expanded _inputNumber(LoginStore loginStore, BuildContext context) {
    return Expanded(
          flex: 1,
          child: Column(
            children: <Widget>[
              Container(
                constraints: const BoxConstraints(
                    maxWidth: 500
                ),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: <TextSpan>[
                    TextSpan(text: 'Te enviaremos ', style: TextStyle(color: MyColors.primaryColor)),
                    TextSpan(
                        text: 'La Contraseña Una Vez ', style: TextStyle(color: MyColors.primaryColor, fontWeight: FontWeight.bold)),
                    TextSpan(text: 'a este numero de celular', style: TextStyle(color: MyColors.primaryColor)),
                  ]),
                )),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  child: IntlPhoneField(
                    decoration: InputDecoration(
                      labelText: 'Número de celular',
                    ),
                    initialCountryCode: 'CO',
                    controller: phoneController,
                    onChanged: (number) => _phoneNumber = number.countryCode + number.number
                  ),
                ),

                // child: CupertinoTextField(
                //   padding: const EdgeInsets.symmetric(horizontal: 16),
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: const BorderRadius.all(Radius.circular(4))
                //   ),
                //   controller: phoneController,
                //   clearButtonMode: OverlayVisibilityMode.editing,
                //   keyboardType: TextInputType.phone,
                //   maxLines: 1,
                //   placeholder: '+57...',
                // ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                constraints: const BoxConstraints(
                    maxWidth: 500
                ),
                child: RaisedButton(
                  onPressed: () {
                    if (phoneController.text.isNotEmpty) {
                      loginStore.getCodeWithPhoneNumber(context, _phoneNumber);
                    } else {
                      loginStore.loginScaffoldKey.currentState.showSnackBar(SnackBar(
                        behavior: SnackBarBehavior.floating,
                        backgroundColor: Colors.red,
                        content: Text(
                          'Please enter a phone number',
                          style: TextStyle(color: Colors.white),
                        ),
                      ));
                    }
                  },
                  color: MyColors.primaryColor,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(14))),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Next',
                          style: TextStyle(color: Colors.white),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            color: MyColors.primaryColorLight,
                          ),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: 16,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
  }

  Expanded _logoTitle() {
    return Expanded(
          flex: 2,
          child: Column(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Stack(
                  children: <Widget>[
                    Center(
                      child: Container(
                          constraints: const BoxConstraints(maxHeight: 340),
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          child: Image.asset('assets/img/login2.png')),
                    ),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 50),
                  child: Text('Muro App City',
                      style: TextStyle(color: MyColors.primaryColor, fontSize: 50, fontWeight: FontWeight.w800)))
            ],
          ),
        );
  }

  Widget _crearFondo(BuildContext context){

    final size = MediaQuery.of(context).size;

    final fondoVerde = Container(
      height: size.height * 0.4,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(27, 94, 32, 1.0),
            Color.fromRGBO(71, 188, 77, 1.0),
          ]
        )
      ),
    );

    final circulo = Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: Color.fromRGBO(255, 255, 255, 0.1)
      ),
    );

    return Stack(
      children: [
        fondoVerde,
        Positioned( child: circulo, top: 90.0, left: 30.0,),
        Positioned( child: circulo, top: -40.0, right: -30.0,),
        Positioned( child: circulo, bottom: 80.0, right: 30.0,),
        Positioned( child: circulo, bottom: -40.0, left: 120.0,),

      ],
    );

  }

}
