import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/presentation/common_ui/tree_list_element.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerLayout extends ConsumerWidget {
  const DrawerLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.builder(itemBuilder: (BuildContext ctx, int idx) {
          if (idx == 0) {
            return const DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/india-gate.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: null, // You can add additional content if needed
            );
          } else if (idx == 1) {
            return Padding(
              padding: const EdgeInsets.all(4.0),
              child: FloatingActionButton.extended(
                onPressed: () {
                  // Handle the button press
                  print('Add New Goal pressed');
                },
                icon: const Icon(Icons.add),
                label: Text(
                  'Add New Goal',
                  style: GoogleFonts.robotoCondensed(
                      fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
              ),
            );
          }
          return const TreeListElement(
              title: "Element", progress: 12, stage: 6);
        }),
      ),
    );
  }
}
