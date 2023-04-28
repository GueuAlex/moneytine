import 'package:flutter/material.dart';
import 'package:moneytine/models/notification_models.dart';
import 'package:moneytine/models/user.dart';
import 'package:moneytine/remote_services/remote_services.dart';
import 'package:moneytine/style/palette.dart';
import 'package:moneytine/widgets/loading_container.dart';

import '../../models/transation_by_date.dart';
import 'widgets/filter_box.dart';
import 'widgets/notifications_list.dart';

class NotifsScreen extends StatefulWidget {
  const NotifsScreen({
    super.key,
    required this.user,
  });

  final MyUser user;

  @override
  State<NotifsScreen> createState() => _NotifsScreenState();
}

class _NotifsScreenState extends State<NotifsScreen> {
  //////////////////////////// date range ////////////////////////////////////
  ///
  DateTimeRange _selectedDates = DateTimeRange(
    start: DateTime.now().subtract(const Duration(days: 30)),
    end: DateTime.now(),
  );
  /////////////////////////////////////////////////////
  /// nous permet d'afficher un container de loading pendant 5 seconds le temps de charger les données ////
  bool isLoading = true;

  ///////////////
  ///
  final List<NotificationModel> _thisUserNotifLis = [];
  List<DataByDate<NotificationModel>> _thisUserNotifLisByDate = [];
  List<DataByDate<NotificationModel>> _thisUserNotifLisByDateFiltrer = [];

  getNotifList() async {
    List<NotificationModel> thisUserNotifLis =
        await RemoteServices().getCurrentUserNotifsList(id: widget.user.id!);
    print(thisUserNotifLis);

    if (thisUserNotifLis.isNotEmpty) {
      _thisUserNotifLis.clear();
      for (NotificationModel element in thisUserNotifLis) {
        //if (element.userId == widget.user.id &&
        //element.groupeId == widget.groupe.id) {
        setState(() {
          _thisUserNotifLis.add(element);
        });
        //}
      }
      _thisUserNotifLis.sort(
        (a, b) => a.date.compareTo(b.date),
      );
      // Créer une liste de TransactionsByDate à partir de la liste triée
      List<DataByDate<NotificationModel>> notifsTrier = [];
      for (var t in _thisUserNotifLis) {
        DataByDate? last = notifsTrier.isNotEmpty ? notifsTrier.last : null;
        if (last == null || last.date != t.date) {
          notifsTrier.add(DataByDate<NotificationModel>(
            date: t.date,
            data: [t],
          ));
        } else {
          last.data.add(t);
        }
      }
      setState(() {
        _thisUserNotifLisByDate = notifsTrier;
      });
    }

// Filtrer les transactions qui sont incluses dans l'intervalle spécifié
    setState(() {
      _thisUserNotifLisByDateFiltrer = _thisUserNotifLisByDate.where((element) {
        //DateTime transactionDate = DateTime.parse(element.date.toString());
        return element.date
                .isAfter(_selectedDates.start.subtract(Duration(days: 1))) &&
            element.date.isBefore(_selectedDates.end.add(Duration(days: 1)));
      }).toList();
    });
  }

  //////////////////////////////////////////////////////
  ///un semblant de notification data
  bool isNotificationData = false;

  @override
  void initState() {
    getNotifList();
    Future.delayed(const Duration(seconds: 5)).then((_) {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

//////////////////////// dateTimeRange selector /////////////////////////
  ///
  ///
  Future<DateTimeRange?> dateTimeRange() async {
    return await showDateRangePicker(
      context: context,
      firstDate: DateTime(2023),
      lastDate: DateTime.now(),
      locale: const Locale('fr', 'FR'),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Palette.primarySwatch,
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
            colorScheme: const ColorScheme.light(
              primary: Palette.primarySwatch,
            ).copyWith(secondary: Palette.primarySwatch),
          ),
          child: SizedBox(
            width: double.infinity,
            height: 300,
            child: child,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.secondaryColor,
        title: const Text('Notifications'),
        elevation: 0,
      ),
      body: NotificationListener(
        child: SafeArea(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: const BoxDecoration(
                  color: Palette.secondaryColor,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.elliptical(200, 10),
                      bottomLeft: Radius.elliptical(200, 10)),
                ),
              ),
              Positioned(
                child: Padding(
                  padding: EdgeInsets.only(
                    right: 55,
                    left: 55,
                    top: 25,
                  ),
                  child: InkWell(
                      onTap: () async {
                        DateTimeRange? dtr = await dateTimeRange();

                        if (dtr != null) {
                          setState(() {
                            _selectedDates = dtr;
                          });
                        }
                        print(_selectedDates);
                        // Filtrer les transactions qui sont incluses dans l'intervalle spécifié
                        setState(() {
                          _thisUserNotifLisByDateFiltrer =
                              _thisUserNotifLisByDate.where((element) {
                            //DateTime transactionDate = DateTime.parse(element.date.toString());
                            return element.date.isAfter(_selectedDates.start
                                    .subtract(Duration(days: 1))) &&
                                element.date.isBefore(
                                    _selectedDates.end.add(Duration(days: 1)));
                          }).toList();
                        });
                      },
                      child: FilterBox(
                        interval: _selectedDates,
                        data: _thisUserNotifLisByDateFiltrer,
                      )),
                ),
              ),
              !isLoading
                  ? _thisUserNotifLisByDateFiltrer.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.only(top: 160),
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(
                                _thisUserNotifLisByDateFiltrer.length,
                                (index) => NotificationList(
                                  notificationModelByDate:
                                      _thisUserNotifLisByDateFiltrer[index],
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          margin: const EdgeInsets.only(top: 250),
                          padding: const EdgeInsets.all(30),
                          width: double.infinity,
                          height: 300,
                          child: Column(
                            children: [
                              /* Image.asset(
                                'assets/images/missing_notif.jpg',
                                width: 200,
                              ), */
                              Text('Pas de notifications pour cette intervalle')
                            ],
                          ),
                        )
                  : Padding(
                      padding: const EdgeInsets.only(top: 100),
                      child: LoadingContainer(),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
