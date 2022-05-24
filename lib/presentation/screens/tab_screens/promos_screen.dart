import 'package:flutter/material.dart';
import 'package:salesforce_spo/common_widgets/promo.dart';
import 'package:salesforce_spo/design_system/primitives/padding_system.dart';

import '../../../common_widgets/note.dart';
import '../../../models/promo_model.dart';

class PromosList extends StatelessWidget {
  const PromosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<PromoModel> list = [
      PromoModel(
          title: 'Recording Gear is in the tend Moving ahead in the future!',
          imgUrl:
              'https://static.guitarcenter.com/static/gc/2022/page-dynamic/services/lessons/guitar/special-event/mobile/gc-md-hf-guitar-lesson-specialevent-03-03-22.jpg',
          date: '20-Mar-2022'),
      PromoModel(
          title: 'Get a free Guitar Lesson on buying Accoridan Guitar',
          imgUrl:
              'https://static.guitarcenter.com/static/gc/2021/page-dynamic/services/lessons/tablet/gc-md-bg-learning-to-play-07-19-21.jpg',
          date: '21-Mar-2022'),
      PromoModel(
          title:
              'Turn your Desktop into a fun music with our top perfoming Amplifier range starting from Rs 129.99',
          imgUrl:
              'https://static.guitarcenter.com/static/gc/2021/page-dynamic/services/lessons/mobile/gc-md-ad-open-house-07-19-21.jpg',
          date: '22-Mar-2022')
    ];
    return Container(
        margin: const EdgeInsets.only(top: PaddingSystem.padding20),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Promo(
                  title: list[index].title,
                  imgURL: list[index].imgUrl,
                  date: list[index].date);
            }));
  }
}
