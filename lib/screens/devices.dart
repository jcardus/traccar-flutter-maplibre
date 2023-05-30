import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/devices.dart';

class Devices extends StatelessWidget {
  const Devices({super.key});

  @override
  Widget build(BuildContext context) {
    var devices = context.watch<DevicesModel>();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(AppLocalizations.of(context)!.deviceTitle)
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                    (context, index) => _ListItem(index),
            childCount: devices.items.length
          )),
        ],
      ),
    );
  }
}

class _ListItem extends StatelessWidget {
  final int index;

  const _ListItem(this.index);

  @override
  Widget build(BuildContext context) {
    var item = context.select<DevicesModel, Device>(
          (catalog) => catalog.getById(index),
    );
    var textTheme = Theme.of(context).textTheme.titleLarge;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1/5,
              child: Container(
                color: item.color,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(item.name, style: textTheme),
            ),
            const SizedBox(width: 24),
          ],
        ),
      ),
    );
  }
}
