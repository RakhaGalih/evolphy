// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:evolphy/constants/constant.dart';
import 'package:flutter/material.dart';

class BackAppBar extends StatelessWidget {
  final String? title;
  final bool? save;
  const BackAppBar({
    super.key,
    this.title,
    this.save,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Material(
                color: const Color(0xFFFFFFFF).withOpacity(0.24),
                borderRadius: BorderRadius.circular(12),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const SizedBox(
                      width: 50,
                      height: 50,
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Text(
                  title ?? '',
                  style: kSemiBoldTextStyle.copyWith(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(
                width: 50,
              ),
            ],
          ),
        ));
  }
}
