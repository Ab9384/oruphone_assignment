import 'package:assignment/utils/app_colors.dart';
import 'package:flutter/material.dart';

class FilterTile extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function onTap;
  const FilterTile(
      {super.key,
      required this.title,
      required this.isSelected,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 100,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: !isSelected
              ? AppColors.secondaryTextColor.withOpacity(0.4)
              : AppColors.backgroundColor,
        ),
        color: isSelected
            ? AppColors.secondaryTextColor.withOpacity(0.4)
            : AppColors.backgroundColor,
      ),
      child: TextButton(
        onPressed: () => onTap(),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
