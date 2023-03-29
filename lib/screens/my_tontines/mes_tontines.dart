import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:moneytine/models/tontine.dart';
import 'package:moneytine/models/user.dart';
import 'package:moneytine/remote_services/remote_services.dart';
import 'package:moneytine/screens/add_tontine/add_tontine.dart';
import 'package:moneytine/screens/all_transactions_history/all_transations_history.dart';

import '../../style/palette.dart';
import '../../widgets/transactions_widget.dart';
import 'widgets/create_tontine_sheet_content.dart';
import 'widgets/join_create_buttons.dart';
import 'widgets/mes_tontines_top_box.dart';

class MesTontinesScreen extends StatefulWidget {
  const MesTontinesScreen({super.key, required this.user});

  final User user;

  @override
  State<MesTontinesScreen> createState() => _MesTontinesScreenState();
}

class _MesTontinesScreenState extends State<MesTontinesScreen> {
  /////////////////////// scrolle controller //////////////////////////
  ///
  ///
  final ScrollController _scrolleController = ScrollController();

  /////////////////////////////////// bool show elements //////////////
  ///
  bool isHiden = false;
  ////////////////////////
  ///
  ///////////// its work but i need to try som thing //////////////////
  ///
  //List<Tontine> tontineList = [];
  ///////////////////
  ///
  @override
  void initState() {
    _scrolleController.addListener(() {
      if (_scrolleController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          isHiden = false;
        });
      } else if (_scrolleController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          isHiden = true;
        });
      }
    });
    getOwnTontineList();
    getAllTontineListWhereCurrentUserParticiped();
    super.initState();
  }

  @override
  void dispose() {
    _scrolleController.dispose();
    super.dispose();
  }

  ////////////////// tontine list from api //////////////////
  void getOwnTontineList() async {
    List<Tontine?> tontineList1 = await RemoteServices()
        .getCurrentUserTontineList(id: int.parse(widget.user.id.toString()));
    if (tontineList1.isNotEmpty) {
      currentUSerTontineList.clear();
      for (var element in tontineList1) {
        setState(() {
          // tontineList.add(element!);
          currentUSerTontineList.add(element!);
        });
      }
    }
  }

  ////////////////// tontine list from api //////////////////
  void getAllTontineListWhereCurrentUserParticiped() async {
    List<Tontine?> tontineList1 = await RemoteServices().getAllTontineList();
    if (tontineList1.isNotEmpty) {
      allTontineWhereCurrentUserParticipe.clear();
      for (var element in tontineList1) {
        if (element?.creatorId != widget.user.id &&
            element!.membersId.contains(widget.user.id)) {
          setState(() {
            // tontineList.add(element!);
            allTontineWhereCurrentUserParticipe.add(element);
          });
        }
      }
      print('je participe à : $allTontineWhereCurrentUserParticipe');
    }
  }

  ///////////////////////////////////
  void _showBottomSheet(BuildContext context, bool isCreateTontine) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return CreatetontineSheetContent(
            user: widget.user,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 249, 249, 249),
        extendBody: true,
        appBar: AppBar(
          centerTitle: false,
          shadowColor: Palette.greyColor,
          backgroundColor: Palette.secondaryColor,
          elevation: 0,
        ),
        body: Stack(
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ////////////////// top container mise en commentaire pour plutard
                  ///
                  !isHiden
                      ? Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(
                            left: 15.0,
                            right: 4.0,
                          ),
                          height: 150,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.elliptical(200, 10),
                                bottomLeft: Radius.elliptical(200, 10)),
                            color: Palette.secondaryColor,
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(0),
                            //minVerticalPadding: 0,
                            horizontalTitleGap: 0,

                            leading: Container(
                              padding: const EdgeInsets.only(),
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Palette.whiteColor,
                                border: Border.all(
                                  width: 4,
                                  color:
                                      Palette.appPrimaryColor.withOpacity(0.3),
                                ),
                              ),
                              child: const Center(
                                child: Icon(
                                  CupertinoIcons.person_fill,
                                  color: Palette.greyColor,
                                  size: 50,
                                ),
                              ),
                            ),
                            title: Text(
                              'Bonjour',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      color: Palette.whiteColor, fontSize: 18),
                            ),
                            subtitle: Text(
                              widget.user.fullName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                      height: 1.5,
                                      color: Palette.whiteColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        )
                      : Container(),

                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      width: double.infinity,
                      child: SingleChildScrollView(
                        controller: _scrolleController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            !isHiden
                                ? const SizedBox(
                                    height: 80,
                                  )
                                : Container(),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.only(
                                  top: 8.0, right: 45.0, left: 45.0),
                              child: FittedBox(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    JoinCreateButton(
                                      text: 'Créée',
                                      svg: 'assets/icons/create.svg',
                                      color: Palette.secondaryColor,
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                          return AddTontineScreen(
                                            tontineName:
                                                DateFormat('tontine_dd/MM/yyyy')
                                                    .format(
                                              DateTime.now(),
                                            ),
                                            user: widget.user,
                                          );
                                        }));
                                      },
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    JoinCreateButton(
                                      text: 'Rejoindre',
                                      svg: 'assets/icons/finger.svg',
                                      color: Palette.primaryColor,
                                      onTap: () {
                                        _showBottomSheet(context, false);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(bottom: 8.0, top: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Dernières transactions',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .copyWith(
                                          color: Palette.greySecondaryColor,
                                          fontSize: 14,
                                        ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context, rootNavigator: true)
                                          .push(MaterialPageRoute(
                                              builder: (context) {
                                        return const AllTransactionsHistory();
                                      }));
                                    },
                                    child: Text(
                                      'Tout afficher',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge!
                                          .copyWith(
                                              color: Palette.greySecondaryColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 0.0),
                              child: Column(
                                children: List.generate(
                                  3,
                                  (index) => const TransactionsWidget(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            !isHiden
                ? MesTontinesTopBox(
                    widget: widget,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
