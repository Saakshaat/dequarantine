import 'package:flutter/material.dart';


class CategoryButton extends StatelessWidget {
  
  final IconData icon;
  final String category;
  final void Function() onTap;
  final List events;

  CategoryButton({
    @required this.icon,
    @required this.category,
    @required this.onTap,
    @required this.events,
  });
  
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5)
      ),
      elevation: 3,
      color: Theme.of(context).cardColor,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5)
        ),
        width: 80,
        height: 80,
        child: InkWell(
          onTap: onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(icon),
              Text(category, style: TextStyle(fontSize: 10),),
            ],
          ),
        ),
      ),
    );
  }
}