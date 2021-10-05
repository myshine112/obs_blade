import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:obs_blade/shared/general/base/base_card.dart';

import 'block_entry.dart';
import 'light_divider.dart';

class ActionBlock extends StatelessWidget {
  final String? title;
  final String? description;
  final Widget? descriptionWidget;
  final List<BlockEntry> blockEntries;
  final bool dense;

  final double generalizedPadding = 14.0;
  final double iconSize = 32.0;

  const ActionBlock({
    Key? key,
    this.title,
    this.description,
    this.descriptionWidget,
    required this.blockEntries,
    this.dense = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> entriesWithDivider = [];
    for (var entry in this.blockEntries) {
      entriesWithDivider.add(entry);
      entriesWithDivider.add(
        Padding(
          padding: EdgeInsets.only(
            left: entry.leading != null
                ? 2 * this.generalizedPadding + this.iconSize
                : this.generalizedPadding,
          ),
          child: const LightDivider(),
        ),
      );
    }

    /// Remove last so we can use the full width divider
    /// as the last one
    entriesWithDivider.removeLast();

    return Padding(
      padding: EdgeInsets.only(top: !this.dense ? 32.0 : 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (this.title != null && this.title!.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: this.generalizedPadding + 18),
              child: Text(
                this.title!.toUpperCase(),
                style: Theme.of(context).textTheme.caption,
              ),
            ),
          BaseCard(
            topPadding: 8.0,
            bottomPadding: 8.0,
            paddingChild: const EdgeInsets.all(0),
            child: Container(
              color: Theme.of(context).cardColor,
              child: Column(
                children: entriesWithDivider,
              ),
            ),
          ),
          if (this.descriptionWidget != null ||
              (this.description != null && this.title!.isNotEmpty))
            Padding(
              padding: EdgeInsets.only(left: this.generalizedPadding + 18),
              child: this.descriptionWidget ??
                  Text(
                    this.description!.toUpperCase(),
                    style: Theme.of(context).textTheme.caption,
                  ),
            ),
        ],
      ),
    );
  }
}
