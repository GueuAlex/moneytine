import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../models/tontine.dart';
import '../../../models/user.dart';
import '../../../style/palette.dart';
import '../../single_tontine/single_tontine.dart';
import 'jeparticipe_tontine_card.dart';

class JeParticipe extends StatefulWidget {
  const JeParticipe({
    super.key,
    required this.tontineList,
    required this.user,
  });

  final List<Tontine> tontineList;
  final MyUser user;

  @override
  State<JeParticipe> createState() => _JeParticipeState();
}

class _JeParticipeState extends State<JeParticipe> {
  ///////////////////////////////////////////////////////
  ///
  ///
  List<Tontine> _tontineList = [];
  //////////////////////////////////////////////
  ///
  String filterName = 'Toutes les tontines';
  //////////////////////////////////////////////
  List<String> _options = [
    'Toutes les tontines',
    'Tontines en cours',
    'Tontines terminées',
  ];
  List<String> _assets = [
    'assets/icons/search-eye-line.svg',
    'assets/icons/refresh-line.svg',
    'assets/icons/check-line.svg',
  ];
  ///////////////////////////////////////////////
  ///
/*   runFilter() {
    print('object');
    if (filterName == 'Toutes les tontines') {
      //_tontineList.clear();
      setState(() {
        _tontineList = widget.tontineList;
      });
    }
    if (filterName == 'Tontines en cours') {
      _tontineList.clear();
      for (Tontine tontine in widget.tontineList) {
        if (tontine.isActive == 1) {
          setState(() {
            _tontineList.add(tontine);
          });
        }
      }
    }
    if (filterName == 'Tontines terminées') {
      _tontineList.clear();
      for (Tontine tontine in widget.tontineList) {
        if (tontine.isActive == 0) {
          setState(() {
            _tontineList.add(tontine);
          });
        }
      }
    }
  } */

  ////////////////////////////////////////////////
  ///
  @override
  void initState() {
    _tontineList = widget.tontineList;
    super.initState();
  }

  ///////////////////////////////////////////////
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Palette.secondaryColor,
      appBar: AppBar(
        backgroundColor: Palette.secondaryColor,
        //title: const Text('3 tontines'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 150,
                width: double.infinity,
                child: Stack(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 65, right: 65),
                      width: double.infinity,
                      height: 100,
                      //padding: const EdgeInsets.only(right: 50, left: 50),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.elliptical(200, 10),
                            bottomLeft: Radius.elliptical(200, 10)),
                        color: Palette.secondaryColor,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                widget.tontineList.length.toString(),
                                style: const TextStyle(
                                  color: Palette.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35,
                                ),
                              ),
                              Text(
                                widget.tontineList.length <= 1
                                    ? '  Tontine'
                                    : '  Tontines',
                                style: const TextStyle(
                                  color: Palette.whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 100,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Palette.blackColor.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: const Center(
                              child: Text(
                                'Participant',
                                style: TextStyle(
                                  color: Palette.greyWhiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      //top: 10,
                      child: Container(
                        padding: const EdgeInsets.only(
                          top: 80,
                          bottom: 10,
                        ),
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.transparent,
                        child: Center(
                          child: Container(
                            padding: const EdgeInsets.all(5.0),
                            width: 300,
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.0),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, 1), // déplace l'ombre vers le bas
                                ),
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(
                                      0, -1), // déplace l'ombre vers le haut
                                )
                              ],
                              color: Palette.whiteColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ////////////////////////////////////////
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Palette.greyColor.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        filterName,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                          color: Palette.greyColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 4.0),
                                InkWell(
                                  onTap: () => _showBottomSheet(context),
                                  child: Container(
                                    width: 60,
                                    height: MediaQuery.of(context).size.height,
                                    decoration: BoxDecoration(
                                      color: Palette.appPrimaryColor
                                          .withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        'assets/icons/filter.svg',
                                        width: 30,
                                        color: Palette.secondaryColor,
                                      ),
                                    ),
                                  ),
                                )
                                /////////////////////////////////////////
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: List.generate(
                  widget.tontineList.length,
                  (index) => JeParticipeTontineCard(
                    tontine: widget.tontineList[index],
                    onTap: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SingleTontine(
                          tontine: widget.tontineList[index],
                          user: widget.user,
                        );
                      }));
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /////////////////////////
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) {
        return Container(
          height: 300,
          decoration: const BoxDecoration(
            color: Palette.whiteColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25.0),
              topRight: Radius.circular(25.0),
            ),
          ),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
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
                const Padding(
                  padding: EdgeInsets.only(top: 15.5),
                  child: Text(
                    ' ',
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                //Options(options: _options)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(
                    _options.length,
                    (index) => ListTile(
                      onTap: () {
                        setState(() {
                          filterName = _options[index];
                        });
                        Navigator.pop(context);

                        // runFilter();
                      },
                      leading: Container(
                        padding: EdgeInsets.all(8),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Palette.secondaryColor.withOpacity(0.3),
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            _assets[index],
                            color: Palette.secondaryColor,
                          ),
                        ),
                      ),
                      title: Text(_options[index]),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  ///
  ////////////////////////
}
