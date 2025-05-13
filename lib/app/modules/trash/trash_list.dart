import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:todo_getx_app/app/modules/home/home_controller.dart';
import 'package:todo_getx_app/app/modules/trash/trash_tile.dart';
import 'package:todo_getx_app/app/core/responsive_constants.dart';

class TrashListWidget extends StatelessWidget {
  const TrashListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();

    return Obx(() {
      final deleted = homeController.deletedTasks;
      if (deleted.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.only(top: AppSizes.spacingL),
            child: Text(
              'Trash is empty',
              style: TextStyle(
                fontSize: AppSizes.fontM,
              ),
            ),
          ),
        );
      }
      return ListView.builder(
        itemCount: deleted.length,
        itemBuilder: (context, index) {
          final task = deleted[index];
          return TrashTile(task: task, index: index);
        },
      );
    });
  }
}
