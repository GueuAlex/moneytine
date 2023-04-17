import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../config/firebase_const.dart';
import '../../../functions/functions.dart';
import '../../../models/tontine.dart';
import '../../../models/user.dart';
import '../../../style/palette.dart';
import '../../../widgets/custom_button.dart';

class CreateMemberContainer extends StatefulWidget {
  const CreateMemberContainer({
    super.key,
    required this.tontine,
    required this.groupe,
    required this.callback,
  });
  final Tontine tontine;
  final Groupe groupe;
  final VoidCallback callback;

  @override
  State<CreateMemberContainer> createState() => _CreateMemberContainerState();
}

class _CreateMemberContainerState extends State<CreateMemberContainer> {
  /////////////////////// controllers/////////////////////////////////
  final TextEditingController emailController = TextEditingController();

  final TextEditingController firstNameController = TextEditingController();

  /////////////////////////////////////////////// firestore instance //////////
  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    //passwordController.dispose();
    firstNameController.dispose();
    //confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //////////////////////first name field ///////////
    final firstNameFiel = TextFormField(
      cursorColor: Palette.appPrimaryColor,

      autofocus: false,

      //first name validator
      validator: (value) {
        if (value!.isEmpty) {
          return ('Le nom est obligatoire !');
        }

        if (value.length < 2) {
          return ('Nom trop court !');
        }

        return null;
      },
      controller: firstNameController,
      keyboardType: TextInputType.name,
      //validation: ()=>{}
      onSaved: (value) {
        firstNameController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          CupertinoIcons.person,
          color: Palette.secondaryColor,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        labelText: 'Nom complet',
        labelStyle: const TextStyle(color: Palette.secondaryColor),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.0),
        ),

        //fillColor: Style.appWhite,
      ),
    );

    ///////////// email field ///////////////////
    final emailField = TextFormField(
      cursorColor: Palette.appPrimaryColor,
      controller: emailController,
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Veuillez entrer un email correct !");
        }

        //email match regEx
        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value)) {
          return ("Veuillez entrer un email correct !");
        }

        return null;
      },
      onSaved: (value) {
        emailController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          CupertinoIcons.mail,
          color: Palette.secondaryColor,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        //hintText: 'email',
        labelText: 'Email',
        labelStyle: const TextStyle(color: Palette.secondaryColor),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );

    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: const EdgeInsets.only(
                top: 5.0,
                bottom: 15.0,
              ),
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text('Création d\'un nouveau membre'),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 15.0,
              left: 15.0,
              bottom: 10,
            ),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                color: Palette.appPrimaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: emailField,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 15.0,
              left: 15.0,
            ),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                color: Palette.appPrimaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(50.0),
              ),
              child: firstNameFiel,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 30,
              right: 15,
              left: 15,
            ),
            child: CustomButton(
              isSetting: true,
              fontsize: 13,
              color: Palette.appPrimaryColor,
              width: double.infinity,
              height: 40,
              radius: 50,
              text: 'Créer le membre',
              onPress: () {
                String name = firstNameController.text.trim();
                String email = emailController.text.trim();
                String password = Functions.generatePassword();
                int tontineId = widget.tontine.id;
                int groupeId = widget.groupe.id;
                print('nom: $name');
                print('email: $email');
                print('id tontine: $tontineId');
                print('id groupe: $groupeId');
                print('id groupe: $password');
                if (name.isNotEmpty) {
                  if (email.isNotEmpty &&
                      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(email)) {
                    /////////////////////////////////////////////////////////////
                    //////////////////// ecrire la logique ici///////////////////
                    ///

                    Functions.showLoadingSheet(ctxt: context);
                    Future.delayed(const Duration(seconds: 5)).then((_) async {
                      MyUser newUser = MyUser(
                        fullName: name,
                        email: email,
                        password: password,
                      );
                      var response = await Functions.postUser(
                        user: newUser,
                        isSingin: false,
                      );
                      if (response != null) {
                        if (response == 'emailError') {
                          Navigator.pop(context);
                          Fluttertoast.showToast(
                            msg: 'Cette adresse email existe déjà !',
                            backgroundColor: Palette.appPrimaryColor,
                          );
                        } else {
                          var result = jsonDecode(response);
                          int userId = result['id'];
                          int tontineCode = widget.tontine.uniqueCode;
                          Future.delayed(const Duration(seconds: 3))
                              .then((_) async {
                            String joinResponse = await Functions.joinResponse(
                              code: tontineCode.toString(),
                              userId: userId.toString(),
                            );
                            if (joinResponse != 'err') {
                              /////////////////////////// a ce niveau, le user creer et ajouert a cette tontine ////////
                              /// ont peut l'incerer dans firebase ////////////////////////
                              ///
                              await _auth
                                  .createUserWithEmailAndPassword(
                                    email: email,
                                    password: FirebaseConst.authPwd,
                                  )
                                  .then((value) => {
                                        Functions.postDetailToFiresotre(
                                          email: email,
                                          fullName: name,
                                          password: FirebaseConst.authPwd,
                                        )
                                      })
                                  .catchError((e) {
                                Fluttertoast.showToast(msg: e!.message);
                              });

                              ///
                              /// ///////////////////////////////////////////////
                              /////////////////////////////////////////////
                              ///deneire chose a executer si tout est ok ///
                              widget.callback();
                              ///////////////////////////////////////////////
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Fluttertoast.showToast(
                                msg: 'Membre créé !',
                                backgroundColor: Palette.appPrimaryColor,
                              );
                            }
                          });
                        }
                      } else {
                        Navigator.pop(context);
                        Fluttertoast.showToast(
                          msg: 'Veuillez réessayer !',
                          backgroundColor: Palette.appPrimaryColor,
                        );
                      }
                    });

                    ///
                    ////////////////////////////////////////////////////////////
                    /////////////////////////////////////////////////////////////
                  } else {
                    Fluttertoast.showToast(
                      msg: 'Entrer un email valide !',
                      backgroundColor: Palette.appPrimaryColor,
                    );
                  }
                } else {
                  Fluttertoast.showToast(
                    msg: 'Le nom est requis !',
                    backgroundColor: Palette.appPrimaryColor,
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
