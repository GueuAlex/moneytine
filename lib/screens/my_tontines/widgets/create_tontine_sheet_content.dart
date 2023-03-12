import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:moneytine/screens/add_tontine/add_tontine.dart';

import '../../../style/palette.dart';
import '../../../widgets/custom_button.dart';

class CreatetontineSheetContent extends StatefulWidget {
  const CreatetontineSheetContent({
    super.key,
    this.isCreatTontine = true,
  });
  final bool isCreatTontine;

  @override
  State<CreatetontineSheetContent> createState() =>
      _CreatetontineSheetContentState();
}

class _CreatetontineSheetContentState extends State<CreatetontineSheetContent> {
  /////////////////// tontine name editing controller//////////////////////////
  ///
  ///
  final TextEditingController tontineNameController = TextEditingController();
  final TextEditingController joinCodeController = TextEditingController();

  //////////////////////// form key /////////////////////////////
  ///
  final _formKey = GlobalKey<FormState>();

  /////////////////////////// default tontine name ////////////////
  ///
  final String defaultTontineName =
      DateFormat('tontine_dd/MM/yyyy').format(DateTime.now());
  ///////
  @override
  Widget build(BuildContext context) {
    final tontineNameField = TextFormField(
      keyboardType:
          widget.isCreatTontine ? TextInputType.text : TextInputType.number,
      cursorColor: Palette.appPrimaryColor,
      cursorHeight: 20,
      controller:
          widget.isCreatTontine ? tontineNameController : joinCodeController,
      autofocus: false,
      validator: (value) {
        if (value!.isNotEmpty && value.length < 3) {
          return widget.isCreatTontine
              ? ("Ce nom est trop court !")
              : ('Entrez un code valide');
        }

        if (widget.isCreatTontine == false && value.isEmpty) {
          return ('Entrez un code valide');
        }

        //email match regEx

        return null;
      },
      onSaved: (value) {
        widget.isCreatTontine
            ? tontineNameController.text = value!
            : joinCodeController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        prefixIcon: Icon(
          widget.isCreatTontine
              ? CupertinoIcons.money_dollar_circle
              : CupertinoIcons.link,
          color: Palette.secondaryColor,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: widget.isCreatTontine ? defaultTontineName : 'Code',
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
              child: widget.isCreatTontine
                  ? Text(
                      'Veuillez entrer un nom pour la tontine\nLe nom par defaut sera $defaultTontineName si n\'est pas renseigner!',
                      textAlign: TextAlign.center,
                    )
                  : const Text(
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
              child: CustomButton(
                color: Palette.appPrimaryColor,
                width: double.infinity,
                height: 45,
                radius: 50,
                text: widget.isCreatTontine
                    ? 'Continuer la création'
                    : 'Rejoindre',
                onPress: () {
                  verify();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  void verify() {
    if (_formKey.currentState!.validate()) {
      if (widget.isCreatTontine) {
        Navigator.pop(context);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return AddTontineScreen(
              tontineName: tontineNameController.text.isNotEmpty
                  ? tontineNameController.text
                  : defaultTontineName);
        }));
      } else {
        print('joind');
      }
    }
  }
}
