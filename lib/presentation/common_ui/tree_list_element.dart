import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TreeListElement extends ConsumerWidget {
  const TreeListElement(
      {required this.title,
      required this.progress,
      required this.stage,
      super.key});
  final String title;
  final int progress;
  final int stage;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: ListTile(
        leading: Icon(Icons.abc),
        title: Text(title),
        subtitle: LinearProgressIndicator(value: progress / 10),
      ),
    );
  }
}
