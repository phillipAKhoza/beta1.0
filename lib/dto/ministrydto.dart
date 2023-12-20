import 'package:cloud_firestore/cloud_firestore.dart';

class Ministries {
  String church;
  List<String> address;
  List<String>? paragraphs;
  String leaders;
  List<String> contacts;

  Ministries(
      {required this.church,
      required this.address,
      required this.contacts,
      this.paragraphs,
      required this.leaders});
}

class MinistriesData {
  CollectionReference ministriesDb = FirebaseFirestore.instance.collection('ministry_db');
  List<Ministries> ministries = [
    Ministries(
      church: "MAN",
      address: ['961 Block H', 'Soshanguve-H', '0152'],
      contacts: ["Phone: 0000000000", "EMail: email@gmail.com"],
      paragraphs: [
        'Every congregation has a unique profile and unique gifts that cannot be measured simply by counting heads. UAFC HOPE to You Church is committed to playing its role; serving our local communities as we seek to provide answers and hope that only Christ-centered care and the message of Jesus can bring. Countless stories of lives being uplifted, relationships restored and personal transformation have followed us.',
        'We are incredibly thankful for the volunteers who serve in our churches and communities each week. Those who serve in children’s ministry, youth ministry, women ministry, worship, pastoral care and our community care programs including outreach programs and evangelism.',
        'We serve an amazing and awesome God! The journey of our Church gives witness to the mighty hand of God. Instead of gazing endlessly into the past, it is our desire for God to continue His mighty work in and through our Church. Our relationship with Him is never static and does not cease with our past experiences. Finally, in all of the challenges and possibilities that confront us, the church is not staff, buildings or budgets; it is people – you and me – called and gifted by God, all of us unique and all of us needed. Let us trust God and do the ministry which God has entrusted to us'
      ],
      leaders: 'Pst ABC and DEF',
    ),
    Ministries(
      church: "WOMAN",
      address: ['961 Block H', 'Soshanguve-H', '0152'],
      contacts: ["Phone: 0000000000", "EMail: email@gmail.com"],
      paragraphs: [
        'Every congregation has a unique profile and unique gifts that cannot be measured simply by counting heads. UAFC HOPE to You Church is committed to playing its role; serving our local communities as we seek to provide answers and hope that only Christ-centered care and the message of Jesus can bring. Countless stories of lives being uplifted, relationships restored and personal transformation have followed us.',
        'We are incredibly thankful for the volunteers who serve in our churches and communities each week. Those who serve in children’s ministry, youth ministry, women ministry, worship, pastoral care and our community care programs including outreach programs and evangelism.',
        'We serve an amazing and awesome God! The journey of our Church gives witness to the mighty hand of God. Instead of gazing endlessly into the past, it is our desire for God to continue His mighty work in and through our Church. Our relationship with Him is never static and does not cease with our past experiences. Finally, in all of the challenges and possibilities that confront us, the church is not staff, buildings or budgets; it is people – you and me – called and gifted by God, all of us unique and all of us needed. Let us trust God and do the ministry which God has entrusted to us'
      ],
      leaders: 'Apostole ABC and DEF',
    ),
    Ministries(
      church: "YOUTH",
      address: ['961 Block H', 'Soshanguve-H', '0152'],
      contacts: ["Phone: 0000000000", "EMail: email@gmail.com"],
      paragraphs: [
        'Every congregation has a unique profile and unique gifts that cannot be measured simply by counting heads. UAFC HOPE to You Church is committed to playing its role; serving our local communities as we seek to provide answers and hope that only Christ-centered care and the message of Jesus can bring. Countless stories of lives being uplifted, relationships restored and personal transformation have followed us.',
        'We are incredibly thankful for the volunteers who serve in our churches and communities each week. Those who serve in children’s ministry, youth ministry, women ministry, worship, pastoral care and our community care programs including outreach programs and evangelism.',
        'We serve an amazing and awesome God! The journey of our Church gives witness to the mighty hand of God. Instead of gazing endlessly into the past, it is our desire for God to continue His mighty work in and through our Church. Our relationship with Him is never static and does not cease with our past experiences. Finally, in all of the challenges and possibilities that confront us, the church is not staff, buildings or budgets; it is people – you and me – called and gifted by God, all of us unique and all of us needed. Let us trust God and do the ministry which God has entrusted to us'
      ],
      leaders: 'Pst ABC and DEF',
    ),
  ];
}
