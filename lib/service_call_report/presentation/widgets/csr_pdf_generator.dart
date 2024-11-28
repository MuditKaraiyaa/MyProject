import 'dart:convert';

import 'package:flutter/services.dart' show Uint8List, rootBundle;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:xbridge/common/constants/app_image.dart';
import 'package:xbridge/service_call_report/data/model/csr_model.dart';

class CSRPdfGeneration {
  const CSRPdfGeneration({required this.model, required this.techName});

  final CSRModel model;
  final String techName;

  Future<String> buildPDF() async {
    pw.MemoryImage logoData = pw.MemoryImage(
      (await rootBundle.load(AppImage.loginHeader)).buffer.asUint8List(),
    );
    pw.MemoryImage missionStatus = pw.MemoryImage(
      (await rootBundle.load(AppImage.iconCheck)).buffer.asUint8List(),
    );

    // Create a PDF document.
    final doc = pw.Document();
    // Add page to the PDF
    doc.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.a4.landscape,
          margin: pw.EdgeInsets.symmetric(horizontal: 20.w),
        ),
        build: (context) => [
          pw.Container(
            width: 80.0.w,
            height: 50.0.h,
            alignment: pw.Alignment.centerLeft,
            child: pw.Image(logoData),
          ),
          _customerDetail(),
          pw.SizedBox(height: 10.h),
          _travelTable(),
          pw.SizedBox(height: 10.h),
          pw.Row(
            children: [
              pw.Text(
                'Issue Description: ',
                style: pw.TextStyle(
                  fontSize: 7.sp,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(
                width: 5.h,
              ),
              pw.Text(
                model.shortDescription ?? '',
                style: pw.TextStyle(
                  fontSize: 7.sp,
                  fontWeight: pw.FontWeight.normal,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 3.h),
          _productDetail(),
          pw.SizedBox(height: 3.h),
          _logistics(),
          pw.SizedBox(height: 3.h),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              _resolutionNotes(),
              pw.SizedBox(width: 5.w),
              pw.Row(
                //Mission status in center
                // crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    'Mission Status:',
                    style: pw.TextStyle(
                      fontSize: 7.h,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(
                    width: 10.h,
                  ),
                  //  pw.Text(model.missionStatus ?? ''),
                  pw.Column(
                    // mainAxisAlignment: pw.MainAxisAlignment.center,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        children: [
                          pw.Container(
                            width: 9.w,
                            height: 9.h,
                            decoration: pw.BoxDecoration(
                              color: PdfColors.white,
                              border: pw.Border.all(
                                color: PdfColors.black,
                              ), // Adding border
                              borderRadius: pw.BorderRadius.zero,
                            ),
                            child: pw.Center(
                              child: model.missionStatus == 'Resolved'
                                  ? pw.Image(
                                      missionStatus,
                                      height: 10,
                                      fit: pw.BoxFit.fitHeight,
                                    )
                                  : pw.SizedBox(
                                      height: 10,
                                    ),
                              //    pw.Icon(pw.IconData(mt.Icons.ac_unit.codePoint,))
                            ),
                          ),
                          pw.SizedBox(width: 5),
                          pw.Text(
                            "Resolved",
                            style: pw.TextStyle(
                              fontSize: 7.h,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 10.h),
                      pw.Row(
                        children: [
                          pw.Container(
                            width: 9.w,
                            height: 9.h,
                            decoration: pw.BoxDecoration(
                              color: PdfColors.white,
                              border: pw.Border.all(
                                color: PdfColors.black,
                              ), // Adding border
                              borderRadius: pw.BorderRadius
                                  .zero, // Removing circular border
                            ),
                            child: pw.Center(
                              child: model.missionStatus ==
                                      'Additional Visit Required'
                                  ? pw.Image(
                                      missionStatus,
                                      height: 12,
                                      fit: pw.BoxFit.fitHeight,
                                    )
                                  : pw.SizedBox(height: 10, width: 10),
                              //    pw.Icon(pw.IconData(mt.Icons.ac_unit.codePoint,))
                            ),
                          ),
                          pw.SizedBox(width: 5),
                          pw.Text(
                            "Additional Visit Required",
                            style: pw.TextStyle(
                              fontSize: 7.h,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              // _missionStatus(),
              pw.SizedBox(width: 5.w),
              //   _customerSatisfaction(),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                children: [
                  pw.Text(
                    'Is Customer Satisfied?: ',
                    style: pw.TextStyle(
                      fontSize: 7.h,
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                  pw.SizedBox(
                    width: 5.w,
                  ),
                  pw.Column(
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Row(
                        children: [
                          pw.Container(
                            width: 9.w,
                            height: 9.h,
                            decoration: pw.BoxDecoration(
                              color: PdfColors.white,
                              border: pw.Border.all(
                                color: PdfColors.black,
                              ), // Adding border
                              borderRadius: pw.BorderRadius.zero,
                            ),
                            child: pw.Center(
                              child: model.customerSatisfy == 'Yes'
                                  ? pw.Image(
                                      missionStatus,
                                      height: 12,
                                      fit: pw.BoxFit.fitHeight,
                                    )
                                  : pw.SizedBox(
                                      height: 12,
                                    ),
                              //    pw.Icon(pw.IconData(mt.Icons.ac_unit.codePoint,))
                            ),
                          ),
                          pw.SizedBox(width: 5),
                          pw.Text(
                            "Yes",
                            style: pw.TextStyle(
                              fontSize: 7.h,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 5),
                      pw.Row(
                        children: [
                          pw.Container(
                            width: 9.w,
                            height: 9.h,
                            decoration: pw.BoxDecoration(
                              color: PdfColors.white,
                              border: pw.Border.all(
                                color: PdfColors.black,
                              ), // Adding border
                              borderRadius: pw.BorderRadius.zero,
                            ),
                            child: pw.Center(
                              child: model.customerSatisfy == 'No'
                                  ? pw.Image(
                                      missionStatus,
                                      height: 12,
                                      fit: pw.BoxFit.fitHeight,
                                    )
                                  : pw.SizedBox(
                                      height: 12,
                                    ),
                              //    pw.Icon(pw.IconData(mt.Icons.ac_unit.codePoint,))
                            ),
                          ),
                          pw.SizedBox(width: 5),
                          pw.Text(
                            "No",
                            style: pw.TextStyle(
                              fontSize: 7.h,
                            ),
                          ),
                        ],
                      ),
                      pw.SizedBox(height: 5),
                      pw.Row(
                        children: [
                          pw.Container(
                            width: 9.w,
                            height: 9.h,
                            decoration: pw.BoxDecoration(
                              color: PdfColors.white,
                              border: pw.Border.all(
                                color: PdfColors.black,
                              ), // Adding border
                              borderRadius: pw.BorderRadius.zero,
                            ),
                            child: pw.Center(
                              child: model.customerSatisfy == 'Not Shared'
                                  ? pw.Image(
                                      missionStatus,
                                      height: 12,
                                      fit: pw.BoxFit.fitHeight,
                                    )
                                  : pw.SizedBox(
                                      height: 12,
                                    ),
                              //    pw.Icon(pw.IconData(mt.Icons.ac_unit.codePoint,))
                            ),
                          ),
                          pw.SizedBox(width: 5),
                          pw.Text(
                            "Not Shared",
                            style: pw.TextStyle(
                              fontSize: 7.h,
                            ),
                          ),
                        ],
                      ),
                      // pw.Text(
                      //   model.customerSatisfy ?? '',
                      // ),
                    ],
                  ),
                ],
              ),
              pw.SizedBox(height: 10.h),
            ],
          ),
          pw.SizedBox(height: 10.h),
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              _signature(),
              pw.SizedBox(width: 20.h),
              _technician(),
            ],
          ),
        ],
      ),
    );

    Uint8List pdfBytes = await doc.save();

    return base64Encode(pdfBytes);
  }

  String formatTime(String? time) {
    if (time == null || time.isEmpty) {
      return '';
    }
    // Parse the time string to DateTime and format it to "hh:mm"
    try {
      final DateTime parsedTime = DateTime.parse(time);
      final String formattedTime =
          "${parsedTime.hour.toString().padLeft(2, '0')}:${parsedTime.minute.toString().padLeft(2, '0')}";
      return formattedTime;
    } catch (e) {
      // Handle the exception if the time string is not in a valid format
      return '';
    }
  }

  pw.Widget _travelTable() {
    return pw.Table(
      border: pw.TableBorder.all(),
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(
            color: PdfColors.green,
          ),
          children: [
            _tableHeader(title: 'Sr\nNo.'),
            _tableHeader(title: 'Date'),
            _tableHeader(title: 'Travel Time\nto site'),
            _tableHeader(title: 'Arrival Time'),
            _tableHeader(title: 'Start Time'),
            _tableHeader(title: 'Completion Time'),
            _tableHeader(title: 'Leaving Time'),
          ],
        ),
        pw.TableRow(
          children: [
            _tableData(data: '1'),
            _tableData(data: formatDate(model.arrivalTime)),
            _tableData(
              data: getTravelTime(
                startTime: model.startTime,
                endTime: model.arrivalTime,
              ),
            ),
            _tableData(data: formatTime(model.arrivalTime)),
            _tableData(data: formatTime(model.workStartTime)),
            _tableData(data: formatTime(model.workEndTime)),
            _tableData(data: formatTime(model.departureTime)),
          ],
        ),
      ],
    );
  }

  String formatDate(String? dateTime) {
    if (dateTime == null || dateTime.isEmpty) {
      return '';
    }
    // Parse the date-time string to DateTime and format it to "yyyy-MM-dd"
    try {
      final DateTime parsedDateTime = DateTime.parse(dateTime);
      final String formattedDate =
          "${parsedDateTime.year.toString().padLeft(4, '0')}-${parsedDateTime.month.toString().padLeft(2, '0')}-${parsedDateTime.day.toString().padLeft(2, '0')}";
      return formattedDate;
    } catch (e) {
      // Handle the exception if the date-time string is not in a valid format
      return '';
    }
  }

  String getTravelTime({String? startTime, String? endTime}) {
    if (startTime != null &&
        startTime.isNotEmpty &&
        endTime != null &&
        endTime.isNotEmpty) {
      try {
        DateTime sTime = DateTime.parse(startTime);
        DateTime eTime = DateTime.parse(endTime);

        Duration diff = eTime.difference(sTime);
        int days = diff.inDays.abs();
        int hrs = (diff.inHours - (diff.inDays * 24)).abs();
        int min = diff.inMinutes % 60;

        if (days > 0) {
          return '$days days : $hrs hrs : $min mins';
        }
        return '$hrs hrs : $min mins';
      } catch (e) {
        return 'Invalid date format';
      }
    }
    return '';
  }

  pw.Widget _productTable() {
    return pw.Table(
      border: pw.TableBorder.all(),
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(
            color: PdfColors.grey,
          ),
          children: [
            _tableHeader(title: 'Brand'),
            _tableHeader(title: 'Model'),
            _tableHeader(title: 'Type'),
            _tableHeader(title: 'Serial Number'),
            _tableHeader(title: 'Description'),
          ],
        ),
        pw.TableRow(
          children: [
            _tableData(data: model.brandTEC?.text ?? ''),
            _tableData(data: model.modelTEC?.text ?? ''),
            _tableData(data: model.typeTEC?.text ?? ''),
            _tableData(data: model.sNumberTEC?.text ?? ''),
            _tableData(data: model.descTEC?.text ?? ''),
          ],
        ),
      ],
    );
  }

  pw.Widget _logisticTable() {
    return pw.Table(
      border: pw.TableBorder.all(),
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(
            color: PdfColors.blueGrey300,
          ),
          children: [
            _tableHeader(title: 'Title'),
            _tableHeader(title: 'Reference'),
            _tableHeader(title: 'Part Number'),
            _tableHeader(title: 'Serial Number'),
            _tableHeader(title: 'Tag ID'),
          ],
        ),
        pw.TableRow(
          children: [
            _tableData(data: 'Defective Part'),
            _tableData(data: model.defectRefTEC?.text ?? ''),
            _tableData(data: model.defectPartTEC?.text ?? ''),
            _tableData(data: model.defectSNumberTEC?.text ?? ''),
            _tableData(data: model.defectTagTEC?.text ?? ''),
          ],
        ),
        pw.TableRow(
          children: [
            _tableData(data: 'Part used for replacement'),
            _tableData(data: model.replaceRefTEC?.text ?? ''),
            _tableData(data: model.replacePartTEC?.text ?? ''),
            _tableData(data: model.replaceSNumberTEC?.text ?? ''),
            _tableData(data: model.replaceTagTEC?.text ?? ''),
          ],
        ),
      ],
    );
  }

  pw.Widget _tableHeader({required String title}) {
    return pw.Container(
      alignment: pw.Alignment.center,
      padding: const pw.EdgeInsets.symmetric(
        vertical: 5,
      ),
      child: pw.Text(
        title,
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(
          fontSize: 7.sp,
          fontWeight: pw.FontWeight.bold,
        ),
      ),
    );
  }

  pw.Widget _tableData({required String data}) {
    return pw.Container(
      alignment: pw.Alignment.center,
      padding: const pw.EdgeInsets.all(
        5,
      ),
      child: pw.Text(
        data,
        textAlign: pw.TextAlign.center,
        style: pw.TextStyle(
          fontSize: 7.sp,
        ),
      ),
    );
  }

  pw.Widget _dataTile({required String title, required String data}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2),
      child: pw.Row(
        children: [
          pw.Text(
            '$title:',
            style: pw.TextStyle(
              fontSize: 7.sp,
            ),
          ),
          pw.SizedBox(
            width: 10.w,
          ),
          pw.Text(
            data,
            style: pw.TextStyle(
              fontSize: 7.sp,
            ),
          ),
        ],
      ),
    );
  }

