import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:xbridge/common/constants/app_colors.dart';
import 'package:xbridge/common/constants/app_image.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/common/routes/route_config.dart';
import 'package:xbridge/common/theme/styles.dart';
import 'package:xbridge/common/utils/context_extension.dart';
import 'package:xbridge/common/widgets/loader.dart';
import 'package:xbridge/work_note/controller/work_note_block.dart';
import 'package:xbridge/work_note/controller/work_note_event.dart';
import 'package:xbridge/work_note/controller/work_note_state.dart';
import 'package:xbridge/work_note/presentation/screen/work_notes.dart';

import '../../../common/utils/util.dart';
import '../../../main.dart';

class FEWorkNotesState extends State<FEWorkNotes> {
  int selectedButtonIndex = 1; // Index of the currently selected button
  final TextEditingController _controller =
      TextEditingController(); // Controller for the text field
  bool isLoading = false; // Flag to indicate if data is being loaded
  String imagePayload = ''; // Base64 encoded image string
  String filePath = ""; // File path of the selected image

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: getInitUI());
  }

  // Initial UI setup with BLoC consumer
  Widget getInitUI() {
    return BlocConsumer<WorkNotesBlock, WorkNoteState>(
      listener: (_, state) async {
        // Listen for different states and handle UI changes
        if (state is WorkNoteLoadingState) {
          setState(() {
            isLoading = true;
          });
        } else if (state is WorkNoteLoadedState) {
          setState(() {
            isLoading = false;
            imagePayload = "";
            filePath = "";
          });
          context.showSuccess(msg: "Work Note Added Successfully");
          await Future.delayed(const Duration(seconds: 1));
          AppRouter.router.pop();
        } else if (state is WorkNoteErrorState) {
          setState(() {
            isLoading = false;
          });
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            vertical: 10.h,
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Display task ID
                Container(
                  decoration: primaryCardDecoration(),
                  child: Padding(
                    padding: EdgeInsets.all(15.0.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Task ID:',
                              style: Styles.textStyledarkBlack14dpRegular,
                            ),
                            8.0.horizontalSpace,
                            Text(
                              widget.model.number ?? "",
                              style: Styles.textStyledarkBlack14dpBold,
                            ),
                          ],
                        ),
                        7.verticalSpace,
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                // Text field for summary input
                Container(
                  decoration: secondaryWidgetDecoration(),
                  child: TextFormField(
                    controller: _controller,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    maxLines: 5,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.r),
                        borderSide: const BorderSide(color: Colors.transparent),
                      ),
                      contentPadding: EdgeInsets.all(20.0.h),
                      isDense: true,
                      prefixIconConstraints:
                          const BoxConstraints(minWidth: 0, minHeight: 0),
                      alignLabelWithHint: false,
                      filled: true,
                      fillColor: AppColors.white,
                      hintText: "Enter Your Summary",
                      hintStyle: TextStyle(
                        fontSize: 20.0,
                        color: Colors.grey.shade300,
                      ),
                    ),
                  ),
                ),
                30.verticalSpace,
                // Display selected image if available
                if (imagePayload.isNotEmpty)
                  Image.file(
                    File(filePath),
                    fit: BoxFit.contain,
                    width: 300.w,
                    height: 300.h,
                  ),
                if (isLoading)
                  const Loader(), // Show loader if data is being loaded
                // Submit button
                if (!isLoading)
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      backgroundColor: AppColors.red,
                    ),
                    onPressed: () {
                      // Add work note update event
                      if (_controller.text.isEmpty) {
                        context.showError(msg: "Please enter your summary");
                        return;
                      }
                      logger.i(firstName);
                      logger.i(lastName);
                      if (context.mounted) {
                        context.read<WorkNotesBlock>().add(
                              WorkNoteUpdateEvent(
                                id: widget.model.sysId ?? '',
                                data: {
                                  'u_vendor_comments':
                                      '$firstName $lastName has sent this Work Note from Xbridge Live:\n${_controller.text}',
                                },
                              ),
                            );
                        // Upload image if available
                        if (imagePayload.isNotEmpty) {
                          final extension = filePath.split('/').last;
                          logger.i(extension);
                          logger.i(
                            "${firstName}_${lastName}_work_note_image.$extension",
                          );
                          context.read<WorkNotesBlock>().add(
                                UploadImageEvent(
                                  taskId: widget.model.sysId ?? '',
                                  image: imagePayload,
                                  imageName:
                                      "${firstName}_${lastName}_work_note_image.$extension",
                                ),
                              );
                        }
                        // Unfocus the current text field
                        FocusScopeNode currentFocus = FocusScope.of(context);
                        if (!currentFocus.hasPrimaryFocus) {
                          currentFocus.unfocus();
                        }
                        _controller.clear();
                      }
                    },
                    child: Text(
                      "SUBMIT",
                      style: Styles.textStyledarkWhite13dpRegular,
                    ),
                  ),
                30.verticalSpace,
                // Action buttons (pencil and camera)
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      buildTextButton(
                        () {},
                        1,
                        SvgPicture.asset(AppImage.pencilIcon),
                      ),
                      30.horizontalSpace,
                      buildTextButton(
                        () {
                          openCamera();
                        },
                        2,
                        SvgPicture.asset(AppImage.cameraIcon),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Decoration for secondary widgets
  BoxDecoration secondaryWidgetDecoration() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 0.5,
          blurRadius: 3,
          offset: const Offset(0, 1),
        ),
      ],
    );
  }

  // Decoration for primary card
  BoxDecoration primaryCardDecoration() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: AppColors.grey,
          offset: const Offset(
            0.5,
            0.5,
          ),
          blurRadius: 3.0,
          spreadRadius: 1.0,
        ),
        const BoxShadow(
          color: Colors.white,
          offset: Offset(0.0, 0.0),
          blurRadius: 0.0,
          spreadRadius: 0.0,
        ),
      ],
    );
  }

  // Build button widget with text and icon
  Widget buildTextButton(
    void Function()? onPressed,
    int buttonIndex,
    Widget child,
  ) {
    return GestureDetector(
      onTap: () {
        if (onPressed != null) {
          onPressed();
        }
        setState(() {
          selectedButtonIndex = buttonIndex;
        });
      },
      child: Container(
        width: 50.w,
        height: 50.h,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 1,
            color: AppColors.gray,
          ),
          color: selectedButtonIndex == buttonIndex
              ? AppColors.geryshade300
              : Colors.white,
        ),
        child: Center(
          child: child,
        ),
      ),
    );
  }

  // Function to open camera and pick an image
  void openCamera() async {
    try {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        Uint8List imageBytes = await pickedFile.readAsBytes();

        // Log the initial image size
        double initialSizeInKB = imageBytes.length / 1024;
        double initialSizeInMB = imageBytes.length / (1024 * 1024);
        logger.i(
          'Initial file size: ${initialSizeInKB.toStringAsFixed(2)} KB (${initialSizeInMB.toStringAsFixed(2)} MB)',
        );

        // Compress image if it exceeds 350KB
        if (imageBytes.length > 350 * 1024) {
          img.Image? image = img.decodeImage(imageBytes);
          if (image != null) {
            // Resize and compress the image
            img.Image resizedImage = img.copyResize(
              image,
              width: 800,
            ); // Resize with a max width of 800
            int quality = 85;
            List<int> compressedBytes = img.encodeJpg(
              resizedImage,
              quality: quality,
            ); // Adjust quality to compress

            // Ensure the compressed image is within the 350KB limit
            while (compressedBytes.length > 350 * 1024 && quality > 10) {
              quality -= 5;
              compressedBytes = img.encodeJpg(resizedImage, quality: quality);
            }

            imageBytes = Uint8List.fromList(compressedBytes);
          }
        }

        // Log the final image size
        double finalSizeInKB = imageBytes.length / 1024;
        double finalSizeInMB = imageBytes.length / (1024 * 1024);
        logger.i(
          'Final file size: ${finalSizeInKB.toStringAsFixed(2)} KB (${finalSizeInMB.toStringAsFixed(2)} MB)',
        );

        String base64Image = base64Encode(imageBytes);

        // Get the file extension
        String fileExtension = pickedFile.path.split('.').last.toLowerCase();
        String mimeType = getMimeType(fileExtension);

        logger.i("Picked file extension: $fileExtension");
        logger.f("Picked file MIME type: $mimeType");

        setState(() {
          filePath = pickedFile.path;
          imagePayload = base64Image;
        });
      }
    } catch (e) {
      logger.e(e);
    }
  }

  // Function to get MIME type based on file extension
  String getMimeType(String extension) {
    switch (extension) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'gif':
        return 'image/gif';
      case 'bmp':
        return 'image/bmp';
      case 'webp':
        return 'image/webp';
      default:
        return 'unknown';
    }
  }
}
