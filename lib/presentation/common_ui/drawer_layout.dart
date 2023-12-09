import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_template/core/app_router.gr.dart';
import 'package:flutter_template/core/global_db.dart';
import 'package:flutter_template/presentation/common_ui/tree_list_element.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerLayout extends ConsumerWidget {
  const DrawerLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final listOfTasks = ref.watch(globalDbProvider);
    return Drawer(
      child: ListView.builder(
          itemCount: listOfTasks.length + 2,
          itemBuilder: (BuildContext ctx, int idx) {
            if (idx == 0) {
              return DrawerHeader(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.pink, Color(0xFF4D4C61)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: EdgeInsets.zero,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Hi Shashank!",
                              style: GoogleFonts.robotoCondensed(
                                  fontSize: 18.0, fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    Image.asset("assets/reward_png.png"),
                  ],
                ),
              );
            } else if (idx == 1) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
                child: FloatingActionButton.extended(
                  onPressed: () {
                    AutoRouter.of(context).push(SecondRoute());
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
            return TreeListElement(
                title: listOfTasks[idx - 2].title,
                progress: listOfTasks[idx - 2].progress,
                stage: 6);
          }),
    );
  }
}
