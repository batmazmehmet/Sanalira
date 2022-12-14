import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:provider/provider.dart';
import 'package:sanalira/config/helper.dart';
import 'package:sanalira/config/palette.dart';
import 'package:sanalira/config/theme.dart';
import 'package:sanalira/provider/register_provider.dart';
import 'package:sanalira/view/main_view.dart';

import '../widgets/custom_button.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final isimController = TextEditingController();
  final soyisimController = TextEditingController();
  final epostaController = TextEditingController();
  final sifreController = TextEditingController();
  String telefonNo = "";
  bool _isimValidate = false;
  bool _soyisimValidate = false;
  bool _epostaValidate = false;
  bool _telefonValidate = false;
  bool _sifreValidate = false;
  var validatePassword;
  @override
  Widget build(BuildContext context) {
    registerControl(String password, String eposta) {
      validatePassword = Helper().validatePassword(password);
      final bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(eposta);

      if (isimController.text.length < 3) {
        _isimValidate = true;
        print("1");
      } else {
        _isimValidate = false;
      }

      if (soyisimController.text.length < 3) {
        _soyisimValidate = true;
        print("2");
      } else {
        _soyisimValidate = false;
      }

      if (!emailValid) {
        _epostaValidate = true;
        print("3");
      } else {
        _epostaValidate = false;
      }
      if (validatePassword != null) {
        _sifreValidate = true;
        print("4");
      } else {
        _sifreValidate = false;
        print("5");
      }
      if (telefonNo.length == 13) {
        _telefonValidate = false;
      } else {
        _telefonValidate = true;
      }

      setState(() {});
    }

    RegisterProvider provider = Provider.of<RegisterProvider>(context);
    double sWidth = MediaQuery.of(context).size.width;
    double sHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(children: [
        Container(
          width: sWidth,
          height: sHeight * 0.25,
          color: Palette.primaryColor,
          child: const Center(
            child: SizedBox(
                height: 110,
                width: 120,
                child: CircleAvatar(
                  backgroundImage:
                      AssetImage("assets/images/sanaliraImage.jpg"),
                )),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            width: sWidth,
            height: sHeight * 0.85,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                            text: "SanaLira'ya",
                            style: CustomTheme.subtitle(context,
                                color: Palette.primaryColor,
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                  text: ' Yeni Üyelik',
                                  style: CustomTheme.subtitle(context))
                            ]),
                      ),
                      Text("Bilgilerinizi girip sözleşmeyi onaylayın.",
                          style: CustomTheme.body(context,
                              color: Palette.grayColor)),
                      SizedBox(
                        height: sHeight * 0.02,
                      ),
                      Text(
                        "Ad",
                        style:
                            CustomTheme.body(context, color: Palette.grayColor),
                      ),
                      TextField(
                        maxLength: 50,
                        controller: isimController,
                        autofocus: false,
                         inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
  ],
                        style: CustomTheme.body(context),
                        decoration: InputDecoration(
                          
                          counterText: "",
                          filled: true,
                          hintText: "İsminizi girin",
                          errorText:
                              _isimValidate ? 'Geçerli değer girin!' : null,
                          fillColor: Color.fromARGB(255, 243, 244, 246),
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: sHeight * 0.01,
                      ),
                      Text(
                        "Soyad",
                        style:
                            CustomTheme.body(context, color: Palette.grayColor),
                      ),
                      TextField(
                        maxLength: 50,
                        controller: soyisimController,
                        inputFormatters: [
      FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
  ],
                        autofocus: false,
                        style: CustomTheme.body(context),
                        decoration: InputDecoration(
                          counterText: "",
                          filled: true,
                          hintText: "Soyadınızı girin",
                          errorText:
                              _soyisimValidate ? 'Geçerli değer girin!' : null,
                          fillColor: Color.fromARGB(255, 243, 244, 246),
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: sHeight * 0.01,
                      ),
                      Text(
                        "E-posta",
                        style:
                            CustomTheme.body(context, color: Palette.grayColor),
                      ),
                      TextField(
                        autofocus: false,
                        controller: epostaController,
                        style: CustomTheme.body(context),
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "E-posta adresinizi girin",
                          errorText: _epostaValidate
                              ? 'Geçerli e posta adresi girin!'
                              : null,
                          fillColor: Color.fromARGB(255, 243, 244, 246),
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: sHeight * 0.01,
                      ),
                      Text(
                        "Şifre",
                        style:
                            CustomTheme.body(context, color: Palette.grayColor),
                      ),
                      TextField(
                        obscureText: true,
                        controller: sifreController,
                        autofocus: false,
                        style: CustomTheme.body(context),
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "Şifrenizi girin",
                          errorText: _sifreValidate ? validatePassword : null,
                          fillColor: Color.fromARGB(255, 243, 244, 246),
                          contentPadding: const EdgeInsets.only(
                              left: 14.0, bottom: 8.0, top: 8.0),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: sHeight * 0.01,
                      ),
                      Text(
                        "Cep Telefonu Numaranız",
                        style:
                            CustomTheme.body(context, color: Palette.grayColor),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 243, 244, 246),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: InternationalPhoneNumberInput(
                          formatInput: false,
                          countries: const ["TR"],
                          autofillHints: const [AutofillHints.telephoneNumber],
                          onInputChanged: (PhoneNumber phoneNumber) {
                            telefonNo = phoneNumber.phoneNumber.toString();
                          },
                          textStyle: TextStyle(color: Palette.primaryTextColor),
                          inputDecoration: InputDecoration(
                            errorText: _telefonValidate
                                ? "Geçerli telefon numarası girin"
                                : null,
                            hintText: 'Telefon Numarası',
                            border: InputBorder.none,
                            hintStyle: CustomTheme.subtitle(context,
                                color: Palette.hintTextColor),
                          ),
                          selectorConfig: const SelectorConfig(
                            selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                            setSelectorButtonAsPrefixIcon: true,
                          ),
                          selectorTextStyle: CustomTheme.subtitle(context),
                        ),
                      ),
                      SizedBox(
                        height: sHeight * 0.01,
                      ),
                      Row(
                        children: [
                          Checkbox(
                            splashRadius: 5,
                            value: provider.checkbox,
                            onChanged: (newValue) {
                              provider.changeCheckbox();
                            },
                          ),
                          Container(
                            width: sWidth * 0.75,
                            child: RichText(
                              text: TextSpan(
                                  text: "Hesabınızı oluştururken",
                                  style: CustomTheme.body(context),
                                  children: [
                                    TextSpan(
                                        text: ' sözleşme ve koşulları',
                                        style: CustomTheme.body(context,
                                            color: Palette.primaryColor,
                                            fontWeight: FontWeight.bold)),
                                    TextSpan(text: ' kabul etmeniz gerekir.')
                                  ]),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: sHeight * 0.03,
                      ),
                      CustomButton(
                        text: 'Giriş Yap',
                        customButtonType: CustomButtonType.primary,
                        onPressed: () async {
                          registerControl(sifreController.text.toString(),
                              epostaController.text.toString());

                          if (!_isimValidate &&
                              !_soyisimValidate &&
                              !_epostaValidate &&
                              !_sifreValidate &&
                              !_telefonValidate &&
                              provider.checkbox) {
                            try {
                              UserCredential userCredential = await FirebaseAuth
                                  .instance
                                  .createUserWithEmailAndPassword(
                                      email: epostaController.text.toString(),
                                      password:
                                          sifreController.text.toString());
                              try {
                                UserCredential userCredentialSign =
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: epostaController.text
                                                .toString(),
                                            password: sifreController.text
                                                .toString());
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                  print('E postaya kayıtlı kullanıcı yok.');
                                } else if (e.code == 'wrong-password') {
                                  print('Yanlış parola.');
                                }
                              }
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                print('Zayıf parola.');
                              } else if (e.code == 'email-already-in-use') {
                                print('E postaya ait kullanıcı var.');
                              }
                            } catch (e) {
                              print(e);
                            }
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainView()));
                          } else if (!provider.checkbox) {
                            Helper().showCustomSnackBar(
                                context, "Sözleşme ve koşullarını kabul edin!");
                          }
                        },
                      ),
                    ]),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
