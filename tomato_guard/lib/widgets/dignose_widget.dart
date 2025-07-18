// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tomato_guard/utils/app_constant.dart';
import 'package:tomato_guard/utils/get_upload_function.dart';

class DignoseWidget extends StatefulWidget {
  final VoidCallback refresh;
  final String result;
  final String imageurl;
  final String date;
  final String id;

  DignoseWidget({
    super.key,
    required this.result,
    required this.imageurl,
    required this.date,
    required this.id,
    required this.refresh,
  });

  @override
  State<DignoseWidget> createState() => _DignoseWidgetState();
}

class _DignoseWidgetState extends State<DignoseWidget> {
  GetUploadFunction getUploadFunction = GetUploadFunction();

  String dateformate(String rawdate) {
    try {
      final dateTime = DateTime.parse(rawdate);
      return DateFormat('dd MMMM yyyy').format(dateTime);
    } catch (e) {
      return rawdate;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          height: 55,
          width: double.infinity,
          color: AppConstant.background,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 60,
                width: 50,
                child: Image.network(widget.imageurl, fit: BoxFit.cover),
              ),
              SizedBox(width: 4),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Disease Name:',
                          style: TextStyle(
                            fontFamily: AppConstant.boldfontheading,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 150),
                        GestureDetector(
                          onTap: () async {
                            bool success = await getUploadFunction.deletedata(
                              widget.id,
                            );
                            if (success) {
                              widget.refresh();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Icon(
                              Icons.cancel,
                              size: 21,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 2),
                    Text(
                      widget.result,
                      style: TextStyle(
                        fontFamily: AppConstant.boldfontheading,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          'Date:',
                          style: TextStyle(
                            fontFamily: AppConstant.boldfontheading,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          dateformate(widget.date),

                          style: TextStyle(
                            fontFamily: AppConstant.boldfontheading,
                            fontSize: 8,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
