import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';
import 'package:xbridge/common/constants/api_constant.dart';
import 'package:xbridge/common/constants/app_colors.dart';
import 'package:xbridge/common/constants/globals.dart';
import 'package:xbridge/common/network/api_provider.dart';
import 'package:xbridge/common/theme/styles.dart';
import 'package:xbridge/common/utils/context_extension.dart';
import 'package:xbridge/service_call_report/data/model/csr_model.dart';
import 'package:xbridge/service_call_report/presentation/screen/service_call.dart';
import 'package:xbridge/service_call_report/presentation/widgets/csr_pdf_generator.dart';
import 'package:xbridge/task_details/data/models/case_detail_entity.dart';

import '../../../common/constants/app_image.dart';
import '../../../common/utils/util.dart';
import '../../../main.dart';
import '../../controller/service_call_report_block.dart';
import '../../controller/service_call_report_event.dart';
import '../../controller/service_call_report_state.dart';

enum SingingCharacter { pendingCustomer, additionalVisitRequired, closed }

class ServiceCallState extends State<ServiceCall> {
  String? fileName;
  PlatformFile? pickedFile;
  bool isLoading = false;
  int selectedButtonIndex = 1;
  int? missionStatusGrp = 1;
  int? customerReviewGrp = 1;
  bool isPopedProDetails = false;
  bool isPopedDefectiveParts = false;
  bool isPopedUsedParts = false;
  late SignatureController _customerSignController;
  late SignatureController _technicianSignController;

  CSRModel csrModel = CSRModel(
    brandTEC: TextEditingController(),
    modelTEC: TextEditingController(),
    typeTEC: TextEditingController(),
    sNumberTEC: TextEditingController(),
    descTEC: TextEditingController(),
    defectRefTEC: TextEditingController(),
    defectPartTEC: TextEditingController(),
    defectSNumberTEC: TextEditingController(),
    defectTagTEC: TextEditingController(),
    replaceRefTEC: TextEditingController(),
    replacePartTEC: TextEditingController(),
    replaceSNumberTEC: TextEditingController(),
    replaceTagTEC: TextEditingController(),
    nameTEC: TextEditingController(),
    emailTEC: TextEditingController(),
    commentTEC: TextEditingController(),
    techNameTEC: TextEditingController(),
    resolutionNoteTEC: TextEditingController(),
    missionStatus: 'Resolved',
    customerSatisfy: 'Yes',
    techName: "$firstName $lastName",
    cstRefID: '',
    departureTime: DateTime.now().toUtc().toString(),
  );

