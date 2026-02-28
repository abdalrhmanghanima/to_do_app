import 'package:flutter/material.dart';
import 'package:to_do_app/core/routing/app_routes.dart';
import 'package:to_do_app/core/utils/app_colors.dart';

class DeleteTodoBottomSheet extends StatelessWidget {
  final VoidCallback onDelete;

  const DeleteTodoBottomSheet({super.key, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: GestureDetector(
                onTap: () async {
                  onDelete();
                  Navigator.pop(context);
                },
                child: const Text(
                  "Delete TODO",
                  style: TextStyle(
                    color: AppColors.pink,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 18),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: AppColors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
