import 'package:evently_c16_sun/data/models/category.dart';
import 'package:evently_c16_sun/data/models/event.dart';
import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({required this.event, super.key});

  @override
  Widget build(BuildContext context) {
    var category = Category.categories.firstWhere(
      (e) => e.id == (event.categoryId ?? -1),
    );
    return AspectRatio(
      aspectRatio: 360 / 200,
      child: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(category.imagePath)),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            width: 2,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Text(event.title ?? "", style: Theme.of(context).textTheme.labelLarge,),
            ),
          ],
        ),
      ),
    );
  }
}
