class JourneyDto {
  String title;
  List<JourneyTopicDto> journeyTopic;

  JourneyDto({required this.title, required this.journeyTopic});
}

class JourneyTopicDto {
  String topic;
  String scripture;
  List<String> verses;
  List<String> dailyThoughts;
  List<String> reflect;
  List<String> prayer;

  JourneyTopicDto({
    required this.topic,
    required this.scripture,
    required this.verses,
    required this.dailyThoughts,
    required this.reflect,
    required this.prayer,
  });
}

class JourneyData {
  List<JourneyDto> journey = [
    JourneyDto(
      title: "Salvation",
      journeyTopic: [
        JourneyTopicDto(
          topic: 'Baptism in Water',
          scripture: 'Matthew 3:13-16',
          verses: [
            'Then Jesus came from Galilee to John at the Jordan to be baptized by him. And John tried to prevent Him, saying, “I need to be baptized by You, and are You coming to me?” But Jesus answered and said to him, “Permit it to be so now, for thus it is fitting for us to fulfill all righteousness.”',
            'Then he allowed Him. When He had been baptized, Jesus came up immediately from the water; and behold, the heavens were opened to Him, and He saw the Spirit of God descending like a dove and alighting upon Him.'
          ],
          dailyThoughts: [
            'Matthew now introduces Jesus, the subject of his gospel, for the first time as an adult. When last we heard of Him in the gospel of Matthew, Jesus was a small child living in the disreputable town of Nazareth in Galilee (Matthew 2:19–23). His parents had settled there to keep their distance from Jerusalem and the region of Judea, where a former king had tried to kill Jesus as a baby (Matthew 2:13–16).',
            'Since Jesus arrives on the scene from Galilee at around 30 years old, most scholars assume that He had lived in Galilee up until this point in his life. He finds John preaching and baptizing somewhere along the Jordan River. Jesus wants John to baptize Him.',
            'We know from Luke that John and Jesus were extended family through their mothers; Mary and John\'s mother Elizabeth were related (Luke 1:36). Both men were born by the intervention of God. Jesus, of course, was conceived by the Holy Spirit, making Him the Son of God, the long-promised Messiah. John\'s birth was also predicted to his father, Zechariah, by an angel. This was despite the married couple being past the normal age of having children. The angel told Zechariah that John would do exactly the work Matthew has described of him so far. John would "make ready for the Lord a people prepared" (Luke 1:17).',
            'Now the Lord Jesus Christ and John meet face to face in an unexpected way. That is, John did not expect this request from Jesus.'
          ],
          prayer: [
            'Dear God,I come to You in the Name of Jesus. I admit that I am not right with You, and I want to be right with You. I ask You to forgive me of all my sins. The Bible says if I confess with my mouth that “Jesus is Lord,” and believe in my heart that God raised Him from the dead, I will be saved (Rom. 10:9). I believe with my heart and I confess with my mouth that Jesus is the Lord and Savior of my life. Thank You for saving me! In Jesus’ Name I pray. Amen.'
          ],
          reflect: [
            '*  Salvation is the "permission slip" to enter heaven when you leave this world.',
            '*  Salvation takes place when a person listens to the salvation message, believes it, and makes a decision to receive Jesus into his or her heart.'
          ],
        ),
        JourneyTopicDto(
          topic: 'Forgiven by God',
          scripture: 'Colossians 2:13-14 & Acts 26:18',
          verses: [
            'Colossians 2:13-14 — And you, being dead in your trespasses and the uncircumcision of your flesh, He has made alive together with Him, having forgiven you all trespasses, having wiped out the handwriting of requirements that was against us, which was contrary to us. And He has taken it out of the way, having nailed it to the cross.',
            'Acts 26:18 — to open their eyes, in order to turn them from darkness to light, and from the power of Satan to God, that they may receive forgiveness of sins and an inheritance among those who are sanctified by faith in Me.’'
          ],
          dailyThoughts: [
            'Paul notes the spiritual condition of the Colossian believers before Christ: They were both dead in their sins (Romans 6:23; Ephesians 2:5) and physically uncircumcised (Ephesians 2:11). These believers were clearly Gentiles, as they did not practice the Jewish ritual of circumcision. So, not only were they guilty of sin, as all men are (Romans 3:23), but they were not part of God\'s chosen people.',
            'Despite being sinners and uncircumcised Gentiles, God took action to forgive Christian believers, and to make them alive in Him, through Christ. Paul makes these two ideas into a direct contrast: first is being dead in trespasses and uncircumcised, the second is being alive in God and forgiven (Luke 11:4; 1 John 1:9). Paul has already mentioned forgiveness of sins in Colossians 1:14 and will again refer to the theme in Colossians 3:13. Forgiveness serves as one of the most powerful aspects of being a believer in Christ. A believer receives new life for eternity, while also experiencing a new quality of life today.',
            'Paul continues his explanation of this idea in verse 14.',
          ],
          prayer: [
            'Thank you Jesus, for all that you have done for me. I thank you that I am free from the power of the past and I can walk free today into the future You have obtained for me at the cross. Amen'
          ],
          reflect: [
            '*  God made you alive in Christ by forgiving your sins and canceling the charge sin had against you.',
            '*  In Jesus, by faith we undergo a change in legal status. Because of sin there was a charge against you.'
          ],
        )
      ],
    )
  ];
}
