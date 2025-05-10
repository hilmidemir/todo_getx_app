import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_getx_app/app/modules/home/home_controller.dart';
import 'package:todo_getx_app/core/responsive_constants.dart';

class TagSelectorWidget extends StatelessWidget {
  const TagSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Dropdown (Etiket seçimi)
        Obx(() => DropdownButton<String>(
              value: controller.selectedTag.value,
              onChanged: (value) {
                if (value != null) {
                  controller.selectedTag.value = value;
                }
              },
              items: ['Work', 'Personal', 'Shopping'].map((label) {
                return DropdownMenuItem(
                  value: label,
                  child: Text(label, style: TextStyle(fontSize: AppSizes.fontM)),
                );
              }).toList(),
            )),

        SizedBox(height: AppSizes.spacingM),

        // Renk Seçimi
        Obx(() => Row(
              children: [
                _colorDot(Colors.blue, controller),
                _colorDot(Colors.green, controller),
                _colorDot(Colors.orange, controller),
                _colorDot(Colors.red, controller),
              ],
            )),
      ],
    );
  }

  Widget _colorDot(Color color, HomeController controller) {
    return GestureDetector(
      onTap: () => controller.selectedColorValue.value = color.value,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: AppSizes.paddingXS),
        width: AppSizes.paddingL,
        height: AppSizes.paddingL,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(
            color: controller.selectedColorValue.value == color.value ? Colors.black : Colors.transparent,
            width: AppSizes.paddingXXS,
          ),
        ),
      ),
    );
  }
}
