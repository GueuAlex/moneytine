import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:moneytine/models/tontine.dart';
import 'package:moneytine/widgets/custom_button.dart';

import '../../../style/palette.dart';
import '../../../widgets/custom_text.dart';

class AddUserToGroupe extends StatefulWidget {
  const AddUserToGroupe({
    super.key,
    required this.groupColor,
    required this.groupe,
    required this.tontine,
  });
  final Color groupColor;
  final Groupe groupe;
  final Tontine tontine;

  @override
  State<AddUserToGroupe> createState() => _AddUserToGroupeState();
}

class _AddUserToGroupeState extends State<AddUserToGroupe> {
  //////////////////////// user list////////////////////////
  ///
  final List<SelectedListItem> _listOfCities = [];

  ///////////////////// selected user ///////////////////////////
  ///
  String _selectedType = '';

  //////////////////////// user list//////////////////////////////
  ///
  List<String> userList = ['user 1', 'usuer 2', 'user 3', 'user 4', 'user 5'];

  ////////////////////////// selected user controller /////////////////////
  ///
  final TextEditingController _selectedTypeController = TextEditingController();
  final TextEditingController _contributeAmountController =
      TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _selectedTypeController.dispose();
  }

  @override
  void initState() {
    for (var element in userList) {
      _listOfCities.add(
        SelectedListItem(name: element),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ////////////////////////::: select user field ////////////////
    ///
    final selectedField = TextFormField(
      controller: _selectedTypeController,
      cursorColor: Colors.black,
      onTap: () {
        FocusScope.of(context).unfocus();
        onTextFieldTap();
      },
      validator: (value) {
        if (_selectedType.isEmpty) {
          return 'Veuillez selectionner un type de tontine';
        }
      },
      decoration: InputDecoration(
        focusColor: Palette.appPrimaryColor,
        //suffixIconColor: Palette.appPrimaryColor,
        //filled: true,
        suffixIcon: const Icon(
          Icons.arrow_drop_down,
          //color: Palette.appPrimaryColor,
        ),
        contentPadding: const EdgeInsets.only(top: 20.0, bottom: 20.0),

        hintText:
            _selectedType.isNotEmpty ? _selectedType : 'Selectionner un membre',
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Palette.appPrimaryColor),
        ),
        // les autres propriétés de décoration que vous voulez utiliser

        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        // les autres propriétés de décoration que vous voulez utiliser
      ),
    );

    ///////////// contribute amount field ///////////////////
    final contributeAmountField = TextFormField(
      controller: _contributeAmountController,
      keyboardType: TextInputType.number,
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Veuillez entrer un montant !");
        }

        return null;
      },
      onSaved: (value) {
        _contributeAmountController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        focusColor: Palette.appPrimaryColor,
        //suffixIconColor: Palette.appPrimaryColor,
        //filled: true,
        /* suffixIcon: const Icon(
          Icons.arrow_drop_down,
          color: Palette.appPrimaryColor,
        ), */
        contentPadding: EdgeInsets.only(top: 20.0, bottom: 20.0),

        hintText: 'Entrer un montant de contribution',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Palette.appPrimaryColor),
        ),
        // les autres propriétés de décoration que vous voulez utiliser

        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        // les autres propriétés de décoration que vous voulez utiliser
      ),
    );
    return Scaffold(
      appBar: AppBar(
        //toolbarTextStyle: TextStyle(color: Palette.whiteColor),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 4.0,
            ),
            child: IconButton(
              onPressed: () {
                print('Add member to groupe');
              },
              icon: const Icon(CupertinoIcons.check_mark),
            ),
          )
        ],
        elevation: 0,
        backgroundColor: widget.groupColor,
        title: Text(
          'Ajout d\'un membre au ${widget.groupe.nom}',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            right: 15.0,
            left: 15.0,
            top: 20.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const CustomText(
                text: 'Membre',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              selectedField,
              const SizedBox(
                height: 20,
              ),
              const CustomText(
                text: 'Montant de contribution',
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
              contributeAmountField,
              Padding(
                padding: const EdgeInsets.only(
                  right: 10.0,
                  left: 10.0,
                  top: 40.0,
                ),
                child: CustomButton(
                    color: Palette.appPrimaryColor,
                    width: double.infinity,
                    height: 45,
                    radius: 50,
                    text: 'Ajouter',
                    onPress: () {}),
              )
            ],
          ),
        ),
      ),
    );
  }

  void onTextFieldTap() {
    DropDownState(
      DropDown(
        bottomSheetTitle: const Text(
          'Types',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: _listOfCities.isNotEmpty ? _listOfCities : [],
        selectedItems: (List<dynamic> selectedList) {
          List<String> list = [];
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              list.add(item.name);
              setState(() {
                _selectedType = list[0];
              });
            }
          }
          showSnackBar(list.toString());
        },
        enableMultipleSelection: false,
      ),
    ).showModal(context);
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
