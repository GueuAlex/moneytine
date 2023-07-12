import 'package:flutter/material.dart';
import 'package:moneytine/style/palette.dart';

import 'config/prefs.dart';
import 'intro.dart';
import 'models/money_transaction.dart';
import 'models/tontine.dart';
import 'models/transation_by_date.dart';
import 'models/user.dart';
import 'remote_services/remote_services.dart';
import 'screens/auth/login.dart';
import 'screens/auth/pin_code/pin_code.dart';

class SplashCreen extends StatefulWidget {
  const SplashCreen({super.key});

  @override
  State<SplashCreen> createState() => _SplashCreenState();
}

class _SplashCreenState extends State<SplashCreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5)).then((value) async {
      /* print(await Prefs().id);
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) {
        //return const MyHomePage(title: 'MoneyTine');
        return const IntroScreen();
      })); */
      //print('intro is view: ${await Prefs().introIsView}');
      //print('loger id: ${await Prefs().id}');

      if (await Prefs().id == null && await Prefs().introIsView == null) {
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          //return const MyHomePage(title: 'MoneyTine');
          return const IntroScreen();
        }));
      } else if (await Prefs().id == null &&
          await Prefs().introIsView == true) {
        // ignore: use_build_context_synchronously
        Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (context) {
          //return const MyHomePage(title: 'MoneyTine');
          return const LoginScreen();
        }));
      } else if (await Prefs().id != null &&
          await Prefs().introIsView == true) {
        int id = await Prefs().id;
        var response = await RemoteServices().getSingleUser(id: id);
        // ignore: use_build_context_synchronously
        if (response != null) {
          MyUser user = response;
          getAllTontineListWhereCurrentUserParticiped(id: user.id!);
          getAllTransactions(id: user.id);
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                //return const MyHomePage(title: 'MoneyTine');
                return PinCodeScreen(
                  user: user,
                );
              },
            ),
          );
        } else {
          // ignore: use_build_context_synchronously
          Navigator.of(context)
              .pushReplacement(MaterialPageRoute(builder: (context) {
            //return const MyHomePage(title: 'MoneyTine');
            return const LoginScreen();
          }));
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height,
        color: Palette.whiteColor,
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset('assets/images/logo.jpg'),
                const SizedBox(
                  height: 30.0,
                ),
                Image.asset('assets/icons/loading.gif')
              ],
            ),
          ),
        ),
      ),
    );
  }

  void getAllTontineListWhereCurrentUserParticiped({required int id}) async {
    List<Tontine?> tontineList1 = await RemoteServices().getAllTontineList();
    //List<Tontine> allTontineWhereCurrentUserParticipe = [];

    if (tontineList1.isNotEmpty) {
      //allTontineWhereCurrentUserParticipe.clear();
      for (var element in tontineList1) {
        if (element?.creatorId != id && element!.membersId.contains(id)) {
          //setState(() {
          allTontineWhereCurrentUserParticipe.add(element);
          // });
        }
        if (element?.creatorId == id) {
          // setState(() {
          currentUSerTontineList.add(element!);
          // });
        }
      }
      // print('je participe à : $allTontineWhereCurrentUserParticipe');
    }
  }

  Future<void> getAllTransactions({required id}) async {
    List<MoneyTransaction> allTransactions =
        await RemoteServices().getTransactionsList();

    if (allTransactions.isNotEmpty) {
      globalTransactionsList.clear();
      for (MoneyTransaction element in allTransactions) {
        if (element.tontineCreatorId == id || element.userId == id) {
          //setState(() {
          globalTransactionsList.add(element);
          // });
        }
      }
      globalTransactionsList.sort(
        (a, b) => a.date.compareTo(b.date),
      );
      globalTransactionsList.sort((a, b) {
        int dateComparison = b.date.compareTo(a.date);
        if (dateComparison != 0) {
          return dateComparison;
        }
        return a.hours.compareTo(b.hours);
      });
      // Créer une liste de TransactionsByDate à partir de la liste triée
      List<DataByDate<MoneyTransaction>> transactionsByDate = [];
      for (var t in globalTransactionsList) {
        DataByDate? last =
            transactionsByDate.isNotEmpty ? transactionsByDate.last : null;
        if (last == null || last.date != t.date) {
          transactionsByDate.add(DataByDate<MoneyTransaction>(
            date: t.date,
            data: [t],
          ));
        } else {
          last.data.add(t);
        }
      }
      //setState(() {
      AlltrasansactionsByDate = transactionsByDate;
      // });
    }
  }
}
