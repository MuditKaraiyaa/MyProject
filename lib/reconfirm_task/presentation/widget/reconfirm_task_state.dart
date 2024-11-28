// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:xbridge/common/constants/app_colors.dart';
import 'package:xbridge/common/routes/route_config.dart';
import 'package:xbridge/common/utils/util.dart';
import 'package:xbridge/reconfirm_task/controller/reconfirm_task_bloc.dart';

import '../../../common/constants/app_image.dart';
import '../../../common/constants/globals.dart';
import '../../../common/theme/styles.dart';
import '../screen/reconfirm_task.dart';

class ReConfirmTaskState extends State<ReConfirmTask> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ReconfirmTaskBloc, ReconfirmTaskState>(
      listener: (context, state) {
        if (state is ReconfirmTaskSuccess) {
          showLoading(value: false);
          AppRouter.router.pop();
          Fluttertoast.showToast(
            msg: state.isDecline
                ? "You have decline the availability for the ${widget.data["task_number"]} task!"
                : "Your Availability has been confirmed!",
          );
        } else if (state is ReconfirmTaskLoading) {
          showLoading(value: true);
        } else if (state is ReconfirmTaskError) {
          showLoading(value: false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: const BackButton(color: Colors.white),
          title: Text(
            "Re-Confirmation",
            style: Styles.textStyledarkWhite18dpRegular,
          ),
          automaticallyImplyLeading: true,
          elevation: 0,
          backgroundColor: AppColors.red,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 16.w),
              child: Image.asset(
                AppImage.dashboardLogoRectangle,
                width: 67.w,
                height: 16.h,
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                offset: Offset(0, 1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
            color: AppColors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: 20,
          ),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: AppColors.primaryButtonBackgroundColor,
                      ),
                    ),
                  ),
                  onPressed: onDeclinePress,
                  child: Text(
                    "Not-Available",
                    style: Styles.textStyledarkBlack11dpBold.copyWith(
                      color: AppColors.primaryButtonBackgroundColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: AppColors.primaryButtonBackgroundColor,
                  ),
                  onPressed: onAcceptPress,
                  child: Text(
                    "Available",
                    style: Styles.textStyledarkBlack11dpBold.copyWith(
                      color: AppColors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Text(
                "Please confirm your availability for this visit.",
                textAlign: TextAlign.center,
                style: Styles.textStyledarkBlack11dpBold.copyWith(
                  color: AppColors.black,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 8),
              CustomListTile(
                title: "Date: ",
                result: "${widget.data["date"]}",
              ),
              const SizedBox(height: 8),
              CustomListTile(
                title: "Time: ",
                result: "${widget.data["time"]}",
              ),
              const SizedBox(height: 8),
              CustomListTile(
                title: "Address: ",
                result: "${widget.data["address"]}",
              ),
              const SizedBox(height: 8),
              CustomListTile(
                title: "Task Number: ",
                result: "${widget.data["task_number"]}",
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onAcceptPress() {
    context.read<ReconfirmTaskBloc>().add(
          AvailableEvent(
            sysId: widget.data['sys_id'],
            isDecline: false,
            data: {
              'u_field_engineer_accepted': 'true',
              'u_vendor_comments':
                  "$firstName $lastName has confirmed availability for this task ${widget.data["task_number"]} on ${DateFormat('dd MM yyyy, hh:mm a').format(DateTime.now())}",
              // '$firstName $lastName has accepted the task on XBridge Live',
            },
          ),
        );
  }

  void onDeclinePress() {
    Navigator.of(context).pop();
    // context.read<ReconfirmTaskBloc>().add(
    //       AvailableEvent(
    //         sysId: widget.data['sys_id'],
    //         isDecline: true,
    //         data: {
    //           // trying true for get this task in accepted list.
    //           'u_field_engineer_accepted': 'true',
    //           'u_vendor_comments':
    //               "$firstName $lastName has declined availability for this task ${widget.data["task_number"]} on ${DateFormat('dd MM yyyy, hh:mm a').format(DateTime.now())}",
    //           // '$firstName $lastName has accepted the task on XBridge Live',
    //         },
    //       ),
    //     );
  }
}

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.title,
    required this.result,
  }) : super(key: key);
  final String title;
  final String result;
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Styles.textStyledarkBlack10dpRegular.copyWith(
            color: AppColors.black,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        15.horizontalSpace,
        Expanded(
          child: Text(
            result,
            textAlign: TextAlign.right,
            style: Styles.textStyledarkBlack10dpRegular.copyWith(
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}
