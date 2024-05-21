import 'package:flutter/material.dart';
import 'package:intern_riverpod/view/tabs/general_tab.dart';

class ViewAllButton extends StatelessWidget {
  const ViewAllButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 20.0, bottom: 20.0),
          child: const Text(
            'General News',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(right: 10.0, bottom: 20.0),
          child: TextButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const GeneralTab()));
            },
            child: const Text(
              'View All',
              style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
