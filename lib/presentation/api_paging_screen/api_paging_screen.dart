/* Your Dart code here */
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_template/core/app_router.gr.dart';
import 'package:flutter_template/presentation/api_paging_screen/api_paging_screen_vm.dart';
import 'package:flutter_template/util/logger.dart';
import 'package:shimmer/shimmer.dart';

class ApiPagingScreen extends ConsumerWidget {
  const ApiPagingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(apiPagingScreenVmProvider.notifier);
    final logger = ref.read(loggerProvider);
    final pagingData = ref
        .watch(apiPagingScreenVmProvider.select((value) => value.newsArticles));
    return Scaffold(
        appBar: AppBar(
          title: const Text("Api Paging Screen"),
        ),
        body: ListView.builder(
          itemCount: pagingData.length + 1,
          itemBuilder: (context, index) {
            return (index == pagingData.length)
                ? const ApiPagingScreenShimmer()
                : ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          10.0), // Adjust the corner radius as needed
                      child: Image.network(
                        pagingData[index].urlToImage,
                        width:
                            50.0, // Set the desired width and height for the square image
                        height: 50.0,
                        fit: BoxFit.cover, // Apply BoxFit.cover for scaling
                      ),
                    ),
                    title: Text(pagingData[index].title),
                    subtitle: Text(pagingData[index].description),
                    onTap: () {
                      // Handle tile tap here.
                    },
                  );
          },
        ));
  }
}

class ApiPagingScreenShimmer extends StatelessWidget {
  const ApiPagingScreenShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        enabled: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            for (int i = 0; i < 20; i++)
              const ContentPlaceholder(
                lineType: ContentLineType.threeLines,
              ),
          ],
        ));
  }
}

class BannerPlaceholder extends StatelessWidget {
  const BannerPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200.0,
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: Colors.white,
      ),
    );
  }
}

class TitlePlaceholder extends StatelessWidget {
  final double width;

  const TitlePlaceholder({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width,
            height: 12.0,
            color: Colors.white,
          ),
          const SizedBox(height: 8.0),
          Container(
            width: width,
            height: 12.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

enum ContentLineType {
  twoLines,
  threeLines,
}

class ContentPlaceholder extends StatelessWidget {
  final ContentLineType lineType;

  const ContentPlaceholder({
    Key? key,
    required this.lineType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 50.0,
            height: 50.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 10.0,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 8.0),
                ),
                if (lineType == ContentLineType.threeLines)
                  Container(
                    width: double.infinity,
                    height: 10.0,
                    color: Colors.white,
                    margin: const EdgeInsets.only(bottom: 8.0),
                  ),
                Container(
                  width: 100.0,
                  height: 10.0,
                  color: Colors.white,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
