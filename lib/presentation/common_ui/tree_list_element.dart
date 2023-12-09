import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

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
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Colors.blueGrey, width: 1.0),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        leading: Icon(Icons.abc),
        title: Text(
          title,
          style: GoogleFonts.robotoCondensed(
              fontSize: 18.0, fontWeight: FontWeight.w500),
        ),
        subtitle: LinearProgressIndicator(value: progress * 0.01),
      ),
    );
  }
}
