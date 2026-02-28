import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:to_do_app/core/utils/app_colors.dart';

class TodoShimmer extends StatelessWidget {
  const TodoShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ListView.builder(
      itemCount: 6,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: size.height * 0.02),
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.pink,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.04,
                  vertical: size.height * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: size.height * 0.02,
                      width: size.width * 0.5,
                      color: Colors.white,
                    ),
                    SizedBox(height: size.height * 0.015),
                    Container(
                      height: size.height * 0.015,
                      width: double.infinity,
                      color: Colors.white,
                    ),
                    SizedBox(height: size.height * 0.01),
                    Container(
                      height: size.height * 0.015,
                      width: size.width * 0.7,
                      color: Colors.white,
                    ),
                    SizedBox(height: size.height * 0.02),
                    Container(
                      height: size.height * 0.015,
                      width: size.width * 0.3,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
