import 'package:drop_down_list/drop_down_list.dart';
import 'package:drop_down_list/model/selected_list_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moneytine/functions/functions.dart';
import 'package:moneytine/models/tontine.dart';
import 'package:moneytine/remote_services/remote_services.dart';
import 'package:moneytine/widgets/custom_button.dart';

import '../../../models/user.dart';
import '../../../style/palette.dart';
import '../../../widgets/custom_text.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({
    super.key,
    required this.groupe,
    required this.tontine,
  });

  final Groupe groupe;
  final Tontine tontine;

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  /////////////////////////// form key //////////////////////////////////////
  ///
  final _formKey = GlobalKey<FormState>();
  //////////////////////// user list////////////////////////
  ///
  final List<SelectedListItem> _userList = [];
  final List<SelectedListItem> _partOnScreen = [
    SelectedListItem(name: '1', value: '1.0'),
    SelectedListItem(name: '1/2', value: '0.50'),
    SelectedListItem(name: '1/4', value: '0.250'),
  ];

  ///////////////////// selected user ///////////////////////////
  ///
  String _selectedType = '';
  String _selectedId = '';
  double _partFromApi = 0.0;
  String _selectedPart = '0.0';
  String _selectedPartValue = '0.0';

  ////////////////////////// selected user controller /////////////////////
  ///
  final TextEditingController _selectedTypeController = TextEditingController();
  final TextEditingController _selectedPartController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _selectedTypeController.dispose();
  }

  @override
  void initState() {
    getTontineMemberList();
    getPart();

    super.initState();
  }

  getTontineMemberList() async {
    List<User> apiUserList =
        await RemoteServices().getTontineUserList(id: widget.tontine.id);
    if (apiUserList.isNotEmpty) {
      for (User element in apiUserList) {
        _userList.add(
          SelectedListItem(
            name: element.fullName,
            value: element.id.toString(),
          ),
        );
      }
    } else {}
  }

  getPart() async {
    var apiPart =
        await RemoteServices().getGroupPart(groupeId: widget.groupe.id);
    if (apiPart != null) {
      setState(() {
        _partFromApi = apiPart;
      });
    }
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
        hintStyle: const TextStyle(color: Palette.secondaryColor),
        prefixIcon: const Icon(
          CupertinoIcons.person,
          color: Palette.secondaryColor,
        ),
        focusColor: Palette.appPrimaryColor,
        //suffixIconColor: Palette.appPrimaryColor,
        //filled: true,
        suffixIcon: const Icon(
          Icons.arrow_drop_down,
          color: Palette.secondaryColor,
          //color: Palette.appPrimaryColor,
        ),
        contentPadding: const EdgeInsets.only(top: 20.0, bottom: 20.0),

        hintText:
            _selectedType.isNotEmpty ? _selectedType : 'Selectionner un membre',

        // les autres propriétés de décoration que vous voulez utiliser

        border: const UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        // les autres propriétés de décoration que vous voulez utiliser
      ),
    );

    /////////////////////// part selector /////////////////////
    ///
    final partSelector = TextFormField(
      controller: _selectedPartController,
      cursorColor: Colors.black,
      onTap: () {
        FocusScope.of(context).unfocus();
        onTextFieldTap1();
      },
      validator: (value) {
        if (_selectedPart == '0.0') {
          return 'Veuillez selectionner un type de tontine';
        }
        return null;
      },
      decoration: InputDecoration(
        hintStyle: const TextStyle(color: Palette.secondaryColor),
        prefixIcon: const Icon(
          CupertinoIcons.app_badge,
          color: Palette.secondaryColor,
        ),
        focusColor: Palette.appPrimaryColor,
        //suffixIconColor: Palette.appPrimaryColor,
        //filled: true,
        suffixIcon: const Icon(
          Icons.arrow_drop_down,
          color: Palette.secondaryColor,
          //color: Palette.appPrimaryColor,
        ),
        contentPadding: const EdgeInsets.only(top: 20.0, bottom: 20.0),

        hintText: _selectedPart != '0.0'
            ? _selectedPart.toString()
            : 'Selectionner une part',

        // les autres propriétés de décoration que vous voulez utiliser

        border: const UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        // les autres propriétés de décoration que vous voulez utiliser
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.secondaryColor,
        elevation: 0,
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const CustomText(
                  text: 'Part restant',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                Container(
                  padding: const EdgeInsets.only(top: 14.0, left: 20.0),
                  margin: const EdgeInsets.only(
                    top: 10.0,
                    bottom: 10.0,
                  ),
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Palette.greyColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(
                      50,
                    ),
                  ),
                  child: Text(
                    _partFromApi.toString(),
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const CustomText(
                  text: 'Membre',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 10.0,
                  ),
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                      color: Palette.appPrimaryColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(
                        50,
                      )),
                  child: Center(
                    child: selectedField,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const CustomText(
                  text: 'Selectionner une part',
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                Container(
                  margin: const EdgeInsets.only(
                    top: 10.0,
                  ),
                  width: double.infinity,
                  height: 55,
                  decoration: BoxDecoration(
                    color: Palette.appPrimaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(
                      50,
                    ),
                  ),
                  child: Center(
                    child: partSelector,
                  ),
                ),
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
                    onPress: () async {
                      if (_formKey.currentState!.validate()) {
                        if (_partFromApi < 0) {
                          Fluttertoast.showToast(
                            msg: 'Cette action ne peut-être réalisée !',
                            backgroundColor: Palette.appPrimaryColor,
                          );
                        } else {
                          Functions.showLoadingSheet(ctxt: context);
                          bool response = await RemoteServices().addUserToGroup(
                            api: 'groups/membership',
                            part: _selectedPartValue,
                            userId: int.parse(_selectedId),
                            groupId: widget.groupe.id,
                          );
                          Future.delayed(const Duration(seconds: 3))
                              .then((value) {
                            if (response) {
                              int newId = int.parse(_selectedId);
                              setState(() {
                                widget.groupe.membrsId.add(newId);
                              });
                              Navigator.pop(context);
                              Fluttertoast.showToast(
                                msg: 'Utilisateur ajouté !',
                                backgroundColor: Palette.appPrimaryColor,
                              );
                              Navigator.pop(context);
                            } else {
                              Navigator.pop(context);
                              Fluttertoast.showToast(
                                msg:
                                    'Cet utilisateur appartient déjà au groupe !',
                                backgroundColor: Palette.appPrimaryColor,
                              );
                            }
                          });
                        }
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTextFieldTap() {
    DropDownState(
      DropDown(
        bottomSheetTitle: const Text(
          'Membres de la tontine',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: _userList.isNotEmpty ? _userList : [],
        selectedItems: (List<dynamic> selectedList) {
          List<String> list = [];
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              list.add(item.name);
              setState(() {
                _selectedId = item.value!;
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

  void onTextFieldTap1() {
    DropDownState(
      DropDown(
        bottomSheetTitle: const Text(
          'Membres de la tontine',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
        submitButtonChild: const Text(
          'Done',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        data: _partOnScreen.isNotEmpty ? _partOnScreen : [],
        selectedItems: (List<dynamic> selectedList) {
          //double savedPard = _partFromApi;
          List<String> list = [];
          for (var item in selectedList) {
            if (item is SelectedListItem) {
              list.add(item.name);
              setState(() {
                //_partFromApi = savedPard;
                _selectedPartValue = item.value!;
                _selectedPart = list[0];
                _partFromApi = _partFromApi - double.parse(item.value!);
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
