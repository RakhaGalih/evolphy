import 'package:evolphy/constants/constant.dart';
import 'package:flutter/material.dart';

class ForumPage extends StatelessWidget {
  const ForumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              Center(
                child: Text(
                  'Forum',
                  style: kSemiBoldTextStyle.copyWith(fontSize: 20),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                          decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.search),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 30.0, vertical: 15),
                              filled: true,
                              fillColor: kAbuHitam,
                              hintStyle: const TextStyle(color: kAbu),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                  width: 0,
                                  style: BorderStyle.none,
                                ),
                              ),
                              hintText: 'Cari forum')),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: kUngu, borderRadius: BorderRadius.circular(8)),
                      child: const Icon(
                        Icons.tune,
                        color: kWhite,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: kAbuHitam,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: kAbu, width: 0.5)),
                child: const Row(
                  children: [
                    Icon(
                      Icons.favorite_outline,
                      color: kWhite,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Icon(
                      Icons.question_answer_outlined,
                      color: kWhite,
                    ),
                    SizedBox(
                      width: 7,
                    ),
                    Icon(
                      Icons.bookmark_border,
                      color: kWhite,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/post');
        },
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
              color: kUngu, borderRadius: BorderRadius.circular(30)),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.add_circle,
                color: kWhite,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Unggah',
                style: kSemiBoldTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
