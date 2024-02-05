import 'package:flutter/material.dart';
import 'package:ilzo_hackaton/main.dart';
import 'package:url_launcher/url_launcher.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key, required this.location});
  final String location;
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  //tags,
  //location spots
  //(url, image) 받아오기
  List tags = ["힐링", "바다", "고즈넉", "가족", "시간여행"];
  Future<void> _launchUrl(url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  Map locationMap = {
    "단양": "dy",
    "제천": "jc",
    "충주": "gs",
    "괴산": "jjc",
    "음성": "jp",
    "진천": "jjc",
    "증평": "jp",
    "청주": "ccj",
    "보은": "be",
    "옥천": "occ",
    "영동": "yd"
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "당신이 원하는 여행지",
                  style: tt(context).bodyLarge,
                ),
                Text(
                  "🚅 ${widget.location}",
                  style: tt(context).titleLarge,
                ),
              ],
            ),
          ),
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.height,
              child: Image(
                fit: BoxFit.cover,
                image: AssetImage(
                    "assets/images/images/${locationMap[widget.location]}.jpeg"),
              )),
          Row(
            children: [
              for (int i = 0; i < tags.length; i++)
                Padding(
                  padding: const EdgeInsets.fromLTRB(4, 10, 4, 10),
                  child: Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 223, 223, 223)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "#${tags[i]}",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )),
                ),
            ],
          ),
          LocationSpot(
            headLine: "${widget.location}으로 떠나는 시간여행 🕒",
            assetsPath: "assets/images/path",
            url:
                "https://korean.visitkorea.or.kr/detail/rem_detail.do?cotid=24026cb1-24e1-45ea-a44c-a8906be7095a&con_type=11300",
          ),
          const LocationSpot(
            headLine: "인스타그램 핫플 카페 ☕️",
            assetsPath: "assets/images/restaurants",
            url:
                "https://www.instagram.com/explore/tags/%EA%B3%B5%EA%B0%90%EC%84%A0%EC%9C%A0/",
          ),
          const LocationSpot(
            headLine: "고즈넉한 관광지 추천 📑",
            assetsPath: "assets/images",
            url: "https://blog.naver.com/sycho0517/223101926567?&isInf=true",
          ),
        ],
      ),
    ));
  }
}

class LocationSpot extends StatefulWidget {
  const LocationSpot(
      {super.key,
      required this.headLine,
      required this.assetsPath,
      required this.url});
  final String headLine;
  final String assetsPath;
  final String url;
  @override
  State<LocationSpot> createState() => _LocationSpotState();
}

class _LocationSpotState extends State<LocationSpot> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            widget.headLine,
            style: tt(context).bodyLarge,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              for (int i = 0; i < 5; i++)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      launchUrl(
                        Uri.parse(widget.url),
                      );
                    },
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.height * 0.23,
                      child: Image(
                          image: AssetImage(
                              "${widget.assetsPath}/image${i + 1}.jpeg")),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