  pw.Widget _customerDetail() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Customer Detail:',
          style: pw.TextStyle(
            fontSize: 7.sp,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(
          height: 3.h,
        ),
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "Customer:",
                  style: pw.TextStyle(
                    fontSize: 7.sp,
                  ),
                ),
                pw.Text(
                  "Reference ID:",
                  style: pw.TextStyle(
                    fontSize: 7.sp,
                  ),
                ),
                pw.Text(
                  "Contract ID:",
                  style: pw.TextStyle(
                    fontSize: 7.sp,
                  ),
                ),
                pw.Text(
                  "Customer Address:",
                  style: pw.TextStyle(
                    fontSize: 7.sp,
                  ),
                ),
              ],
            ),
            pw.SizedBox(width: 7),
            pw.Column(
              // mainAxisAlignment: pw.MainAxisAlignment.end,
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "${model.account != null && model.account!.isNotEmpty ? model.account : '__'}  ",
                  style: pw.TextStyle(
                    fontSize: 7.sp,
                    color: model.account != null && model.account!.isNotEmpty
                        ? null
                        : PdfColors.white,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  "${model.cstRefID ?? ''}  ",
                  style: pw.TextStyle(
                    fontSize: 7.sp,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  "${model.cstContactID ?? ''}  ",
                  style: pw.TextStyle(
                    fontSize: 7.sp,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.Text(
                  "${model.street}, ${model.city}, ${model.country}   ",
                  style: pw.TextStyle(
                    fontSize: 7.sp,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _productDetail() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Product Detail:',
          style: pw.TextStyle(
            fontSize: 7.sp,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(
          height: 3.h,
        ),
        _productTable(),
      ],
    );
  }

  pw.Widget _resolutionNotes() {
    return pw.Row(
      children: [
        pw.Text(
          'Resolution Notes: ',
          style: pw.TextStyle(
            fontSize: 7.h,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(
          width: 5.h,
        ),
        pw.Text(
          model.resolutionNoteTEC?.text ?? '',
          softWrap: true,
          style: pw.TextStyle(
            fontSize: 7.h,
          ),
        ),
      ],
    );
  }

  pw.Widget _logistics() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          'Logistics',
          style: pw.TextStyle(
            fontSize: 7.sp,
            fontWeight: pw.FontWeight.bold,
          ),
        ),
        pw.SizedBox(height: 5.h),
        _logisticTable(),
      ],
    );
  }

  pw.Widget _signature() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        _dataTile(title: 'Customer Name', data: model.nameTEC?.text ?? ''),
        _dataTile(
          title: 'Customer Comments',
          data: model.commentTEC?.text ?? '',
        ),
        pw.SizedBox(
          height: 5,
        ),
        pw.Text(
          'Customer Signature:',
          style: pw.TextStyle(
            fontSize: 7.h,
          ),
        ),
        pw.SizedBox(
          height: 3.h,
        ),
        pw.SizedBox(
          height: 5.h,
        ),
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Container(
            height: 60.h,
            width: 120.w,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(color: PdfColors.grey, width: 1),
              ),
            ),
            child: pw.Image(
              pw.MemoryImage(model.customerSign!),
            ),
          ),
        ),
      ],
    );
  }

  pw.Widget _technician() {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Text(
          'Technician Name:',
          style: pw.TextStyle(
            fontSize: 7.h,
          ),
        ),
        pw.SizedBox(
          height: 3.h,
        ),
        pw.Text(
          model.techName ?? '',
          style: pw.TextStyle(
            fontSize: 7.sp,
          ),
        ),
        pw.SizedBox(
          height: 7.h,
        ),
        pw.Text(
          'Technician Signature:',
          style: pw.TextStyle(
            fontSize: 7.h,
          ),
        ),
        pw.SizedBox(
          height: 7.h,
        ),
        pw.Align(
          alignment: pw.Alignment.centerRight,
          child: pw.Container(
            height: 50.h,
            width: 120.w,
            decoration: const pw.BoxDecoration(
              border: pw.Border(
                bottom: pw.BorderSide(color: PdfColors.grey, width: 1),
              ),
            ),
            child: pw.Image(
              pw.MemoryImage(model.technicianSign!),
            ),
          ),
        ),
      ],
    );
  }
}
