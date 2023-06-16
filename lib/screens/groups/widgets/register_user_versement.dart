import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';

import '../../../functions/firebase_fcm.dart';
import '../../../functions/functions.dart';
import '../../../functions/local_notification_services.dart';
import '../../../models/money_transaction.dart';
import '../../../models/notification_models.dart';
import '../../../models/tontine.dart';
import '../../../models/user.dart';
import '../../../remote_services/remote_services.dart';
import '../../../style/palette.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_text.dart';

class RegisterUserVersement extends StatefulWidget {
  const RegisterUserVersement({
    super.key,
    required this.groupe,
    required this.tontine,
    required this.user,
  });
  final Groupe groupe;
  final Tontine tontine;
  final MyUser user;

  @override
  State<RegisterUserVersement> createState() => _RegisterUserVersementState();
}

class _RegisterUserVersementState extends State<RegisterUserVersement> {
  /////////////////////////////// text editing controllers////////////////////
  ///paiement note controller
  ///paiement amount controller
  //final TextEditingController _paimentNoteCotroller = TextEditingController();
  final TextEditingController _paiementAmountController =
      TextEditingController();

  /////////////////////////////////////form key /////////////////////
  ///
  final _formKey = GlobalKey<FormState>();

  ///////////////////////// paimemnt date & paiment time //////////////////////
  ///
  DateTime _selectedPaimentDate = DateTime.now();
  TimeOfDay _selectedPaimentTime = TimeOfDay.now();

  ////////////////////////// disposer les controllers /////////////////////
  ///
  @override
  void dispose() {
    super.dispose();
    // _paimentNoteCotroller.dispose();
    _paiementAmountController.dispose();
  }

