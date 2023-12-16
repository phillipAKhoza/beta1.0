import 'package:cloud_firestore/cloud_firestore.dart';
class VisualDto {
  String? image;
  String title;
  String? author;
  String date;
  List<String> paragraphs;
  List<String>? links;

  VisualDto({
    this.image,
    required this.title,
    this.author,
    required this.date,
    required this.paragraphs,
    this.links,
  });
}

class FoundatioData {
  List<VisualDto> foundations = [
    VisualDto(
        image: 'assets/images/logo1.png',
        title: "Feed a Child's Vision",
        author: 'P.A KHOZA',
        date: 'Jan 01',
        paragraphs: [
          'Help Feed a Child make a difference  – Our vision is to eradicate poverty in a sustainable manner and to take God’s hope to the nations.',
          'As a National Body we assist other NGO’s to not only be as effective as possible, but also to become sustainable and economically active.',
          'Feed a Child currently has an impact on the lives of approximately 10 000 people on a regular basis. We have many projects  in the works and currently delivering meals to children throughout South Africa. It is estimated that almost 10% of the South African population are children of no particular culture or ethical group, living below the poverty line and in circumstances beyond their control.',
          'Feed a Child is registered as a Public Benefit Organisation (PBO) under Section 18A (1)(a) and (1)(b)with the following Public Benefit Activities (PBA’s):'
        ],
        links: [
          '*  Food',
          '*  Sustainability',
          '*  Water',
          '*  Education',
          '*  Healthcare',
          '*  Medical Services',
        ]),
    VisualDto(
        image: null,
        title: 'The Meals on Wheels Family',
        author: 'N.O KHOZA',
        date: 'Jan 18',
        paragraphs: [
          'Meals on Wheels is a multi-faceted welfare non-profit organization tasked with helping poverty-stricken South Africans with nutritious meals and food security. Our aim is a hunger-free country, ensuring every elderly person and child can go to bed with a full tummy. To accomplish this enormous feat, we’ll need all the help we can get and would love you to get involved with us…',
          'Through countless efforts and generous donations from caring individuals and organizations, we have served over 31 million meals per annum. In addition to many other services, such as our Caregiver Service, Orphan Service, and Eco Garden Service, we have truly made a substantial difference in South Africa. Still, we are far from burying poverty forever. For that, we will need more help than ever before. Please take that pledge and help us make SA a hunger-free country.'
        ],
        links: [])
  ];
}

class NotificationData {
  List<VisualDto> notifications = [
    VisualDto(
        image: 'assets/images/logo1.png',
        title: "Feed a Child's Vision Donation",
        author: 'Man Ministries',
        date: 'Jan 01',
        paragraphs: [
          'Help Feed a Child make a difference  – Our vision is to eradicate poverty in a sustainable manner and to take God’s hope to the nations.',
          'As a National Body we assist other NGO’s to not only be as effective as possible, but also to become sustainable and economically active.',
          'Feed a Child currently has an impact on the lives of approximately 10 000 people on a regular basis. We have many projects  in the works and currently delivering meals to children throughout South Africa. It is estimated that almost 10% of the South African population are children of no particular culture or ethical group, living below the poverty line and in circumstances beyond their control.',
          'Feed a Child is registered as a Public Benefit Organisation (PBO) under Section 18A (1)(a) and (1)(b)with the following Public Benefit Activities (PBA’s):'
        ],
        links: [
          '*  Food',
          '*  Sustainability',
          '*  Water',
          '*  Education',
          '*  Healthcare',
          '*  Medical Services',
        ]),
    VisualDto(
        image: null,
        title: 'The Meals on Wheels Family Donation',
        author: 'Children Foundation',
        date: 'Jan 18',
        paragraphs: [
          'Meals on Wheels is a multi-faceted welfare non-profit organization tasked with helping poverty-stricken South Africans with nutritious meals and food security. Our aim is a hunger-free country, ensuring every elderly person and child can go to bed with a full tummy. To accomplish this enormous feat, we’ll need all the help we can get and would love you to get involved with us…',
          'Through countless efforts and generous donations from caring individuals and organizations, we have served over 31 million meals per annum. In addition to many other services, such as our Caregiver Service, Orphan Service, and Eco Garden Service, we have truly made a substantial difference in South Africa. Still, we are far from burying poverty forever. For that, we will need more help than ever before. Please take that pledge and help us make SA a hunger-free country.'
        ],
        links: [])
  ];
}

class EventData {
  CollectionReference eventsDb = FirebaseFirestore.instance.collection('event_db');
  List<VisualDto> events = [
    VisualDto(
        image: 'assets/images/logo1.png',
        title: "Night Prayer Service",
        author: 'Man Ministries',
        date: 'Jan 01',
        paragraphs: [
          'As a church, one of our core values is connecting with God through prayer and worship. It’s for this reason that the Wednesday Night Prayer Meeting is the most important service of the week! As a family of believers, we gather together to lift up needs in the church and around the world, believing God is going to move in mighty ways. Join us as we pray with faith that the Lord will help us in every area of our lives!',
          'Wednesday Night Prayer Meetings give us the incredible opportunity to come together as a church family and spend time in God’s presence. Every Wednesday night, we gather together for a time of prayer, worship, and to hear a powerful devotional message that strengthens our faith. Invite a friend and come early to grab a seat and pray before service begins. We can’t wait to see you!'
        ],
        links: [
          'Scriptures \n',
          '*  Matthew 11:28 \n Come to me, all you who are weary and burdened, and I will give you rest.',
          '*  I Corinthians 10:31 \n So whether you eat or drink or whatever you do, do it all for the glory of God.',
        ]),
    VisualDto(
        image: null,
        title: 'Sunday Service',
        author: 'Children Foundation',
        date: 'Jan 18',
        paragraphs: [
          'There’s a place for you with us at church.',
          'Church service times and schedules vary from congregation to congregation. Please call for specific times. All church meetings follow the same 2-hour format: one main meeting for everyone and one other class separated by age groups or general interests.',
          'What You Can Expect - If you\'re attending church for the first time, you may be a bit nervous. No worries; we\'re here for you! Here\'s what you can expect out of your visit.'
        ],
        links: [])
  ];
}
