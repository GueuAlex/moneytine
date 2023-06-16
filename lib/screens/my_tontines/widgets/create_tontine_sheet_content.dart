import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../../functions/functions.dart';
import '../../../models/tontine.dart';
import '../../../models/user.dart';
import '../../../remote_services/remote_services.dart';
import '../../../style/palette.dart';
import '../../../widgets/custom_button.dart';
import '../../single_tontine/single_tontine.dart';

class CreatetontineSheetContent extends StatefulWidget {
  const CreatetontineSheetContent({super.key, required this.user});

  final MyUser user;

  @override
  State<CreatetontineSheetContent> createState() =>
      _CreatetontineSheetContentState();
}

class _CreatetontineSheetContentState extends State<CreatetontineSheetContent> {
  /////////////////// tontine name editing controller//////////////////////////
  ///
  ///
  //final TextEditingController tontineNameController = TextEditingController();
  final TextEditingController joinCodeController = TextEditingController();

  //////////////////////// form key /////////////////////////////
  ///
  final _formKey = GlobalKey<FormState>();

  /////////////////////////// default tontine name ////////////////
  ///
  final String defaultTontineName =
      DateFormat('tontine_dd/MM/yyyy').format(DateTime.now());
  ///////////////////////////////////////////
  ///
  bool isLoadin = false;
  @override
  Widget build(BuildContext context) {
    final tontineNameField = TextFormField(
      keyboardType: TextInputType.number,
      cursorColor: Palette.appPrimaryColor,
      cursorHeight: 20,
      controller: joinCodeController,
      autofocus: false,
      validator: (value) {
        var code = value!.trim();
        if (code.isEmpty || code.length < 3) {
          return ('Entrez un code valide');
        }

        //email match regEx

        return null;
      },
      onSaved: (value) {
        joinCodeController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: const Icon(
          CupertinoIcons.link,
          color: Palette.secondaryColor,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Code',
        hintStyle: const TextStyle(color: Palette.secondaryColor),
        //labelText: defaultTontineName,
        labelStyle: const TextStyle(color: Palette.secondaryColor),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
    return Form(
      key: _formKey,
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: Palette.whiteColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5.0),
              width: 60,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 11.0),
              child: const Text(
                'Pour rejoindre une tontine, veuillez le code d\'invitation',
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              padding: const EdgeInsets.only(
                top: 2.0,
                right: 5,
                left: 5.0,
              ),
              margin: const EdgeInsets.only(
                right: 10.0,
                left: 10.0,
                top: 20.0,
                bottom: 10.0,
              ),
              decoration: BoxDecoration(
                color: Palette.appPrimaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(50),
              ),
              child: tontineNameField,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: !isLoadin
                  ? CustomButton(
                      color: Palette.appPrimaryColor,
                      width: double.infinity,
                      height: 45,
                      radius: 50,
                      text: 'Rejoindre',
                      onPress: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            isLoadin = true;
                          });
                          String tontineID = await Functions.joinResponse(
                            code: joinCodeController.text,
                            userId: widget.user.id.toString(),
                          );

                          if (tontineID != 'err') {
                            var response =
                                await RemoteServices().getSingleTontine(
                              id: int.parse(tontineID),
                            );
                            if (response != null) {
                              Tontine tontine = response;
                              // ignore: use_build_context_synchronously
                              allTontineWhereCurrentUserParticipe.add(tontine);
                              Future.delayed(const Duration(seconds: 3))
                                  .then((value) {
                                setState(() {
                                  isLoadin = false;
                                });
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return SingleTontine(
                                        tontine: tontine,
                                        user: widget.user,
                                        isFiret: true,
                                      );
                                    },
                                  ),
                                );
                              });
                              //return tontine;
                            } else {
                              setState(() {
                                isLoadin = false;
                              });
                            }
                          } else {
                            setState(() {
                              isLoadin = false;
                            });
                            Fluttertoast.showToast(
                              msg: 'Cette tontine n\'est existe pas',
                              backgroundColor: Palette.appPrimaryColor,
                            );
                          }
                        }
                      },
                    )
                  : const Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Palette.appPrimaryColor),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Future<Tontine?> verify() async {
    return null;
  }
}