  @override
  void initState() {
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService().display(event);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ////////////// paiment amount amount field ///////////////////
    final paiementAmountField = TextFormField(
      controller: _paiementAmountController,
      keyboardType: TextInputType.number,
      autofocus: false,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Veuillez entrer un montant !");
        }

        return null;
      },
      onSaved: (value) {
        _paiementAmountController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        prefixIcon: Icon(
          CupertinoIcons.money_dollar_circle,
          color: Palette.secondaryColor,
        ),
        focusColor: Palette.appPrimaryColor,
        //suffixIconColor: Palette.appPrimaryColor,
        //filled: true,
        /* suffixIcon: const Icon(
          Icons.arrow_drop_down,
          color: Palette.appPrimaryColor,
        ), */
        contentPadding: EdgeInsets.only(
          top: 15.0,
        ),
        hintStyle: TextStyle(
          color: Palette.secondaryColor,
        ),

        hintText: 'Entrez un montant de paiement',
        /* focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Palette.appPrimaryColor),
        ), */
        // les autres propriétés de décoration que vous voulez utiliser

        border: UnderlineInputBorder(
          borderSide: BorderSide.none,
        ),
        // les autres propriétés de décoration que vous voulez utiliser
      ),
    );

    ////////////// paiment note  field ///////////////////
    /* final paiementNoteField = TextFormField(
      controller: _paimentNoteCotroller,
      keyboardType: TextInputType.text,
      autofocus: false,
      validator: (value) {
        if (value!.isNotEmpty && value.length < 3) {
          return ("Veuillez correctement renseigner la note !");
        }

        return null;
      },
      onSaved: (value) {
        _paimentNoteCotroller.text = value!;
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

        hintText: 'Entrer une note de paiement (Facultif)',
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Palette.appPrimaryColor),
        ),
        // les autres propriétés de décoration que vous voulez utiliser

        border: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        // les autres propriétés de décoration que vous voulez utiliser
      ),
    ); */

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Palette.secondaryColor,
        title: const Text('versement'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0, left: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    const CustomText(
                      text: 'Enregistrer un paiement pour ',
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                    CustomText(
                      text: widget.user.fullName,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25.0,
                ),

                ///////////////////// date & hours field ////////////////////
                ///
                ///
                FittedBox(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            color: Palette.greyColor.withOpacity(0.8),
                            fontSize: 12,
                            text: 'Date',
                            // fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          InkWell(
                            onTap: () {
                              _dateSelector1(context);
                              //_selectDate(context);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(top: 10.0),
                              padding: const EdgeInsets.only(
                                right: 10.0,
                                left: 15.0,
                              ),
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                  color:
                                      Palette.appPrimaryColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(
                                    50.0,
                                  )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _selectedPaimentDate != DateTime.now()
                                      ? Text(
                                          DateFormat('dd / MM / yyyy')
                                              .format(_selectedPaimentDate),
                                          style: const TextStyle(
                                              color: Palette.secondaryColor),
                                        )
                                      : const Text(
                                          'Date de paiement',
                                          style: TextStyle(
                                              color: Palette.secondaryColor),
                                        ),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: Palette.secondaryColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            color: Palette.greyColor.withOpacity(0.8),
                            fontSize: 12,
                            text: 'Heure',
                            //fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          InkWell(
                            onTap: () => _timeSelector(context),
                            child: Container(
                              margin: const EdgeInsets.only(top: 10.0),
                              padding: const EdgeInsets.only(
                                right: 10.0,
                                left: 15.0,
                              ),
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                  color:
                                      Palette.appPrimaryColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(
                                    50.0,
                                  )),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  _selectedPaimentTime != TimeOfDay.now()
                                      ? Text(
                                          DateFormat('HH : mm ')
                                              .format(DateTime(
                                            DateTime.now().year,
                                            DateTime.now().month,
                                            DateTime.now().day,
                                            _selectedPaimentTime.hour,
                                            _selectedPaimentTime.minute,
                                          )),
                                          style: const TextStyle(
                                            color: Palette.secondaryColor,
                                          ),
                                        )
                                      : Text(
                                          '${_selectedPaimentTime.hour}:${_selectedPaimentTime.minute}',
                                        ),
                                  const Icon(
                                    Icons.arrow_drop_down,
                                    color: Palette.secondaryColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                /////////////// and /////////////////////
                ///
                const SizedBox(
                  height: 20.0,
                ),
                CustomText(
                  text: 'Montant du paiement',
                  color: Palette.greyColor.withOpacity(0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
                Container(
                  height: 50,
                  margin: const EdgeInsets.only(
                    bottom: 20.0,
                    top: 10.0,
                  ),
                  padding: const EdgeInsets.only(left: 10.0),
                  decoration: BoxDecoration(
                    color: Palette.appPrimaryColor.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(
                      50.0,
                    ),
                  ),
                  child: Center(
                    child: paiementAmountField,
                  ),
                ),

                CustomButton(
                  isSetting: true,
                  fontsize: 13,
                  color: Palette.appPrimaryColor,
                  width: double.infinity,
                  height: 35,
                  radius: 50,
                  text: 'Enregistrez le paiement',
                  onPress: () async {
                    if (_formKey.currentState!.validate()) {
                      Functions.showLoadingSheet(ctxt: context);
                      /*  print('heure : ${_selectedPaimentTime.hour}');
                      print('date : $_selectedPaimentDate');
                      print('groupe id : ${widget.groupe.id}');
                      print('user id : ${widget.user.id}');
                      print(
                          '${_selectedPaimentTime.hour}:${_selectedPaimentTime.minute}'); */
                      double amount =
                          double.parse(_paiementAmountController.text);
                      MoneyTransaction moneyTransaction = MoneyTransaction(
                        type: 'Versement',
                        amunt: amount,
                        hours:
                            '${_selectedPaimentTime.hour}:${_selectedPaimentTime.minute}',
                        date: _selectedPaimentDate,
                        userId: widget.user.id!,
                        groupeId: widget.groupe.id,
                        tontineId: widget.tontine.id,
                        tontineCreatorId: widget.tontine.creatorId,
                      );
                      Future.delayed(const Duration(seconds: 3)).then(
                        (value) async {
                          if (await Functions.postTransatcionDetails(
                              moneyTransaction: moneyTransaction)) {
                            ///////////////////////////////
                            ///on creer une donnée de notif pour notre db
                            NotificationModel newNotif = NotificationModel(
                              amount: amount,
                              recipientId: widget.user.id!,
                              type: 'Versement',
                              tontineId: widget.tontine.id,
                              date: DateTime.now(),
                              hour: DateFormat('HH:mm').format(DateTime.now()),
                            );
                            var response =
                                await RemoteServices().postNotifDetails(
                              api: 'notifications',
                              notificationModel: newNotif,
                            );
                            if (response != null) {
                              ///////////////////////////////////////////
                              /// envoi de notification
                              FirebaseFCM.getTokenNotificationByEmail(
                                userEmail: widget.user.email,
                              ).then(
                                (token) {
                                  if (token != null) {
                                    FirebaseFCM.sendNotification(
                                      title: 'Transaction',
                                      token: token,
                                      message:
                                          'Votre versement a été enregistrer  👍🏻',
                                    );
                                    ////////////:: set bool
                                    ///
                                    ///
                                    FirebaseFCM.updateUserIsNotifField(
                                        email: widget.user.email,
                                        isNotif: true);
                                  }
                                },
                              );
                            } else {
                              // print('une erreur quelque part');
                            }

                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                              msg: 'Versement enregistré !',
                              backgroundColor: Palette.appPrimaryColor,
                            );
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                          } else {
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            Fluttertoast.showToast(
                              msg: 'Veuillez réessayer !',
                              backgroundColor: Palette.appPrimaryColor,
                            );
                          }
                        },
                      );
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  //////////////////////////// date selector switch platform///////////////////
  ///
  Future<void> _dateSelector1(BuildContext context) async {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return showModalBottomSheet(
        context: context,
        builder: (BuildContext builder) {
          return Container(
            color: CupertinoColors.quaternarySystemFill,
            height: MediaQuery.of(context).copyWith().size.height / 3,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Annuler',
                        style: TextStyle(
                          color: CupertinoColors.systemRed,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'ok',
                        style: TextStyle(
                          color: CupertinoColors.activeBlue,
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: CupertinoDatePicker(
                    initialDateTime: _selectedPaimentDate,
                    onDateTimeChanged: (DateTime newDate) {
                      setState(() {
                        _selectedPaimentDate = newDate;
                        //print(newDate.toString());
                      });
                    },
                    minimumYear: 1900,
                    maximumYear: 2100,
                    mode: CupertinoDatePickerMode.date,
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedPaimentDate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100),
      );
      if (picked != null && picked != _selectedPaimentDate) {
        setState(() {
          _selectedPaimentDate = picked;
        });
      }
    }
  }

  ////////////////////////// time selector ////////////////////////////////
  ///
  Future<void> _timeSelector(BuildContext context) async {
    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: _selectedPaimentTime,
    );
    if (newTime != null) {
      setState(() {
        _selectedPaimentTime = newTime;
      });
    }
  }
}
