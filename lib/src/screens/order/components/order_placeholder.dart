import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardOrderPlaceholder extends StatelessWidget {
  const CardOrderPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 8, left: 8, right: 8),
      width: size.width,
      child: Card(
        elevation: 8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade100,
                  enabled: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: size.width / 1.5,
                          height: 12.0,
                          color: Colors.white,
                        ),
                        const SizedBox(height: 8.0),
                        Container(
                          width: size.width / 1.5,
                          height: 12.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey.shade300,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: size.width,
                                  height: 12.0,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 8.0),
                                Container(
                                  width: size.width,
                                  height: 12.0,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 8.0),
                                Container(
                                  width: size.width,
                                  height: 12.0,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 8.0),
                                Container(
                                  width: size.width,
                                  height: 12.0,
                                  color: Colors.white,
                                ),
                                const SizedBox(height: 8.0),
                                Container(
                                  width: size.width,
                                  height: 12.0,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      enabled: true,
                      child: Container(
                        width: 50,
                        height: 50,
                        margin: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