  @override
  void initState() {
    logger.i(widget.model.uDepartureTime);
    logger.w(widget.model.workStart);
    logger.i(widget.model.workEnd);
    _customerSignController = SignatureController(
      penStrokeWidth: 4,
      penColor: AppColors.black,
      exportBackgroundColor: AppColors.white,
    );
    _technicianSignController = SignatureController(
      penStrokeWidth: 4,
      penColor: AppColors.black,
      exportBackgroundColor: AppColors.white,
    );
    if (widget.model.sysId != null) {
      setModelData();
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setTime();
    });
    super.initState();
  }

  void setTime() async {
    final response = await GetIt.I
        .get<APIProvider>()
        .getMethod(APIConstant.caseDetail + widget.model.sysId!);

    if (response != null) {
      final contact = response['result']['task']['caseRecord']['account'];
      final res = CaseDetailEntity.fromJson(response);
      setState(() {
        csrModel.startTime = res.result!.task!.uTravelStartTime;
        csrModel.arrivalTime = res.result!.task!.uArrivalTime;
        csrModel.travelTime = res.result!.task!.uTravelStartTime;
        csrModel.workStartTime = res.result!.task!.uWorkStarted;
        csrModel.workEndTime = res.result!.task!.uWorkCompleted;
        csrModel.departureTime = res.result!.task!.uDepartureTime;
        csrModel.account = contact;
        csrModel.techName = "$firstName $lastName";
        csrModel.cstRefID =
            "${widget.model.uDispatchOtNumber != null ? "${widget.model.uDispatchOtNumber!.split("_").first} - " : ""}${widget.model.taskEffectiveNumber}";
      });
    }
  }

  @override
  void dispose() {
    _customerSignController.dispose();
    _technicianSignController.dispose();
    super.dispose();
  }

  void setModelData() {
    setState(() {
      csrModel.shortDescription = widget.model.shortDescription;

      csrModel.cstContactID = widget.contractID;

      csrModel.street = widget.street;
      csrModel.country = widget.country;
      csrModel.city = widget.city;

      csrModel.taskNumber = widget.taskNumber;

      csrModel.scheduledDate = widget.scheduledDate;
      csrModel.departureTime = widget.departureTime;
    });
  }

  void _handleClearButtonPressed({bool isCustomer = true}) {
    if (isCustomer) {
      _customerSignController.clear();
      csrModel.customerSign = null;
    } else {
      _technicianSignController.clear();
      csrModel.technicianSign = null;
    }
    setState(() {});
  }

  void _handleSaveButtonPressed({bool isCustomer = true}) async {
    if (isCustomer) {
      csrModel.customerSign = await _customerSignController.toPngBytes();
    } else {
      csrModel.technicianSign = await _technicianSignController.toPngBytes();
    }
    setState(() {});
  }

  Future<void> pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc'],
        allowMultiple: false,
      );

      if (result != null) {
        fileName = result.files.first.name;
        pickedFile = result.files.first;
      }

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void changeProDetails(bool value) {
    setState(() {
      isPopedProDetails = value;
    });
  }

  void changeDefectiveParts(bool value) {
    setState(() {
      isPopedDefectiveParts = value;
    });
  }

  void changeUsedParts(bool value) {
    setState(() {
      isPopedUsedParts = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    logger.w(widget.model.uArrivalTime);
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: SafeArea(
        child: BlocConsumer<ServiceCallReportBlock, ServiceCallReportState>(
          listener: (_, state) {
            if (state is ServiceCallReportUploadedState &&
                (state.response?.payload != null)) {
              resetOnlineForm();
              GoRouter.of(context).pop();
              context.showSuccess(
                msg: 'You have successfully submitted the Service Call Report',
              );
            }
            if (state is ServiceCallReportErrorState) {
              context.showError(msg: state.message);
            }
          },
          builder: (context, state) {
            return Stack(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    color: Colors.grey.shade200,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            buildElevatedButton("Fill Online", () {}, 1),
                            20.horizontalSpace,
                            buildElevatedButton("Upload From", () {}, 2),
                          ],
                        ),
                        selectedButtonIndex == 1
                            ? Column(
                                children: [
                                  customerDetailsCard(),
                                  15.verticalSpace,
                                  travelDetailsCard(),
                                  15.verticalSpace,
                                  tileProductDetails(),
                                  15.verticalSpace,
                                  missionStatus(),
                                  15.verticalSpace,
                                  resolutionNotes(),
                                  redBox("Logistics"),
                                  tileDefectiveParts(),
                                  20.verticalSpace,
                                  tileUsedPart(),
                                  18.verticalSpace,
                                  radioButtonsCustomerReview(),
                                  redBox("Signature"),
                                  customerNameAddressSignCard(),
                                  technicianDetailsCard(),
                                  buildSizedBox10(),
                                  buttonsResetSubmit(),
                                  30.verticalSpace,
                                ],
                              )
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  boxFilePick(),
                                  15.verticalSpace,
                                  missionStatus(),
                                  15.verticalSpace,
                                  radioButtonsCustomerReview(),
                                  15.verticalSpace,
                                  buttonsResetSubmit(),
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
                if (state is ServiceCallReportLoadingState)
                  Container(
                    alignment: Alignment.center,
                    color: Colors.black12,
                    child: const CircularProgressIndicator(),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  ExpansionTile tileProductDetails() {
    return ExpansionTile(
      collapsedBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      childrenPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 26.w),
      tilePadding: EdgeInsets.symmetric(horizontal: 26.w),
      iconColor: Colors.grey,
      trailing: isPopedProDetails
          ? const Icon(Icons.expand_more)
          : const Icon(Icons.chevron_right),
      onExpansionChanged: changeProDetails,
      title: Text(
        'Product Details',
        style: Styles.textStyledarkBlack13dpBold.copyWith(
          color: AppColors.dark,
        ),
      ),
      children: <Widget>[
        _textFieldTile(
          title: 'Brand:',
          hint: 'Enter brand',
          controller: csrModel.brandTEC,
        ),
        _textFieldTile(
          title: 'Model:',
          hint: 'Enter model',
          controller: csrModel.modelTEC,
        ),
        _textFieldTile(
          title: 'Type:',
          hint: 'Enter type',
          controller: csrModel.typeTEC,
        ),
        _textFieldTile(
          title: 'Serial Number:',
          hint: 'Enter serial number',
          controller: csrModel.sNumberTEC,
        ),
        _textFieldTile(
          title: 'Description:',
          hint: 'Enter description',
          controller: csrModel.descTEC,
        ),
      ],
    );
  }

  Widget _textFieldTile({
    required String title,
    String? hint,
    TextEditingController? controller,
    Function(String)? onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: 100.w,
            child: Text(
              title,
              style: Styles.textStyleDark12dpBold.copyWith(
                color: AppColors.lightDark,
              ),
            ),
          ),
          SizedBox(width: 10.0.w),
          Expanded(
            child: Container(
              decoration: secondaryWidgetDecoration(),
              child: TextFormField(
                controller: controller,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  filled: true,
                  isDense: true,
                  fillColor: AppColors.white,
                  hintText: hint,
                  hintStyle: Styles.textStyleTextFieldPlaceHolder11dpRegular,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                ),
                onChanged: onChanged,
              ),
            ),
          ),
        ],
      ),
    );
  }

  ExpansionTile tileDefectiveParts() {
    return ExpansionTile(
      collapsedBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      childrenPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 26.w),
      tilePadding: EdgeInsets.symmetric(horizontal: 26.w),
      textColor: Colors.black,
      iconColor: Colors.grey,
      trailing: isPopedDefectiveParts
          ? const Icon(Icons.expand_more)
          : const Icon(Icons.chevron_right),
      onExpansionChanged: changeDefectiveParts,
      title: Text(
        'Defective Parts',
        style: Styles.textStyledarkBlack13dpBold.copyWith(
          color: AppColors.dark,
        ),
      ),
      children: <Widget>[
        _textFieldTile(
          title: 'Reference:',
          hint: 'Enter reference',
          controller: csrModel.defectRefTEC,
        ),
        _textFieldTile(
          title: 'Part Number:',
          hint: 'Enter part number',
          controller: csrModel.defectPartTEC,
        ),
        _textFieldTile(
          title: 'Serial Number:',
          hint: 'Enter serial number',
          controller: csrModel.defectSNumberTEC,
        ),
        _textFieldTile(
          title: 'Tag ID:',
          hint: 'Enter tag ID',
          controller: csrModel.defectTagTEC,
        ),
      ],
    );
  }

  ExpansionTile tileUsedPart() {
    return ExpansionTile(
      collapsedBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      childrenPadding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 26.w),
      tilePadding: EdgeInsets.symmetric(horizontal: 26.w),
      textColor: Colors.black,
      iconColor: Colors.grey,
      trailing: isPopedUsedParts
          ? const Icon(Icons.expand_more)
          : const Icon(Icons.chevron_right),
      onExpansionChanged: changeUsedParts,
      title: Text(
        'Part used for Replacement',
        style: Styles.textStyledarkBlack13dpBold.copyWith(
          color: AppColors.dark,
        ),
      ),
      children: <Widget>[
        _textFieldTile(
          title: 'Reference:',
          hint: 'Enter reference',
          controller: csrModel.replaceRefTEC,
        ),
        _textFieldTile(
          title: 'Part Number:',
          hint: 'Enter part number',
          controller: csrModel.replacePartTEC,
        ),
        _textFieldTile(
          title: 'Serial Number:',
          hint: 'Enter serial number',
          controller: csrModel.replaceSNumberTEC,
        ),
        _textFieldTile(
          title: 'Tag ID:',
          hint: 'Enter tag ID',
          controller: csrModel.replaceTagTEC,
        ),
      ],
    );
  }

  SizedBox buildSizedBox10() {
    return SizedBox(
      height: 10.h,
    );
  }

  Widget _radioTile({
    required String title,
    required int value,
    required int? groupValue,
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
                groupValue: groupValue,
                onChanged: onChanged,
                activeColor: AppColors.red,
              ),
            ),
          ),
          5.horizontalSpace,
          Text(
            title,
            style: Styles.textStyleDark12dpBold.copyWith(),
          ),
        ],
      ),
    );
  }

  Widget missionStatus() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 26.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Mission Status",
            style: Styles.textStyledarkBlack13dpBold.copyWith(
              color: AppColors.dark,
            ),
          ),
          8.verticalSpace,
          _radioTile(
            title: 'Resolved',
            value: 1,
            groupValue: missionStatusGrp,
            onChanged: (val) {
              csrModel.missionStatus = 'Resolved';
              missionStatusGrp = val;
              setState(() {});
            },
            onTap: () {
              csrModel.missionStatus = 'Resolved';
              missionStatusGrp = 1;
              setState(() {});
            },
          ),
          _radioTile(
            title: 'Additional Visit Required',
            value: 2,
            groupValue: missionStatusGrp,
            onChanged: (val) {
              csrModel.missionStatus = 'Additional Visit Required';
              missionStatusGrp = val;
              setState(() {});
            },
            onTap: () {
              csrModel.missionStatus = 'Additional Visit Required';
              missionStatusGrp = 2;
              setState(() {});
            },
          ),
          15.verticalSpace,
        ],
      ),
    );
  }

  Widget resolutionNotes() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 26.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Resolution Notes',
            style: Styles.textStyledarkBlack13dpBold.copyWith(
              color: AppColors.dark,
            ),
          ),
          8.verticalSpace,
          _textField(
            maxLine: 4,
            hint: 'Enter resolution notes',
            keyboard: TextInputType.multiline,
            controller: csrModel.resolutionNoteTEC,
          ),
          // 5.verticalSpace,
        ],
      ),
    );
  }

  Widget radioButtonsCustomerReview() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 26.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Is Customer Satisfied?",
            style: Styles.textStyledarkBlack13dpBold.copyWith(
              color: AppColors.dark,
            ),
          ),
          10.verticalSpace,
          Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  child: _radioTile(
                    title: 'Yes',
                    value: 1,
                    groupValue: customerReviewGrp,
                    onChanged: (val) {
                      csrModel.customerSatisfy = 'Yes';
                      customerReviewGrp = val;
                      setState(() {});
                    },
                    onTap: () {
                      csrModel.customerSatisfy = 'Yes';
                      customerReviewGrp = 1;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(
                  child: _radioTile(
                    title: 'No',
                    value: 2,
                    groupValue: customerReviewGrp,
                    onChanged: (val) {
                      csrModel.customerSatisfy = 'No';
                      customerReviewGrp = val;
                      setState(() {});
                    },
                    onTap: () {
                      csrModel.customerSatisfy = 'No';
                      customerReviewGrp = 2;
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(
                  child: _radioTile(
                    title: 'Not Shared',
                    value: 3,
                    groupValue: customerReviewGrp,
                    onChanged: (val) {
                      csrModel.customerSatisfy = 'Not Shared';
                      customerReviewGrp = val;
                      setState(() {});
                    },
                    onTap: () {
                      csrModel.customerSatisfy = 'Not Shared';
                      customerReviewGrp = 3;
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ElevatedButton buildElevatedButton(
    String txt,
    void Function()? onPressed,
    int buttonIndex,
  ) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        textStyle: selectedButtonIndex == buttonIndex
            ? Styles.textStyledarkBlack12dpBold
            : Styles.textStyledarkWhite10dpRegular,
        padding: EdgeInsets.only(left: 12.w, right: 12.w),
        foregroundColor: selectedButtonIndex == buttonIndex
            ? AppColors.white
            : AppColors.black,
        minimumSize: Size(90.w, 30.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.r)),
        ),
        backgroundColor: selectedButtonIndex == buttonIndex
            ? AppColors.selectedColorButtonBackground
            : AppColors.greyBackground,
      ),
      onPressed: () {
        setState(() {
          selectedButtonIndex = buttonIndex;
        });
        if (onPressed != null) {
          onPressed();
        }
      },
      child: Text(
        txt,
        style: selectedButtonIndex == buttonIndex
            ? Styles.textStyleLightPriority12dpBold
            : Styles.textStyledarkBlack12dpBold,
      ),
    );
  }

  Widget boxFilePick() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 26.w, vertical: 10.h),
          child: Text(
            'Upload form',
            style: Styles.textStyledarkBlack12dpBold,
          ),
        ),
        GestureDetector(
          onTap: () {
            pickFile();
          },
          child: Container(
            height: 150.h,
            width: double.maxFinite,
            decoration: BoxDecoration(
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
                BoxShadow(
                  color: AppColors.white,
                  offset: const Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ),
              ],
            ),
            child: Center(
              child: pickedFile != null
                  ? Text(fileName ?? '')
                  : Image.asset(AppImage.signatureCloud),
            ),
          ),
        ),
      ],
    );
  }

  Widget redBox(String tnt) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(221, 40, 39, 1),
              Color.fromRGBO(246, 52, 54, 1),
              Color.fromRGBO(138, 3, 7, 1),
            ],
            stops: [0.0, 0.5, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        // height: 50.h,
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Text(
          tnt,
          style: Styles.textStyleWhite14dpBold,
        ),
      ),
    );
  }

  Padding buttonsResetSubmit() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
              backgroundColor: AppColors.greyBackground,
            ),
            onPressed: () {
              if (selectedButtonIndex == 1) {
                resetOnlineForm();
              } else {
                resetUploadForm();
              }
            },
            child: Text(
              "RESET",
              style: Styles.textStyledarkBlack13dpRegular,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.r),
              ),
              backgroundColor: AppColors.red,
            ),
            onPressed: () async {
              widget.model.uDepartureTime = DateTime.now().toString();
              csrModel.departureTime = widget.model.uDepartureTime;
              logger.i(widget.model.uDepartureTime);
              if (selectedButtonIndex == 1) {
                onlineFormAction();
              } else {
                uploadFormAction();
              }
            },
            child: Text(
              "SUBMIT",
              style: Styles.textStyledarkWhite13dpRegular,
            ),
          ),
        ],
      ),
    );
  }

  void resetOnlineForm() {
    csrModel.brandTEC = TextEditingController();
    csrModel.modelTEC = TextEditingController();
    csrModel.typeTEC = TextEditingController();
    csrModel.sNumberTEC = TextEditingController();
    csrModel.descTEC = TextEditingController();
    csrModel.defectRefTEC = TextEditingController();
    csrModel.defectPartTEC = TextEditingController();
    csrModel.defectSNumberTEC = TextEditingController();
    csrModel.defectTagTEC = TextEditingController();
    csrModel.replaceRefTEC = TextEditingController();
    csrModel.replacePartTEC = TextEditingController();
    csrModel.replaceSNumberTEC = TextEditingController();
    csrModel.replaceTagTEC = TextEditingController();
    csrModel.nameTEC = TextEditingController();
    csrModel.emailTEC = TextEditingController();
    csrModel.commentTEC = TextEditingController();
    csrModel.techNameTEC = TextEditingController();
    csrModel.resolutionNoteTEC = TextEditingController();
    csrModel.missionStatus = 'Resolved';
    csrModel.customerSatisfy = 'Yes';
    missionStatusGrp = 1;
    customerReviewGrp = 1;
    csrModel.customerSign = null;
    csrModel.technicianSign = null;
    _customerSignController.clear();
    _technicianSignController.clear();
    setState(() {});
  }

  void resetUploadForm() {
    fileName = null;
    pickedFile = null;
    missionStatusGrp = 1;
    customerReviewGrp = 1;
    setState(() {});
  }

  void onlineFormAction() async {
    if (csrModel.resolutionNoteTEC?.text.isEmpty ?? false) {
      context.showError(msg: 'Please enter resolution note');
      return;
    }
    if (csrModel.nameTEC?.text.isEmpty ?? false) {
      context.showError(msg: 'Please enter customer name');
      return;
    }

    if (csrModel.emailTEC!.text.isNotEmpty &&
        !validateEmail(csrModel.emailTEC?.text ?? '')) {
      context.showError(msg: 'Please enter valid customer email');
      return;
    }
    if (csrModel.customerSign == null) {
      context.showError(msg: 'Please add a signature of customer');
      return;
    }
    if (csrModel.technicianSign == null) {
      context.showError(msg: 'Please add a signature of technician');
      return;
    }

    CSRPdfGeneration csrPdf = CSRPdfGeneration(
      model: csrModel,
      techName: "$firstName $lastName",
    );

    String base64 = await csrPdf.buildPDF();
    if (context.mounted) {
      context.read<ServiceCallReportBlock>().add(
            UploadServiceCallReportUpdateEvent(
              id: widget.model.sysId ?? '',
              data: {
                'u_resolution_notes': csrModel.resolutionNoteTEC?.text,
                'u_customer_satisfaction': customerReviewGrp == 1
                    ? 'Yes'
                    : customerReviewGrp == 2
                        ? 'No'
                        : 'Not Shared',
                'state': missionStatusGrp == 1
                    ? completeTaskStatus
                    : additionalVisitStatus,
                'u_departure_time': DateTime.now().toUtc().toString(),
              },
              pdf: base64,
              pdfName: '${firstName}_${lastName}_${widget.model.number}.pdf',
            ),
          );
    }

    // // Use below code to modify and view pdf.
    // GoRouter.of(context).pushNamed(
    //   RouteConstants.serviceCallReportPDF,
    //   extra: csrModel,
    // );
  }

  void uploadFormAction() async {
    if (pickedFile == null) {
      context.showError(msg: 'Please select document for upload.');
      return;
    }
    if (csrModel.resolutionNoteTEC?.text.isEmpty ?? false) {
      context.showError(msg: 'Please enter resolution note');
      return;
    }

    String base64 =
        base64Encode(File(pickedFile?.path ?? '').readAsBytesSync());

    context.read<ServiceCallReportBlock>().add(
          UploadServiceCallReportUpdateEvent(
            id: widget.model.sysId ?? '',
            data: {
              'u_resolution_notes': csrModel.resolutionNoteTEC?.text,
              'u_customer_satisfaction': customerReviewGrp == 1
                  ? 'Yes'
                  : customerReviewGrp == 2
                      ? 'No'
                      : 'Not Shared',
              'state': missionStatusGrp == 1
                  ? completeTaskStatus
                  : additionalVisitStatus,
              'u_departure_time': DateTime.now().toUtc().toString(),
            },
            //here and line 903 both side closedStatus changed to completeTaskStatus
            pdf: base64,
            pdfName: '${firstName}_${lastName}_${widget.model.number}.pdf',
          ),
        );

    // /// Use below code to modify and view pdf.
    // GoRouter.of(context).pushNamed(
    //   RouteConstants.serviceCallReportPDF,
    //   extra: csrModel,
    // );
  }

  Container technicianDetailsCard() {
    return Container(
      padding: EdgeInsets.all(15.h),
      margin: EdgeInsets.only(top: 15.h),
      decoration: primaryCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Technician Name",
            style: Styles.textStyledarkBlack14dpBold.copyWith(
              color: AppColors.lightDark,
            ),
          ),
          buildSizedBox10(),
          _textField(
            prefixIcon: AppImage.signatureUserIcon,
            hint: 'Enter your name',
            controller: TextEditingController(
              text: csrModel.techName,
            ),
            enabled: false,
          ),
          15.verticalSpace,
          Row(
            children: [
              if (csrModel.technicianSign != null) ...{
                Container(
                  height: 50.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: MemoryImage(csrModel.technicianSign!),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                ),
                30.horizontalSpace,
              },
              ElevatedButton(
                onPressed: () => showSignaturePad(isCustomer: false),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  backgroundColor: AppColors.darkGrey,
                ),
                child: Text(
                  csrModel.technicianSign != null ? "Update" : "Signature",
                  style: Styles.textStyledarkWhite13dpRegular,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget customerNameAddressSignCard() {
    return Container(
      padding: EdgeInsets.all(15.h),
      // margin: EdgeInsets.all(15.h),
      decoration: primaryCardDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Customer Name",
            style: Styles.textStyledarkBlack14dpBold.copyWith(
              color: AppColors.lightDark,
            ),
          ),
          5.verticalSpace,
          _textField(
            prefixIcon: AppImage.signatureUserIcon,
            hint: 'Enter your name',
            keyboard: TextInputType.text,
            controller: csrModel.nameTEC,
          ),
          15.verticalSpace,
          Text(
            "Email Address",
            style: Styles.textStyledarkBlack14dpBold.copyWith(
              color: AppColors.lightDark,
            ),
          ),
          5.verticalSpace,
          _textField(
            prefixIcon: AppImage.signatureEmail,
            hint: 'Enter your email',
            keyboard: TextInputType.emailAddress,
            controller: csrModel.emailTEC,
          ),
          15.verticalSpace,
          _textField(
            hint: 'Add your comments',
            maxLine: 5,
            keyboard: TextInputType.text,
            controller: csrModel.commentTEC,
          ),
          15.verticalSpace,
          Row(
            children: [
              if (csrModel.customerSign != null) ...{
                Container(
                  height: 50.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: MemoryImage(csrModel.customerSign!),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 3,
                        offset:
                            const Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                ),
                30.horizontalSpace,
              },
              ElevatedButton(
                onPressed: () => showSignaturePad(),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  backgroundColor: AppColors.darkGrey,
                ),
                child: Text(
                  csrModel.customerSign != null ? "Update" : "Signature",
                  style: Styles.textStyledarkWhite13dpRegular,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration primaryCardDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
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
        BoxShadow(
          color: AppColors.white,
          offset: const Offset(0.0, 0.0),
          blurRadius: 0.0,
          spreadRadius: 0.0,
        ),
      ],
    );
  }

  BoxDecoration secondaryWidgetDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 0.5,
          blurRadius: 3,
          offset: const Offset(0, 1), // changes position of shadow
        ),
      ],
    );
  }

  void showSignaturePad({bool isCustomer = true}) {
    FocusScope.of(context).unfocus();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0.r)),
          ),
          contentPadding: EdgeInsets.zero,
          // Remove contentPadding
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.h,
                  child: Center(
                    child: Text(
                      isCustomer
                          ? "Customer Signature"
                          : "Technician Signature",
                      style: Styles.textStyledarkBlack14dpBold,
                    ),
                  ),
                ),
                ClipRect(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: MediaQuery.of(context).size.width * .9,
                    height: 500,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grey),
                    ),
                    child: Signature(
                      controller: isCustomer
                          ? _customerSignController
                          : _technicianSignController,
                      backgroundColor: AppColors.white,
                    ),
                  ),
                ),
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        backgroundColor: AppColors.boxShadowGrey,
                      ),
                      onPressed: () {
                        setState(() {
                          _handleClearButtonPressed(isCustomer: isCustomer);
                        });
                      },
                      child: Text(
                        "Clear",
                        style: Styles.textStyledarkWhite13dpRegular,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        backgroundColor: AppColors.red,
                      ),
                      onPressed: () {
                        GoRouter.of(context).pop();
                        _handleSaveButtonPressed(isCustomer: isCustomer);
                      },
                      child: Text(
                        "SUBMIT",
                        style: Styles.textStyledarkWhite13dpRegular,
                      ),
                    ),
                  ],
                ),
                10.verticalSpace,
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _textField({
    String? prefixIcon,
    String? hint,
    TextInputType? keyboard,
    int? maxLine,
    TextEditingController? controller,
    Function(String)? onChanged,
    bool enabled = true,
  }) {
    return Container(
      decoration: secondaryWidgetDecoration(),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboard,
        textInputAction: TextInputAction.done,
        enabled: enabled,
        maxLines: maxLine,
        decoration: InputDecoration(
          isDense: true,
          prefixIconConstraints: BoxConstraints(minWidth: 10.w, minHeight: 0),
          prefixIcon: prefixIcon != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage(prefixIcon),
                    width: 30.w,
                    height: 30.h,
                  ),
                )
              : null,
          alignLabelWithHint: false,
          filled: true,
          fillColor: AppColors.white,
          hintText: hint,
          hintStyle: Styles.textStyleTextFieldPlaceHolder11dpRegular,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
        ),
        style: enabled
            ? null // Use default text style when enabled
            : TextStyle(
                color: Colors.grey.shade600,
              ), // Grey color for disabled text
        onChanged: onChanged,
      ),
    );
  }

  String durationToTimeString(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    String twoDigitHours = twoDigits(duration.inHours);
    if (twoDigitSeconds != "00" &&
        twoDigitHours == "00" &&
        twoDigitMinutes == "00") {
      return "$twoDigitSeconds secs";
    } else if (twoDigitHours == "00" && twoDigitMinutes != "00") {
      return "$twoDigitMinutes mins";
    } else {
      if (twoDigitHours != "1") {
        return "$twoDigitHours hr $twoDigitMinutes mins";
      }
      return "$twoDigitHours hrs $twoDigitMinutes mins";
    }
  }

  // Calculate travel time
  String getTravelTime() {
    if (widget.model.uTravelStartTime != null &&
        widget.model.uTravelStartTime!.isNotEmpty &&
        widget.model.uArrivalTime != null &&
        widget.model.uArrivalTime!.isNotEmpty) {
      try {
        // Parse time strings, potentially with a specific format
        DateTime startTime = DateTime.parse(widget.model.uTravelStartTime!);
        DateTime endTime = DateTime.parse(widget.model.uArrivalTime!);
        logger.i(startTime);
        logger.i(endTime);

        Duration diff = startTime.difference(endTime).abs();

        // Return the formatted time difference
        return durationToTimeString(diff);
      } catch (e) {
        // Check for null values
        if (widget.model.uTravelStartTime == null ||
            widget.model.uArrivalTime == null) {
          return 'Travel time unavailable'; // Or a more specific message
        } else {
          return 'Error calculating travel time';
        }
      }
    } else {
      // Handle empty strings or missing data
      return '00:00:00'; // Or a more appropriate default value
    }
  }

  String formatAndAddUtcToTimeSafely(
    String? dateString, {
    VoidCallback? logger,
  }) {
    if (dateString == null) {
      return '';
    }
    try {
      DateTime dateTime = DateTime.parse(dateString);

      // Add 5 hours and 30 minutes to the time
      dateTime = dateTime.add(const Duration(hours: 5, minutes: 30));

      // Format the time to 'hh:mm a' to get 12-hour format with AM/PM
      String formattedTime = DateFormat('hh:mm a').format(dateTime);
      return formattedTime;
    } catch (e) {
      if (logger != null) {
        logger();
      }
      return '';
    }
  }

  Widget travelDetailsCard() {
    logger.f(widget.model.workEnd);
    logger.f(widget.model.workStart);
    return Container(
      color: AppColors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 26.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Travel Details:",
              style: Styles.textStyledarkBlack13dpBold.copyWith(
                color: AppColors.dark,
              ),
            ),
            20.verticalSpace,
            if (widget.model.uTravelStartTime != null) ...[
              _dataTile(
                title: 'Start Time:',
                data:
                    formatAndAddUtcToTimeSafely(widget.model.uTravelStartTime!),
              ),
              6.verticalSpace,
            ],
            if (widget.model.uArrivalTime != null) ...[
              _dataTile(
                title: 'Arrival Time:',
                data: formatAndAddUtcToTimeSafely(widget.model.uArrivalTime),
              ),
              6.verticalSpace,
            ],
            _dataTile(
              title: 'Travel Time:',
              data:
                  getTravelTime(), // Assuming this already returns formatted time
            ),
            6.verticalSpace,
            if (widget.model.uWorkStarted != null) ...[
              _dataTile(
                title: 'Work Start Time:',
                data: formatAndAddUtcToTimeSafely(widget.model.uWorkStarted),
              ),
            ] else ...[
              _dataTile(
                title: 'Work Start Time:',
                data: '',
              ),
            ],
            6.verticalSpace,
            if (widget.model.uWorkCompleted != null) ...[
              _dataTile(
                title: 'Work End Time:',
                data: formatAndAddUtcToTimeSafely(widget.model.uWorkCompleted),
              ),
              6.verticalSpace,
            ],
          ],
        ),
      ),
    );
  }

  Widget customerDetailsCard() {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 26.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Customer Details:",
            style: Styles.textStyledarkBlack13dpBold.copyWith(
              color: AppColors.dark,
            ),
          ),
          20.verticalSpace,
          _dataTile(
            title: 'Reference ID:',

            //work around for showing display
            data:
                "${widget.model.uDispatchOtNumber != null ? "${widget.model.uDispatchOtNumber!.split("_").first} - " : ""}${widget.model.taskEffectiveNumber}",
            width: 100.w,
          ),
          6.verticalSpace,
          _dataTile(
            title: 'Contact ID:',
            data: widget.contractID,
            width: 100.w,
          ),
        ],
      ),
    );
  }

  Widget _dataTile({required String title, String? data, double? width}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: width ?? 110.w,
          child: Text(
            title,
            style: Styles.textStyleDark12dpBold.copyWith(
              color: AppColors.lightDark,
            ),
          ),
        ),
        SizedBox(width: 8.0.w),
        Expanded(
          child: Text(
            data ?? '',
            style: Styles.textStyleDark12dpBold,
          ),
        ),
      ],
    );
  }
}
