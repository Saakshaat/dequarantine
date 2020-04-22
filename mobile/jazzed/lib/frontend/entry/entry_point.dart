import 'package:flutter/material.dart';
import 'package:jazzed/frontend/entry/button_block.dart';
import 'package:jazzed/frontend/entry/title.dart';

import '../../main.dart';

class EntryPoint extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: theme.colorTheme.blackCharcoal,
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
