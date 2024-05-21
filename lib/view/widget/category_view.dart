import 'package:flutter/material.dart';
import 'package:intern_riverpod/view/tabs/business_tab.dart';
import 'package:intern_riverpod/view/tabs/enter_tab.dart';
import 'package:intern_riverpod/view/tabs/health_tab.dart';
import 'package:intern_riverpod/view/tabs/tech_tab.dart';
import 'package:intern_riverpod/view/widget/news_category.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            children: [
              NewsCategory(
                color: Colors.amber[100],
                categoryName: 'Business',
                width: 0.0,
                height: 0.0,
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const BusinessTab()));
                },
              ),
              NewsCategory(
                color: Colors.blue[100],
                categoryName: 'Technology',
                width: 0.0,
                height: 0.0,
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => const TechTab()));
                },
              )
            ],
          ),
          Row(
            children: [
              NewsCategory(
                color: Colors.green[100],
                categoryName: 'Health',
                width: 0.0,
                height: 0.0,
                onTap: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const HealthTab()));
                },
              ),
              NewsCategory(
                color: Colors.red[100],
                categoryName: 'Entertainment',
                width: 0.0,
                height: 0.0,
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => const EntertainmentTab()));
                },
              )
            ],
          )
        ],
      ),
    );
  }
}
