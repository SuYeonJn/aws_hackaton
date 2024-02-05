import 'package:flutter/material.dart';
import 'package:ilzo_hackaton/main.dart';
import 'package:ilzo_hackaton/resultPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChoicePage extends StatefulWidget {
  const ChoicePage({super.key});

  @override
  State<ChoicePage> createState() => _ChoicePageState();
}

class _ChoicePageState extends State<ChoicePage> {
  List questionList = [
    ["도심", "한적한 외곽"],
    ["산", "바다"],
    ["힐링", "액티비티"],
    ["휴양", "관광"],
    ["핫플", "숨은 명소"],
    ["가족", "연인", "친구", "혼자"],
  ];
  List choiceResult = [];
  int questionIndex = 0;
  late int choiceIndex;
  void onTabButton(selectIndex) async {
    if (questionIndex == questionList.length - 1) {
      //choiceResult 백엔드에 보내고, 응답 받아오기
      //진행중 프로그레스바 띄우기
      //다 받으면 결과 페이지로 이동
      http.Response response = await http.post(
        Uri.parse('http://43.200.70.209/search'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, List>{
          'words': choiceResult,
        }),
      );
      if (response.body.isNotEmpty) {
        Map location = json.decode(response.body);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(location: location['district']),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ResultPage(location: "군산"),
          ),
        );
      }
    } else {
      setState(() {
        choiceIndex = selectIndex;
        questionIndex++;
      });
      choiceResult.add(questionList[questionIndex][choiceIndex]);
    }
    print(choiceResult);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "당신의 여행 MBTI는?",
              style: tt(context).titleLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            Column(
              children: [
                for (int i = 0; i < questionList[questionIndex].length; i++)
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          onTabButton(i);
                        },
                        child: ChoiceButton(
                          buttonName: questionList[questionIndex][i],
                        ),
                      ),
                      if (i != questionList[questionIndex].length - 1)
                        Text(
                          "vs",
                          style: tt(context).bodyLarge,
                        ),
                    ],
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChoiceButton extends StatefulWidget {
  const ChoiceButton({super.key, required this.buttonName});
  final String buttonName;

  @override
  State<ChoiceButton> createState() => _ChoiceButtonState();
}

class _ChoiceButtonState extends State<ChoiceButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.width * 0.2,
        decoration:
            const BoxDecoration(color: Color.fromARGB(255, 241, 174, 153)),
        child: Center(
            child: Text(widget.buttonName,
                style: const TextStyle(
                  fontSize: 20,
                ))),
      ),
    );
  }
}
