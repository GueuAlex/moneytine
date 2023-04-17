import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GroupMemberShimmer extends StatelessWidget {
  const GroupMemberShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        bottom: 5.0,
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            color: Colors.grey,
          ),
          child: const Center(
            child: Icon(
              CupertinoIcons.person_fill,
              size: 20,
              color: Colors.grey,
            ),
          ),
        ),
        title: Container(
          height: 4,
          width: 50,
          color: Colors.grey,
        ),
        subtitle: Container(
          height: 2,
          width: 100,
          color: Colors.grey,
        ),
      ),
    );
  }
}
