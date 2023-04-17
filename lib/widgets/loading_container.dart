import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  const LoadingContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 2.5,
      // color: Colors.green,
      child: Center(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          width: 120,
          height: 110,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            //color: Colors.amber,
          ),
          child: Center(
            child: Image.asset('assets/icons/loading.gif'),
          ),
        ),
      ),
    );
  }
}
