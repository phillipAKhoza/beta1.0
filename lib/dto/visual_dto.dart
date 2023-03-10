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
