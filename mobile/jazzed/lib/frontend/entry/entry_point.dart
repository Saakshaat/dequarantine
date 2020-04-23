import 'package:flutter/material.dart';
import 'package:jazzed/frontend/entry/button_block.dart';
import 'package:jazzed/frontend/entry/title.dart';

import 'package:jazzed/main.dart';

class EntryPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          TitleAndDescription(),
          ButtonBlock(),
        ],
      ),
    );
  }
}
