import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../models/tontine.dart';
import '../../../models/user.dart';
import '../../../remote_services/remote_services.dart';
import '../../../style/palette.dart';
import '../../single_tontine/widgets/status_sheet.dart';

class GroupTopBox extends StatefulWidget {
  const GroupTopBox({
    super.key,
    required this.tontine,
  });
  final Tontine tontine;

  @override
  State<GroupTopBox> createState() => _GroupTopBoxState();
}

class _GroupTopBoxState extends State<GroupTopBox> {
  /////////////////////////////
  ///
  ///

  @override
  void initState() {
    //getTontineMemberList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.all(4.0),
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.0),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 1), // déplace l'ombre vers le bas
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, -1), // déplace l'ombre vers le haut
          )
        ],
        color: Palette.whiteColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: InkWell(
        onTap: () => _showBottomSheet(
          context: context,
          tontine: widget.tontine,
          // textField: searchField,
          size: size,
          //listUser: _foundList.isEmpty ? _userList : _foundList,
        ),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(
                  left: 6,
                  right: 6,
                  top: 15,
                ),
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: Palette.greyColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'Recherche',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Container(
              width: 50,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Palette.secondaryColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Icon(
                  CupertinoIcons.search,
                  color: Palette.secondaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ////////////////////////////////////////
  ///
  ///

  /////////////////////
  /////////
  ///
  void _showBottomSheet({
    required BuildContext context,
    // required Widget textField,
    required double size,
    //required List<MyUser> listUser,
    required Tontine tontine,
  }) {
    showBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          height: size / 0.5,
          decoration: const BoxDecoration(
            color: Palette.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: SearchContainer(
            tontine: tontine,
            //textField: textField,
            //listUser: listUser,
          ),
        );
      },
    );
  }
}

class SearchContainer extends StatefulWidget {
  const SearchContainer({
    super.key,
    required this.tontine,
  });

  //final Widget textField;
  //final List<MyUser> listUser;
  final Tontine tontine;

  @override
  State<SearchContainer> createState() => _SearchContainerState();
}

class _SearchContainerState extends State<SearchContainer> {
  final TextEditingController searchController = TextEditingController();
  //////////////////////////////
  ///
  ////////////////////////////
  bool isLoading = true;
  //////////////////////////////
  List<MyUser> _userList = [];
  List<MyUser> _foundList = [];
  ///////////////////// selected user ///////////////////////////
  ///
  getTontineMemberList() async {
    //print('okkkkkkkkkkkkkkkkkkkkkkkkkkkk');
    List<MyUser> apiUserList =
        await RemoteServices().getTontineUserList(id: widget.tontine.id);
    if (apiUserList.isNotEmpty) {
      setState(() {
        _userList = apiUserList;
      });
    } else {}
  }

  @override
  void initState() {
    getTontineMemberList();
    Future.delayed(const Duration(seconds: 3)).then((_) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final searchField = TextFormField(
      onChanged: (value) {
        setState(() {
          _foundList = _userList
              .where(
                (element) => element.fullName.toLowerCase().contains(
                      value.toLowerCase(),
                    ),
              )
              .toList();
        });

        // print(_foundList);
      },
      controller: searchController,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.next,
      cursorColor: Colors.black,
      style: const TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 18,
      ),
      onSaved: (email) {},
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: 'Recherche',
      ),
    );
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25.0),
        topRight: Radius.circular(25.0),
      )),
      padding: const EdgeInsets.all(8.0),
      child: !isLoading
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Container(
                      width: 60,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Palette.greyColor.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Text(
                    'Membres de la tontine',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.5),
                  child: Container(
                    padding: const EdgeInsets.only(right: 10, left: 10),
                    width: double.infinity,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Palette.greyColor.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Expanded(child: searchField),
                        Container(
                          // padding: const EdgeInsets.all(6),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Palette.greyColor.withOpacity(0.3),
                          ),
                          child: const Center(
                            child: Icon(
                              CupertinoIcons.xmark,
                              size: 20,
                              color: Color.fromARGB(255, 255, 255, 255),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        _foundList.isNotEmpty
                            ? _foundList.length
                            : _userList.length,
                        (index) => UserWidget(
                          user: _foundList.isNotEmpty
                              ? _foundList[index]
                              : _userList[index],
                          tontine: widget.tontine,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          : Center(
              child: CircularProgressIndicator.adaptive(),
            ),
    );
  }
}
