import 'package:dyte_uikit/dyte_uikit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xbridge/common/constants/app_colors.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/common/utils/context_extension.dart';
import 'package:xbridge/video_call/controller/video_call_bloc.dart';
import 'package:xbridge/video_call/presentation/widget/dyte_meeting_page.dart';

import '../../../common/theme/styles.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key, this.sysID});

  final String? sysID;

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  int userGrp = 0;
  String userRole = '';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoCallBloc, VideoCallState>(
      listener: (_, state) {
        if (state.participant != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) {
                final DyteUIKitInfo uiKitInfo = DyteUIKitInfo(
                  DyteMeetingInfoV2(
                    authToken: state.participant?.token ?? '',
                  ),
                );
                final uiKit = DyteUIKitBuilder.build(uiKitInfo: uiKitInfo);

                return DyteMeetingPage(
                  uiKitBuilder: uiKit,
                );
              },
            ),
          );
        } else if (state.message != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(state.message ?? ''),
              duration: const Duration(seconds: 2),
            ),
          );
        }
      },
      builder: (_, state) {
        return Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Select type of users you want to add into call.',
                  style: Styles.textStyledarkBlack13dpBold,
                ),
                20.verticalSpace,
                if (userType != UserType.agent)
                  _radioTile(
                    title: 'SD Agent',
                    value: 1,
                    groupValue: userGrp,
                    onChanged: (val) {},
                    onTap: () {
                      setState(() {
                        userGrp = 1;
                        userRole = 'SD Agent';
                      });
                    },
                  ),
                5.verticalSpace,
                userType == UserType.fe
                    ? _radioTile(
                        title: 'Manager',
                        value: 2,
                        groupValue: userGrp,
                        onChanged: (val) {},
                        onTap: () {
                          setState(() {
                            userGrp = 2;
                            userRole = 'Manager;Field Engineer';
                          });
                        },
                      )
                    : _radioTile(
                        title: 'Field Engineer',
                        value: 2,
                        groupValue: userGrp,
                        onChanged: (val) {},
                        onTap: () {
                          setState(() {
                            userGrp = 2;
                            userRole = 'Manager;Field Engineer';
                          });
                        },
                      ),
                5.verticalSpace,
                _radioTile(
                  title: 'Client',
                  value: 3,
                  groupValue: userGrp,
                  onChanged: (val) {},
                  onTap: () {
                    setState(() {
                      userGrp = 3;
                      userRole = 'Client;SD Agent';
                    });
                  },
                ),
                20.verticalSpace,
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    backgroundColor: AppColors.red,
                  ),
                  onPressed: state.isLoading
                      ? null
                      : () {
                          if (userRole.isEmpty) {
                            context.showError(
                              msg: 'Please select at least one type of user.',
                            );
                            return;
                          }
                          context.read<VideoCallBloc>().add(
                                CreateMeetingVideoCallEvent(
                                  sysID: widget.sysID,
                                  userRole: userRole,
                                  name: userGrp == 1
                                      ? "SD Agent"
                                      : userGrp == 2
                                          ? userType == UserType.fe
                                              ? "Manager"
                                              : "Field Engineer"
                                          : "Client",
                                ),
                              );
                        },
                  child: state.isLoading
                      ? Container(
                          height: 40.h,
                          width: 40.w,
                          padding: const EdgeInsets.all(10),
                          child: CircularProgressIndicator(color: AppColors.white),
                        )
                      : Text(
                          'Join Now',
                          style: Styles.textStyledarkWhite13dpRegular,
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _radioTile({
    required String title,
    required int value,
    required int groupValue,
    Function(int?)? onChanged,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          AbsorbPointer(
            child: SizedBox(
              height: 25.h,
              width: 25.h,
              child: Radio(
                value: value,
                onChanged: onChanged,
                activeColor: AppColors.red,
                groupValue: groupValue,
              ),
            ),
          ),
          5.horizontalSpace,
          Text(
            title,
            style: Styles.textStyleDark12dpBold,
          ),
        ],
      ),
    );
  }
}
