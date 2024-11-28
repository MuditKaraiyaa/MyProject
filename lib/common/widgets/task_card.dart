// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xbridge/common/constants/app_colors.dart';
import 'package:xbridge/common/constants/app_image.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/common/theme/styles.dart';

import '../../unassigned_visits/data/model/unassigned_task_entity.dart';
import '../utils/util.dart';

class TaskCard extends StatelessWidget {
  final bool isButtonVisible;
  final UnassignedTaskResult? model;
  final void Function()? onCardPress;
  final void Function()? onAcceptButtonPress;
  final void Function()? onRejectButtonPress;
  final VoidCallback? onLongPress;

  const TaskCard({
    Key? key,
    this.model,
    this.onCardPress,
    this.onAcceptButtonPress,
    this.onRejectButtonPress,
    this.onLongPress,
    required this.isButtonVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardPress,
      onLongPress: onLongPress,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.only(
              left: 10.w,
              right: 10.w,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // getSpacer(5),
                Padding(
                  padding: EdgeInsets.only(top: 10.0.h),
                  child: Text(
                    '${model?.parent?.displayValue ?? ''} - ${model?.number}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Divider(
                  color: AppColors.borderColor,
                  indent: 0.0,
                  endIndent: 0.0,
                ),
                Text(
                  'Description: ',
                  style: Styles.textStyledarkBlack11dpBold,
                ),
                getSpacer(5),
                Text(
                  (model?.shortDescription?.isEmpty ?? false)
                      ? ''
                      : (model?.shortDescription ?? ''),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Styles.textStyledarkBlackDescription12dpRegular,
                ),

                getSpacer(15),

                Row(
                  children: [
                    if (model!.uPreferredScheduleByCustomerSystem != null &&
                        model!.uPreferredScheduleByCustomerSystem!
                            .isNotEmpty) ...[
                      Flexible(
                        child: Row(
                          children: [
                            Image(
                              image: const AssetImage(AppImage.iconAddress),
                              width: 11.w,
                              height: 16.h,
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Flexible(
                              child: Text(
                                model!.uCity == null || model?.uCity == ""
                                    ? ''
                                    : "${model?.uCity ?? ''}, ${model?.uCountry ?? ''}",
                                style: Styles.textStyledarkBlack12dpBold,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ] else if (model!.uCity != null &&
                        model!.uCity!.isNotEmpty) ...[
                      Flexible(
                        child: Row(
                          children: [
                            Image(
                              image: const AssetImage(AppImage.iconAddress),
                              width: 11.w,
                              height: 16.h,
                            ),
                            SizedBox(
                              width: 2.4.w,
                            ),
                            Flexible(
                              child: Text(
                                model!.uCity == null || model?.uCity == ""
                                    ? ''
                                    : "${model?.uCity ?? ''}, ${model?.uCountry ?? ''}",
                                style: Styles.textStyledarkBlack12dpBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                    if (model?.uPreferredScheduleByCustomer != null &&
                        model!.uPreferredScheduleByCustomer!.isNotEmpty)
                      Flexible(
                        child: Row(
                          children: [
                            Image(
                              image:
                                  const AssetImage(AppImage.iconTaskDateTime),
                              width: 15.w,
                              height: 15.h,
                            ),
                            SizedBox(
                              width: 2.4.w,
                            ),
                            Flexible(
                              child: Text(
                                getLocalTime(
                                  date:
                                      model?.uPreferredScheduleByCustomer ?? '',
                                ),
                                style: Styles.textStyledarkBlack12dpBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    Row(
                      children: [
                        Image(
                          image: AssetImage(
                            (model?.state?.toLowerCase() == 'resolved' ||
                                    model?.state?.toLowerCase() == 'closed')
                                ? AppImage.iconTaskStatus
                                : AppImage.icTaskUncheck,
                          ),
                          width: 15.w,
                          height: 15.h,
                        ),
                        SizedBox(
                          width: 2.4.w,
                        ),
                        Text(
                          model?.state ?? '',
                          style: Styles.textStyledarkBlack12dpBold,
                          softWrap: true,
                        ),
                      ],
                    ),
                  ],
                ),
                if ((model!.uPreferredScheduleByCustomerSystem != null &&
                        model!
                            .uPreferredScheduleByCustomerSystem!.isNotEmpty) &&
                    model!.uCity != null &&
                    model!.uCity!.isNotEmpty) ...[
                  getSpacer(5),
                ],
                if (isButtonVisible) getSpacer(12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (isButtonVisible)
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0.r),
                            ),
                          ),
                          elevation: MaterialStateProperty.all(
                            5.0,
                          ), // Adjust the elevation value as needed
                          shadowColor: MaterialStateProperty.all(
                            Colors.black.withOpacity(
                              0.8,
                            ),
                          ), // Adjust the shadow color as needed
                        ),
                        onPressed: onAcceptButtonPress,
                        child: Text(
                          'Accept',
                          style: TextStyle(color: AppColors.feGreenButton),
                        ),
                      ),
                    SizedBox(
                      width: 30.w,
                    ),
                    if (isButtonVisible)
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0.r),
                            ),
                          ),
                          elevation: MaterialStateProperty.all(
                            5.0,
                          ), // Adjust the elevation value as needed
                          shadowColor: MaterialStateProperty.all(
                            Colors.black.withOpacity(
                              0.8,
                            ),
                          ), // Adjust the shadow color as needed
                        ),
                        onPressed: onRejectButtonPress,
                        child: Text(
                          'Reject',
                          style: TextStyle(color: AppColors.red),
                        ),
                      ),
                  ],
                ),

                getSpacer(12),

                /*
                Container(
                  decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(10)),
                    //  color: Colors.grey,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Text(
                            'Priority: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(
                            taskProirity,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            'Description: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(taskDescription),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            'Scheduled Date: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(taskScheduleedDate.toString()),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            'State: ',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(taskState),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Text(
                            'Address:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(taskAddress),
                        ],
                      ),
                    ],
                  ),
                ),*/
              ],
            ),
          ),
          model?.uCasePriority != null
              ? Positioned(
                  right: 25.w,
                  child: Container(
                    width: 31.w,
                    height: 20.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.red,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5.r),
                        bottomRight: Radius.circular(5.r),
                      ),
                    ),
                    child: Text(
                      model?.uCasePriority ?? '',
                      style: Styles.textStyleLightPriority12dpBold,
                    ),
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
