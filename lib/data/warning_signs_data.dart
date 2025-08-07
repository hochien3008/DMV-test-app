import 'dart:math';
import '../models/answer_model.dart';
import '../models/question_model.dart';

final List<QuestionModel> warningSignsQuestions = [
  QuestionModel(
    id: 'w1',
    category: 'rules',
    text: 'What does this warning sign mean?',
    answers: [
      AnswerModel(text: 'Sharp turn ahead', isCorrect: true),
      AnswerModel(text: 'Speed bump', isCorrect: false),
      AnswerModel(text: 'Yield', isCorrect: false),
      AnswerModel(text: 'Stop', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w2',
    category: 'traffic',
    text: 'Temporary signs used in construction and maintenance work areas:',
    answers: [
      AnswerModel(
        text: 'Have a red background with green writing.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Have an orange background with black writing.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'Have a yellow background with blue writing',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w3',
    category: 'traffic',
    text: 'When driving on a slippery surface, such as snow or ice:',
    answers: [
      AnswerModel(
        text: 'Shirt to a low gear before going down sleep hills.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'Maintain traction by following other vehicles closely.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Pump your brakes to keep them from freezing.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w4',
    category: 'rules',
    text:
        'Unless otherwise posted, the speed limit on a country paved road is:',
    answers: [
      AnswerModel(text: '20 mph', isCorrect: false),
      AnswerModel(text: '30 mph', isCorrect: false),
      AnswerModel(text: '45 mph', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w5',
    category: 'rules',
    text: 'A diamond-shaped sign means: ',
    image: 'assets/images/signage/freeway/Frame 2.png',
    answers: [
      AnswerModel(text: 'Yield', isCorrect: false),
      AnswerModel(text: 'Stop', isCorrect: false),
      AnswerModel(text: 'Warning', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w5',
    category: 'rules',
    text: 'A red traffic signal indicates that approaching drivers should: ',
    answers: [
      AnswerModel(text: 'Come to a complete stop.', isCorrect: true),
      AnswerModel(
        text: 'Increase their speed to quickly clear the intersection.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Continue driving throught the intersection without stopping.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w6',
    category: 'rules',
    text:
        'Hydroplaning occurs when tires ride on a thin film of water instead of on the surface of the road. To prevent hydroplaning in rainy weather, you should: ',
    answers: [
      AnswerModel(
        text: 'Put on your cruise control to mantain a constant speed.',
        isCorrect: false,
      ),
      AnswerModel(text: 'Decrease your speed.', isCorrect: true),
      AnswerModel(
        text: 'Move to the shoulder of the road as soon as it starts to rain',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w7',
    category: 'rules',
    text: 'Driving more slowly than surrounding tracffic is: ',
    answers: [
      AnswerModel(text: 'A good idea if the weather is bad.', isCorrect: false),
      AnswerModel(
        text: 'Appropriate if you dont know the speed limit.',
        isCorrect: false,
      ),
      AnswerModel(
        text:
            'Often a hazard because other drivers may become frustrated and try to pass you',
        isCorrect: true,
      ),
    ],
  ),
  QuestionModel(
    id: 'w8',
    category: 'rules',
    text:
        'if you park facing uphill on a street with a curb, set the parking brake and: ',
    answers: [
      AnswerModel(
        text: 'Turn the front wheels toward the curb.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Turn the front wheels away from the curb.',
        isCorrect: true,
      ),
      AnswerModel(text: 'Leave the front wheels straight.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w9',
    category: 'traffic',
    text: 'What does a tracfic signal with a yellow left arrow indicate?',
    answers: [
      AnswerModel(
        text: 'Drivers should prepare to yield to oncoming traffic.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'The protected left turn is about to end.',
        isCorrect: false,
      ),
      AnswerModel(text: 'Both of the above.', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w10',
    category: 'rules',
    text: 'A solid yellow line on your side of the centerline means: ',
    answers: [
      AnswerModel(text: 'Reduce your speed', isCorrect: false),
      AnswerModel(text: 'Tracffic light ahead.', isCorrect: false),
      AnswerModel(text: 'Do not pass.', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w11',
    category: 'traffic',
    text: 'When driving in work zones, you should: ',
    answers: [
      AnswerModel(
        text:
            'Increase your speed to get through the zone as quickly as possible.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Reduce your speed and be prepared to stop suddenly.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'Maintain your normal speed the whole way throught the zone.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w12',
    category: 'rules',
    text: 'This road sign means: ',
    image: 'assets/images/signage/regulatory/Frame 3.png',
    answers: [
      AnswerModel(
        text: 'Cars in the right lane must slow down.',
        isCorrect: false,
      ),
      AnswerModel(text: 'No left turn.', isCorrect: false),
      AnswerModel(text: 'Merge', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w13',
    category: 'rules',
    text: 'This sign is a: ',
    image: 'assets/images/signage/regulatory/r1-2.png',
    answers: [
      AnswerModel(text: 'Yield sign', isCorrect: true),
      AnswerModel(text: 'School crossing sign', isCorrect: false),
      AnswerModel(text: 'stop sign', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w14',
    category: 'rules',
    text: 'This sign means: ',
    image: 'assets/images/signage/regulatory/r3-1.png',
    answers: [
      AnswerModel(text: 'No U-turn.', isCorrect: false),
      AnswerModel(text: 'No left turn.', isCorrect: false),
      AnswerModel(text: 'No right turn.', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w15',
    category: 'rules',
    text:
        'if your are driving a vehicle and are 21 years old or older, you are considered to be driving under the influence when your blood alcohol concentration(BAC) is: ',
    answers: [
      AnswerModel(text: '0.02 percent', isCorrect: false),
      AnswerModel(text: '0.04 percent', isCorrect: false),
      AnswerModel(text: '0.08 percent', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w16',
    category: 'rules',
    text:
        'if a truck or bus is making a right turn where you also need to make a right turn, you should: ',
    answers: [
      AnswerModel(
        text: 'Quickly turn before the truck or bus is able to.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Wait until the truck or bus turns before you turn.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'Squeeze between the truck or bus and the curb.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w17',
    category: 'rules',
    text:
        'Which of these statements is true about driving and taking medications?',
    answers: [
      AnswerModel(
        text: 'Most cold medications can make a person drowsy.',
        isCorrect: true,
      ),
      AnswerModel(
        text:
            'Over-the-counter medications cannot impair driving ability if taken in the recommended dosages.',
        isCorrect: false,
      ),
      AnswerModel(
        text:
            'Mediacations are safe to take at any time, if prescribed by a doctor.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w18',
    category: 'rules',
    text: 'Motorcycles are entitled to: ',
    answers: [
      AnswerModel(
        text: 'The same full lane width as other motor vehicles.',
        isCorrect: true,
      ),
      AnswerModel(text: 'The width of the sidewalk.', isCorrect: false),
      AnswerModel(text: 'One-half of the sidewalk.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w19',
    category: 'rules',
    text: 'This sign means: ',
    image: 'assets/images/signage/info/Frame 5.png',
    answers: [
      AnswerModel(text: 'Merge right', isCorrect: false),
      AnswerModel(text: 'Dividedhightway begins.', isCorrect: false),
      AnswerModel(text: 'Lane ends.', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w20',
    category: 'rules',
    text: 'Reaction time is slower after',
    answers: [
      AnswerModel(text: 'Drinking alcohol.', isCorrect: true),
      AnswerModel(text: 'Sleeping', isCorrect: false),
      AnswerModel(text: 'Working hard', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w21',
    category: 'rules',
    text:
        'You are halfway through the decelaration. When should you start reducing your speed?',
    answers: [
      AnswerModel(
        text: 'About halfway through the deceleration lane.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'As you approach the deceleration lane.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Immedialety upon entering the deceleration lane.',
        isCorrect: true,
      ),
    ],
  ),
  QuestionModel(
    id: 'w22',
    category: 'rules',
    text:
        'Which of these statements is true about drinking alcohol and driving? ',
    answers: [
      AnswerModel(
        text:
            'if you can walk in a straight line after drinking, it is safe to drive.',
        isCorrect: false,
      ),
      AnswerModel(
        text:
            'if you are under the legal blood alcohol concentration limit, your driving isnt impaired.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Alcohol affects judgement, which is needed to drive safely.',
        isCorrect: true,
      ),
    ],
  ),
  QuestionModel(
    id: 'w23 ',
    category: 'rules',
    text: 'Large trucks are likely to lose speed when:',
    answers: [
      AnswerModel(text: 'Driving up long or steep hills.', isCorrect: true),
      AnswerModel(text: 'Driving in long, gradual curves.', isCorrect: false),
      AnswerModel(text: 'Driving down long, gradual hills.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w24',
    category: 'rules',
    text: 'Blind sports are: ',
    answers: [
      AnswerModel(
        text: 'Sports in your vision when you become fatigued.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Areas of the road that cannot be seen in a vehicles mirrors.',
        isCorrect: true,
      ),
      AnswerModel(text: 'Tracffic control devices.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w25',
    category: 'rules',
    text: 'When changing lanes, you should never: ',
    answers: [
      AnswerModel(
        text: 'Cross the centerline in an intersection.',
        isCorrect: true,
      ),
      AnswerModel(
        text:
            'Check your blind sports by looking over your left or right shoulder.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Check for other drivers moving into the same line.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w26',
    category: 'rules',
    text: 'You must obey instructions from school crossing guards: ',
    answers: [
      AnswerModel(text: 'At all times.', isCorrect: true),
      AnswerModel(text: 'Only during school hours.', isCorrect: false),
      AnswerModel(
        text: 'Unless you do not see any children present.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w27',
    category: 'rules',
    text: 'Check your rearview mirrors: ',
    answers: [
      AnswerModel(
        text: 'Often to see how traffic is moving behind.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'To see if a vehicle is in your blind spot.',
        isCorrect: false,
      ),
      AnswerModel(text: 'Only when you are slowing down.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w28',
    category: 'rules',
    text: 'Night driving presents unique problems because: ',
    answers: [
      AnswerModel(
        text: 'The speed limit is increased at night.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'There are fewer cars on the roads at night.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Distance and vehicle speed are difficult to judge in the dark.',
        isCorrect: true,
      ),
    ],
  ),
  QuestionModel(
    id: 'w29',
    category: 'rules',
    text: 'When parking your vehicle on any hill: ',
    answers: [
      AnswerModel(
        text: 'One of your rear wheels should touch the curb.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Use your parking brake and leave the vehicle in "park."',
        isCorrect: true,
      ),
      AnswerModel(
        text:
            'Your front wheels should be parallel to the road, if there is no curb.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w30',
    category: 'rules',
    text:
        'If you park facing uphill where there is no curb, set the parking brake and: ',
    answers: [
      AnswerModel(
        text: 'Turn your wheels toward the edge of the road.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'Turn your wheels away from the edge of the road.',
        isCorrect: false,
      ),
      AnswerModel(text: 'keep your wheels facing straight.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w31',
    category: 'rules',
    text: 'When merging onto the freeway, you should be driving:',
    answers: [
      AnswerModel(
        text: 'At or near the speed of the freeway traffic.',
        isCorrect: true,
      ),
      AnswerModel(text: 'At the legal speed limit.', isCorrect: false),
      AnswerModel(
        text: 'More slowly than the freeway traffic.',
        isCorrect: false,
      ),
      AnswerModel(
        text:
            'You should enter a freeway at or near the speed of traffic, unless the speed of traffic exceeds the legal speed limit.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w32',
    category: 'rules',
    text:
        'Unless otherwise posted, the speed limit on a country paved road is: ',
    answers: [
      AnswerModel(text: '20 mph.', isCorrect: false),
      AnswerModel(text: '30 mph.', isCorrect: false),
      AnswerModel(text: '45 mph', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w33',
    category: 'rules',
    text: 'When entering traffic after being parked at a curb, you:',
    answers: [
      AnswerModel(
        text:
            'Should wait for a large enough gap to get up to the speed of traffic.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'Should drive more slowly than other traffic for 200 feet.',
        isCorrect: false,
      ),
      AnswerModel(
        text:
            'Should wait for the first two vehicles to pass, then drive into the lane.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w34',
    category: 'rules',
    text: 'While driving on a roadway with a single broken white centerline: ',
    answers: [
      AnswerModel(text: 'You must stay within your lane.', isCorrect: false),
      AnswerModel(
        text: 'You may cross the centerline to change lanes.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'You may change lanes only from the left lane.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w35',
    category: 'rules',
    text:
        ' If there is no crosswalk and you see a pedestrian crossing your lane, you should:',
    answers: [
      AnswerModel(
        text: 'Make sure the pedestrian can see you before proceeding.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Cautiously drive around the pedestrian.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Stop and let the pedestrian finish crossing.',
        isCorrect: true,
      ),
    ],
  ),
  QuestionModel(
    id: 'w36',
    category: 'rules',
    text: 'Which of the following statements is correct?',
    answers: [
      AnswerModel(text: 'Use your left foot to brake.', isCorrect: false),
      AnswerModel(
        text:
            'Use your right foot for both braking and accelerating your vehicle.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'You should always brake abruptly to ensure stopping.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w37',
    category: 'rules',
    text:
        'You are approaching an intersection at the posted speed limit when the signal turns yellow. You should:',
    answers: [
      AnswerModel(
        text: 'Slow down and proceed through the intersection without caution.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Speed up to cross the intersection before the light turns red.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Stop before entering the intersection, if you can do so safely.',
        isCorrect: true,
      ),
    ],
  ),
  QuestionModel(
    id: 'w38',
    category: 'rules',
    text: 'If you parallel park facing downward on a hill:',
    answers: [
      AnswerModel(
        text: 'Turn your wheels sharply toward the side of the road.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'Turn your wheels away from the side of the road.',
        isCorrect: false,
      ),
      AnswerModel(text: 'Keep your wheels straight.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w39',
    category: 'rules',
    text: 'When changing lanes, you should never:',
    answers: [
      AnswerModel(
        text: 'Look over your shoulder to check your blind spot. ',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Change lanes abruptly or spontaneously. ',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'Check for other vehicles moving into the same lane. ',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w40',
    category: 'rules',
    text:
        'You enter a designated turn lane to make a left turn at an upcoming intersection. There is oncoming traffic. You should:',
    answers: [
      AnswerModel(
        text: 'Move to the left of the center lane.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Signal before you arrive at the intersection.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'Turn your front wheels to the left to be prepared to turn.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w41',
    category: 'rules',
    text: 'A driver should:',
    answers: [
      AnswerModel(
        text: 'Assume all drivers automatically obey the right-of-way rules.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Assume most drivers obey the right-of-way rules.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Always be prepared to yield the right-of-way.',
        isCorrect: true,
      ),
    ],
  ),
  QuestionModel(
    id: 'w42',
    category: 'rules',
    text: 'Where is it safe to pass another vehicle?',
    answers: [
      AnswerModel(
        text: 'Within an intersection where there are no oncoming vehicles',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Wherever signs and/or pavement markings permit passing',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'Within a curve where there are no oncoming vehicles',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w43',
    category: 'rules',
    text:
        'Accruing ____ points on your license within a two-year period will result in suspension of your license for one year.',
    answers: [
      AnswerModel(text: '18 to 20', isCorrect: false),
      AnswerModel(text: '21 to 23', isCorrect: false),
      AnswerModel(text: '24 or more', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w44',
    category: 'rules',
    text: ' At a crosswalk:',
    answers: [
      AnswerModel(text: 'You must yield to pedestrians.', isCorrect: true),
      AnswerModel(text: 'Pedestrians must yield to you.', isCorrect: false),
      AnswerModel(
        text: 'Construction workers must yield to you.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w45',
    category: 'rules',
    text: 'Posters and signs on car windows:',
    answers: [
      AnswerModel(
        text: 'Are a fun way to personalize your vehicle.',
        isCorrect: false,
      ),
      AnswerModel(
        text:
            'Are prohibited by state law if they obstruct a drivers view of the road.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'Are allowed only if they do not contain offensive language. ',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w46',
    category: 'rules',
    text: 'If a tire suddenly blows out while you are driving, you should:',
    answers: [
      AnswerModel(
        text:
            'Grip the steering wheel firmly, slow down, and exit the traffic lane.',
        isCorrect: true,
      ),
      AnswerModel(text: 'Pump the brakes rapidly.', isCorrect: false),
      AnswerModel(
        text: 'Brake hard and steer toward the right edge of the roadway.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w47',
    category: 'rules',
    text: 'Which of these statements is true about large trucks?',
    answers: [
      AnswerModel(
        text: 'They take longer to stop than passenger vehicles.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'They all have air brakes that allow them to stop quickly.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'They are more maneuverable than passenger vehicles.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w48',
    category: 'rules',
    text:
        'Which of the following is not a safe driving practice when driving on the interstate?',
    answers: [
      AnswerModel(
        text: 'Slower traffic must keep to the right.',
        isCorrect: false,
      ),
      AnswerModel(text: 'Change lanes without signaling.', isCorrect: true),
      AnswerModel(
        text: 'If you miss your exit, you must go to the next exit.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w49',
    category: 'rules',
    text:
        'To turn left from a multilane one-way street onto a one-way street, you should start your turn from:',
    answers: [
      AnswerModel(text: 'Any lane (as long as it is safe).', isCorrect: false),
      AnswerModel(text: 'The lane closest to the left curb.', isCorrect: true),
      AnswerModel(
        text: 'The lane in the center of the road.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w50',
    category: 'rules',
    text:
        'When passing another car, you have enough space to return to the driving lane:',
    answers: [
      AnswerModel(
        text: 'If the other driver signals for you to re-enter the lane.',
        isCorrect: false,
      ),
      AnswerModel(
        text:
            'If you look over your shoulder and see the passed car behind you.',
        isCorrect: false,
      ),
      AnswerModel(
        text:
            'If you can see both of the passed vehicles headlights in your rearview mirror.',
        isCorrect: true,
      ),
    ],
  ),
  QuestionModel(
    id: 'w51',
    category: 'rules',
    text:
        'When stopped at a red traffic light with a green arrow, you may proceed in the direction of the arrow if you:',
    answers: [
      AnswerModel(text: 'First come to a complete stop.', isCorrect: false),
      AnswerModel(text: 'Wait until the light changes.', isCorrect: false),
      AnswerModel(
        text: 'Are in the proper lane and the intersection is clear.',
        isCorrect: true,
      ),
    ],
  ),
  QuestionModel(
    id: 'w52',
    category: 'rules',
    text: 'If a vehicle is equipped with airbags:',
    answers: [
      AnswerModel(text: 'Seat belts should still be worn.', isCorrect: true),
      AnswerModel(text: 'Seat belts do not need to be worn.', isCorrect: false),
      AnswerModel(
        text: 'Seat belts should be worn behind the back.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w53',
    category: 'rules',
    text: ' When passing another vehicle:',
    answers: [
      AnswerModel(
        text: 'Pass the vehicle as slowly as possible.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Drive at the same speed as the vehicle you are passing.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Pass the vehicle as safely and as quickly as possible.',
        isCorrect: true,
      ),
    ],
  ),
  QuestionModel(
    id: 'w54',
    category: 'rules',
    text: ' When turning left at an intersection:',
    answers: [
      AnswerModel(
        text: 'You should always yield to oncoming traffic and pedestrians.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'Oncoming traffic and pedestrians should yield to you.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'You should never yield to oncoming traffic and pedestrians.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w55',
    category: 'rules',
    text: 'Backing your vehicle is:',
    answers: [
      AnswerModel(text: 'Always dangerous.', isCorrect: true),
      AnswerModel(text: 'Dangerous if you have a helper.', isCorrect: false),
      AnswerModel(text: 'Only dangerous in large vehicles.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w56',
    category: 'rules',
    text: 'This sign means:',
    image: 'assets/images/signage/freeway/Frame 2.png',
    answers: [
      AnswerModel(text: 'Road construction/maintenance area.', isCorrect: true),
      AnswerModel(text: 'Side road.', isCorrect: false),
      AnswerModel(text: 'Railroad ahead.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w57',
    category: 'rules',
    text: 'A diamond-shaped sign means:',
    image: '/assets/images/signage/freeway/Frame 2.png',
    answers: [
      AnswerModel(text: 'Yield.', isCorrect: false),
      AnswerModel(text: 'Stop.', isCorrect: false),
      AnswerModel(text: 'Warning.', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w58',
    category: 'rules',
    text: 'This sign means:',
    answers: [
      AnswerModel(text: 'Pedestrian crossing.', isCorrect: true),
      AnswerModel(text: 'Side road.', isCorrect: false),
      AnswerModel(text: 'Railroad ahead.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w59',
    category: 'rules',
    text: 'A steady green traffic light at an intersection means:',
    answers: [
      AnswerModel(text: 'Increase your speed.', isCorrect: false),
      AnswerModel(text: 'Adjust your mirrors.', isCorrect: false),
      AnswerModel(
        text:
            'You may continue through the intersection at a safe and reasonable speed, if it is clear to do so.',
        isCorrect: true,
      ),
    ],
  ),
  QuestionModel(
    id: 'w60',
    category: 'rules',
    text:
        'When approaching an intersection that is controlled by a flashing red traffic signal, you must:',
    answers: [
      AnswerModel(
        text:
            'Come to a complete stop, yield to oncoming traffic or pedestrians, then proceed.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'Reduce your speed and proceed with caution.',
        isCorrect: false,
      ),
      AnswerModel(
        text:
            'Come to a complete stop and remain stopped as long as the light is red.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w61',
    category: 'rules',
    text: 'A solid yellow line on your side of the centerline means:',
    answers: [
      AnswerModel(text: 'Reduce your speed.', isCorrect: false),
      AnswerModel(text: 'Traffic light ahead.', isCorrect: false),
      AnswerModel(text: 'Do not pass.', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w62',
    category: 'rules',
    text: 'This sign is a:',
    answers: [
      AnswerModel(text: 'Yield sign.', isCorrect: true),
      AnswerModel(text: 'School crossing sign.', isCorrect: false),
      AnswerModel(text: 'Stop sign.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w63',
    category: 'rules',
    text: 'This sign means:',
    answers: [
      AnswerModel(text: 'No U-turn.', isCorrect: false),
      AnswerModel(text: 'No left turn.', isCorrect: false),
      AnswerModel(text: 'No right turn.', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w64',
    category: 'rules',
    text: 'What does a traffic signal with a yellow left arrow indicate?',
    answers: [
      AnswerModel(
        text: 'Drivers should prepare to yield to oncoming traffic.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'The protected left turn is about to end.',
        isCorrect: false,
      ),
      AnswerModel(text: 'Both of the above.', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w65',
    category: 'rules',
    text: 'This road sign means:',
    answers: [
      AnswerModel(
        text: 'Cars in the right lane must slow down.',
        isCorrect: false,
      ),
      AnswerModel(text: 'No left turn.', isCorrect: false),
      AnswerModel(text: 'Merge.', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w66',
    category: 'rules',
    text: 'This sign means:',
    answers: [
      AnswerModel(text: 'Merge right.', isCorrect: false),
      AnswerModel(text: 'Divided highway begins.', isCorrect: false),
      AnswerModel(text: 'Lane ends.', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w67',
    category: 'rules',
    text: 'A flashing red traffic light at an intersection means:',
    answers: [
      AnswerModel(text: 'The same thing as a yield sign.', isCorrect: false),
      AnswerModel(text: 'The light is about to turn green.', isCorrect: false),
      AnswerModel(text: 'The same thing as a stop sign.', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w68',
    category: 'rules',
    text:
        'When approaching an intersection with a flashing red light, you must:',
    answers: [
      AnswerModel(
        text:
            'Come to a complete stop, yield to oncoming traffic and pedestrians, then proceed.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'Reduce your speed and proceed with caution.',
        isCorrect: false,
      ),
      AnswerModel(
        text:
            'Come to a complete stop and remain stopped as long as the light is red.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w69',
    category: 'rules',
    text: 'This sign tells you that:',
    answers: [
      AnswerModel(text: 'No turns are allowed on the road.', isCorrect: false),
      AnswerModel(text: 'The road narrows ahead.', isCorrect: false),
      AnswerModel(text: 'There is a series of curves ahead.', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w70',
    category: 'rules',
    text: 'This sign means:',
    answers: [
      AnswerModel(text: 'Divided highway.', isCorrect: true),
      AnswerModel(text: 'Railroad warning.', isCorrect: false),
      AnswerModel(text: 'No passing zone.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w71',
      category: 'traffic',
    text: 'This sign means:',
    answers: [
      AnswerModel(text: 'Watch for bicycles.', isCorrect: true),
      AnswerModel(text: 'Bicycles not allowed.', isCorrect: false),
      AnswerModel(text: 'Bicycle repair shop ahead.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w72',
      category: 'traffic',
    text: 'This sign shows one type of:',
    answers: [
      AnswerModel(text: 'Right turn.', isCorrect: false),
      AnswerModel(text: 'Intersection.', isCorrect: true),
      AnswerModel(text: 'Lane change.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w73',
      category: 'traffic',
    text: 'Regulatory signs are:',
    answers: [
      AnswerModel(text: 'Green.', isCorrect: false),
      AnswerModel(text: 'Yellow.', isCorrect: false),
      AnswerModel(text: 'White.', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w74',
      category: 'traffic',
    text: 'This sign means:',
    answers: [
      AnswerModel(text: 'Do not enter.', isCorrect: false),
      AnswerModel(text: 'Stop ahead.', isCorrect: false),
      AnswerModel(text: 'Roadwork or maintenance is present.', isCorrect: true),
    ],
  ),
  QuestionModel(
      category: 'traffic',
    id: 'w75',
    text: 'This sign means:',
    answers: [
      AnswerModel(text: 'Trucks entering.', isCorrect: false),
      AnswerModel(text: 'Truck exit only.', isCorrect: false),
      AnswerModel(text: 'Steep downgrade ahead.', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w76',
      category: 'traffic',
    text:
        'You are coming to an intersection with a flashing red light. You should:',
    answers: [
      AnswerModel(
        text: 'Slow down and yield the right-of-way.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Slow down and drive carefully through the intersection.',
        isCorrect: false,
      ),
      AnswerModel(
        text:
            'Come to a complete stop, check the traffic, and go when it is safe to do so.',
        isCorrect: true,
      ),
    ],
  ),
  QuestionModel(
    id: 'w77',
      category: 'traffic',
    text: 'Which of these statements is true about roadwork zones?',
    answers: [
      AnswerModel(
        text:
            'Fines are the same for violations committed in work zones as they are under normal traffic conditions.',
        isCorrect: false,
      ),
      AnswerModel(text: 'You must "Slow for the Cone Zone."', isCorrect: true),
      AnswerModel(
        text: 'Slow down only if you think workers are present.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w78',
      category: 'traffic',
    text: 'Stopping distances and severity of crashes:',
    answers: [
      AnswerModel(
        text: 'Decrease as vehicle speed increases.',
        isCorrect: false,
      ),
      AnswerModel(text: 'Are not affected by vehicle speed.', isCorrect: false),
      AnswerModel(
        text: 'Increase as vehicle speed increases.',
        isCorrect: true,
      ),
    ],
  ),
  QuestionModel(
      category: 'traffic',
    id: 'w79',
    text: 'This sign means:',
    answers: [
      AnswerModel(
        text: 'You are approaching the end of a divided highway.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'You are approaching the beginning of a divided highway.',
        isCorrect: true,
      ),
      AnswerModel(text: 'The road will be slippery ahead.', isCorrect: false),
    ],
  ),
  QuestionModel(
      category: 'traffic',
    id: 'w80',
    text: 'This sign means:',
    answers: [
      AnswerModel(text: 'Yield sign ahead.', isCorrect: true),
      AnswerModel(text: 'Side road entering from left.', isCorrect: false),
      AnswerModel(text: 'Stop sign ahead.', isCorrect: false),
    ],
  ),
  QuestionModel(
      category: 'traffic',
    id: 'w81',
    text: 'This sign means:',
    answers: [
      AnswerModel(text: 'No U-turn.', isCorrect: true),
      AnswerModel(text: 'Traffic signal ahead.', isCorrect: false),
      AnswerModel(text: 'Railroad ahead.', isCorrect: false),
    ],
  ),
  QuestionModel(
      category: 'traffic',
    id: 'w82',
    text: 'This sign shows one type of:',
    answers: [
      AnswerModel(text: 'Intersection.', isCorrect: true),
      AnswerModel(text: 'Road curve.', isCorrect: false),
      AnswerModel(text: 'Right turn.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w83',
      category: 'traffic',
    text: 'This road sign means:',
    answers: [
      AnswerModel(text: 'School crossing.', isCorrect: false),
      AnswerModel(text: 'Pedestrian crossing.', isCorrect: true),
      AnswerModel(text: 'Jogging trail.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w84',
      category: 'traffic',
    text:
        'Various traffic control devices in construction and maintenance work areas are the color:',
    answers: [
      AnswerModel(text: 'Red.', isCorrect: false),
      AnswerModel(text: 'Orange.', isCorrect: true),
      AnswerModel(text: 'Yellow.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w85',
      category: 'traffic',
    text: 'When you see this road sign, you should:',
    answers: [
      AnswerModel(text: 'Keep right.', isCorrect: true),
      AnswerModel(text: 'Keep left.', isCorrect: false),
      AnswerModel(text: 'Pass with caution.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w86',
      category: 'traffic',
    text: 'This sign means:',
    answers: [
      AnswerModel(text: 'Slippery when wet.', isCorrect: true),
      AnswerModel(text: 'Stop sign ahead.', isCorrect: false),
      AnswerModel(text: 'No U-turn.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w87',
      category: 'traffic',
    text: 'This yellow sign means:',
    answers: [
      AnswerModel(text: 'One lane ahead.', isCorrect: false),
      AnswerModel(text: 'Merging traffic ahead.', isCorrect: true),
      AnswerModel(text: 'Lane ends ahead.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w88',
      category: 'traffic',
    text: 'This sign means:',
    answers: [
      AnswerModel(
        text: 'Trucks under 18,000 pounds are allowed.',
        isCorrect: false,
      ),
      AnswerModel(text: 'Hill ahead.', isCorrect: true),
      AnswerModel(text: 'Truck stop ahead.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w89',
      category: 'traffic',
    text: 'This sign means:',
    answers: [
      AnswerModel(text: 'Merge.', isCorrect: true),
      AnswerModel(text: 'Winding road ahead.', isCorrect: false),
      AnswerModel(
        text: 'Reserved parking for persons with disabilities.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w90',
      category: 'traffic',
    text: 'This sign indicates:',
    answers: [
      AnswerModel(
        text: 'The distance from road surface to a bridge or overpass.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'The maximum legal height of a vehicle allowed in this state.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'The maximum width of a vehicle allowed on the highway.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w91',
      category: 'traffic',
    text: 'This sign means:',
    answers: [
      AnswerModel(text: 'Cars on the right move first.', isCorrect: false),
      AnswerModel(text: 'You have the right-of-way.', isCorrect: false),
      AnswerModel(
        text: 'Let cross traffic pass before proceeding.',
        isCorrect: true,
      ),
    ],
  ),
  QuestionModel(
    id: 'w92',
      category: 'traffic',
    text: 'This white sign means:',
    answers: [
      AnswerModel(
        text:
            'The railroad crossing is controlled. Continue at your regular speed.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Look, listen, and prepare to stop at the crossing if necessary.',
        isCorrect: true,
      ),
      AnswerModel(
        text:
            'Stop at the railroad tracks and wait for a signal before crossing.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w93',
      category: 'traffic',
    text:
        'A steady yellow traffic signal light is a warning that the light is about to change to red. If you are already within the intersection when a green light changes to yellow, you should:',
    answers: [
      AnswerModel(text: 'Stop.', isCorrect: false),
      AnswerModel(
        text: 'Continue moving and clear the intersection safely.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'Increase your speed so as not to cause an accident.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w94',
      category: 'traffic',
    text: 'Fatigue increases the risk of:',
    answers: [
      AnswerModel(text: 'Missing an exit.', isCorrect: false),
      AnswerModel(text: 'Being late for an appointment.', isCorrect: false),
      AnswerModel(
        text: 'Falling asleep behind the wheel and crashing.',
        isCorrect: true,
      ),
    ],
  ),
  QuestionModel(
    id: 'w95',
      category: 'traffic',
    text: 'To prevent eye fatigue when driving at night, drivers should:',
    answers: [
      AnswerModel(text: 'Stare straight ahead.', isCorrect: false),
      AnswerModel(
        text: 'Continue moving their eyes and scanning the road.',
        isCorrect: true,
      ),
      AnswerModel(
        text:
            'Rest their eyes by closing them for a couple of seconds at a time.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w96',
      category: 'traffic',
    text: 'If the driver of an oncoming vehicle fails to dim their headlights:',
    answers: [
      AnswerModel(
        text: 'Look toward the center of the roadway.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Look toward the right side of the road.',
        isCorrect: true,
      ),
      AnswerModel(text: 'Look straight ahead.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w97',
      category: 'traffic',
    text: 'When driving behind another vehicle at night, you should:',
    answers: [
      AnswerModel(
        text: 'Keep your headlights on the low beam setting.',
        isCorrect: true,
      ),
      AnswerModel(
        text:
            'Use your high beam headlights until you are within 10 feet of the vehicle ahead.',
        isCorrect: false,
      ),
      AnswerModel(text: 'Use your high beam headlights.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w98',
      category: 'traffic',
    text:
        'A vehicle suddenly cuts in front of you, creating a hazard. What should you do first?',
    answers: [
      AnswerModel(text: 'Honk and step on the brake firmly.', isCorrect: false),
      AnswerModel(text: 'Take your foot off the gas pedal.', isCorrect: true),
      AnswerModel(text: 'Swerve into the lane next to you.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w99',
      category: 'traffic',
    text:
        'If you are about to be hit from the rear, you should consider each of the following, except for:',
    answers: [
      AnswerModel(text: 'Applying your brakes.', isCorrect: false),
      AnswerModel(text: 'Letting go of the steering wheel.', isCorrect: true),
      AnswerModel(
        text: 'Pressing your head firmly against the head restraint.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w100',
      category: 'traffic',
    text: 'Which of the following describes the thinking of defensive drivers?',
    answers: [
      AnswerModel(
        text: 'They know other drivers will do the right thing.',
        isCorrect: false,
      ),
      AnswerModel(
        text:
            'They consider what other drivers might do and are prepared to react.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'They expect no breaks and give none.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w101',
      category: 'traffic',
    text:
        'If you have an argument with another person and you are angry, you should:',
    answers: [
      AnswerModel(
        text:
            'Loudly play the radio while driving so you won’t think about your argument.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Take a few minutes to cool off before driving.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'Drive on the interstate to let off steam.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w102',
      category: 'traffic',
    text: 'If you find yourself in a skid:',
    answers: [
      AnswerModel(text: 'Brake lightly.', isCorrect: false),
      AnswerModel(text: 'Stay off the brakes.', isCorrect: true),
      AnswerModel(text: 'Brake abruptly.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w103',
      category: 'traffic',
    text: 'Which of the following statements about blind spots is true?',
    answers: [
      AnswerModel(
        text:
            'They are eliminated if you have one outside mirror on each side of the vehicle.',
        isCorrect: false,
      ),
      AnswerModel(
        text:
            'Large trucks have bigger blind spots than most passenger vehicles.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'Blind spots can be checked by looking in your rearview mirrors.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w104',
      category: 'traffic',
    text: 'When you are merging onto the freeway, you should be driving:',
    answers: [
      AnswerModel(
        text: 'At or near the speed of traffic on the freeway.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'Five to 10 mph slower than the speed of traffic on the freeway.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'The posted speed limit for freeway traffic.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w105',
    category: 'traffic',
    text: 'If you are about to be hit from the rear, you should not:',
    answers: [
      AnswerModel(text: 'Release your seat belt.', isCorrect: true),
      AnswerModel(text: 'Brace yourself.', isCorrect: false),
      AnswerModel(
        text: 'Press your head against the head restraint.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w106',
    category: 'traffic',
    text: 'As you approach the top of a hill, you should:',
    answers: [
      AnswerModel(text: 'Speed up slightly.', isCorrect: false),
      AnswerModel(text: 'Prepare to stop, if needed.', isCorrect: true),
      AnswerModel(text: 'Maintain a steady speed.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w107',
    category: 'rules',
    text: 'You should yield to a pedestrian:',
    answers: [
      AnswerModel(text: 'Only if they are in a crosswalk.', isCorrect: false),
      AnswerModel(
        text:
            'At all times, even if the pedestrian is not obeying traffic laws.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'Only if the traffic lights are in the pedestrian\'s favor.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w108',
    category: 'rules',
    text:
        'At dawn or dusk and in rain or snow, it can be hard to see and be seen. A good way to let other drivers know you are there is to turn:',
    answers: [
      AnswerModel(text: 'Up the instrumental panel lights.', isCorrect: false),
      AnswerModel(text: 'On your parking lights.', isCorrect: false),
      AnswerModel(text: 'On your headlights.', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w109',
    category: 'rules',
    text: 'To know where traffic is behind you:',
    answers: [
      AnswerModel(
        text: 'Frequently check your rearview mirror.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'Turn and look out your back window.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Keep other vehicles out of your blind spots.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w110',
    category: 'rules',
    text: 'In inclement weather, you should:',
    answers: [
      AnswerModel(text: 'Steer off the road.', isCorrect: false),
      AnswerModel(text: 'Drive in a low gear.', isCorrect: false),
      AnswerModel(text: 'Steer and brake smoothly.', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w111',
    category: 'rules',
    text:
        'When entering the interstate on a short entrance ramp where there is no acceleration lane, you should:',
    answers: [
      AnswerModel(
        text:
            'Immediately enter the far-right traffic lane on the interstate and speed up to match the flow of traffic.',
        isCorrect: false,
      ),
      AnswerModel(
        text:
            'Use the shoulder of the main road to get up to the speed of traffic.',
        isCorrect: false,
      ),
      AnswerModel(
        text:
            'Speed up and enter the interstate only after you have identified a gap in traffic.',
        isCorrect: true,
      ),
    ],
  ),
  QuestionModel(
    id: 'w112',
    category: 'rules',
    text:
        'If your vehicle starts to lose traction because of water on the road, you should:',
    answers: [
      AnswerModel(
        text: 'Drive at a constant speed to gain better traction.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Apply the brakes firmly to prevent your vehicle from sliding.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Slow down gradually and not apply the brakes.',
        isCorrect: true,
      ),
    ],
  ),
  QuestionModel(
    id: 'w113',
    category: 'rules',
    text:
        'When entering the interstate, check for a gap in traffic in the nearest lane, adjust your speed to match traffic, signal, and:',
    answers: [
      AnswerModel(
        text:
            'Expect traffic to allow you to proceed into the lane, since you have the right-of-way.',
        isCorrect: false,
      ),
      AnswerModel(text: 'Merge carefully into the gap.', isCorrect: true),
      AnswerModel(
        text: 'Wait for the lane to clear before merging.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w114',
    category: 'rules',
    text: 'Which of the following road surfaces freezes first?',
    answers: [
      AnswerModel(text: 'A tunnel', isCorrect: false),
      AnswerModel(text: 'An intersection', isCorrect: false),
      AnswerModel(text: 'A bridge', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w115',
    category: 'rules',
    text:
        'In a vehicle equipped with airbags, the safest place for children age 12 and under to ride is in:',
    answers: [
      AnswerModel(text: 'The front seat.', isCorrect: false),
      AnswerModel(text: 'The back seat.', isCorrect: true),
      AnswerModel(text: 'The bed of a pick-up truck.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w116',
    category: 'rules',
    text:
        'What should you do when approaching a pedestrian who is being led by a guide dog or using a white cane?',
    answers: [
      AnswerModel(
        text: 'Honk so they know to clear the way.',
        isCorrect: false,
      ),
      AnswerModel(text: 'Yield the right-of-way.', isCorrect: true),
      AnswerModel(text: 'Swerve quickly around them.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w117',
    category: 'rules',
    text:
        'A large truck is ahead of you and is turning right onto a street with two lanes in each direction. The truck:',
    answers: [
      AnswerModel(
        text: 'May complete its turn in either of the two lanes.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'May have to swing wide to complete the right turn.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'Must stay in the right lane at all times while turning.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w118',
    category: 'rules',
    text:
        'If you want to enter the freeway but you don\'t see a gap in traffic, you should:',
    answers: [
      AnswerModel(
        text:
            'Maintain your speed and force the other drivers to create a gap.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Slow down on the ramp to wait for a gap.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'Stop at the end of the ramp to wait for a gap.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w119',
    category: 'rules',
    text:
        'When driving on an interstate, to avoid traffic merging from on-ramps to your right, the best thing to do is to:',
    answers: [
      AnswerModel(text: 'Change lanes to the left.', isCorrect: true),
      AnswerModel(text: 'Slow down.', isCorrect: false),
      AnswerModel(text: 'Maintain your speed and position.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w120',
    category: 'rules',
    text: 'When a gate at a railroad crossing is lowering, you should:',
    answers: [
      AnswerModel(
        text:
            'Speed up and cross the tracks before the gate lowers completely.',
        isCorrect: false,
      ),
      AnswerModel(text: 'Come to a complete stop and wait.', isCorrect: true),
      AnswerModel(text: 'Drive around the gate.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w121',
    category: 'rules',
    text: 'If a tire blows out, you should:',
    answers: [
      AnswerModel(text: 'Apply the brake and hold it.', isCorrect: false),
      AnswerModel(
        text: 'Hold the steering wheel tightly and use the brakes lightly.',
        isCorrect: true,
      ),
      AnswerModel(text: 'Pull over quickly.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w122',
    category: 'rules',
    text: '"No zones" are areas around trucks where cars:',
    answers: [
      AnswerModel(
        text:
            'Disappear into blind spots or are so close that they restrict the truck driver\'s ability to stop and maneuver safely.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'Have sufficient space to travel behind the truck.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Have several car lengths between their vehicle and the truck.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w123',
    category: 'rules',
    text:
        'If a truck or bus is making a right turn where you also need to make a right turn, you should:',
    answers: [
      AnswerModel(
        text: 'Quickly turn before the truck or bus is able to.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Wait until the truck or bus turns before you turn.',
        isCorrect: true,
      ),
      AnswerModel(
        text: 'Squeeze between the truck or bus and the curb.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w124',
    category: 'rules',
    text:
        'Children on bicycles should be given extra space by motor vehicle operators because:',
    answers: [
      AnswerModel(
        text: 'They do not have the same physical reflexes as adults.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'They are smaller and more difficult to see than adults.',
        isCorrect: false,
      ),
      AnswerModel(text: 'Both of the above.', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w125',
    category: 'rules',
    text: 'Motorcycles are entitled to:',
    answers: [
      AnswerModel(
        text: 'The same full lane width as other motor vehicles.',
        isCorrect: true,
      ),
      AnswerModel(text: 'The width of the sidewalk.', isCorrect: false),
      AnswerModel(text: 'One-half of the width of a lane.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w126',
    category: 'rules',
    text:
        'If you approach a stopped school bus that has its lights flashing and signal arm extended, you should:',
    answers: [
      AnswerModel(text: 'Stop.', isCorrect: true),
      AnswerModel(
        text: 'Proceed at 15 mph if no children are present.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Proceed at normal speed, but watch for children.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w127',
    category: 'rules',
    text: 'When used on roadways, bicycles are considered:',
    answers: [
      AnswerModel(text: 'Hazards.', isCorrect: false),
      AnswerModel(text: 'Vehicles.', isCorrect: true),
      AnswerModel(text: 'Dangerous.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w128',
    category: 'rules',
    text:
        'If you want to pass a pedestrian who is walking along the roadway and an oncoming vehicle is approaching, you should:',
    answers: [
      AnswerModel(
        text:
            'Slow down and let the oncoming vehicle pass before you pass the pedestrian.',
        isCorrect: true,
      ),
      AnswerModel(
        text:
            'Keep driving at a steady speed. The oncoming vehicle must stop for you.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Honk your horn to get the pedestrian to move over.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w129',
    category: 'rules',
    text:
        'To improve visibility lowered by rain or fog, drivers should use their:',
    answers: [
      AnswerModel(text: 'Low beam headlights.', isCorrect: true),
      AnswerModel(text: 'High beam headlights.', isCorrect: false),
      AnswerModel(text: 'Parking lights.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w130',
    category: 'rules',
    text:
        'What should you do when approaching a pedestrian who is being led by a guide dog or using a white cane?',
    answers: [
      AnswerModel(
        text: 'Honk so they know to clear the way.',
        isCorrect: false,
      ),
      AnswerModel(text: 'Yield the right-of-way.', isCorrect: true),
      AnswerModel(text: 'Swerve quickly around them.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w131',
    category: 'rules',
    text: 'You see pedestrians near the road. You should:',
    answers: [
      AnswerModel(
        text: 'Sound your horn and maintain your speed.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Speed up to clear the area quickly.',
        isCorrect: false,
      ),
      AnswerModel(text: 'Slow down and pass with caution.', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w132',
    category: 'rules',
    text:
        'There is no crosswalk and you see a pedestrian crossing your lane ahead. You should:',
    answers: [
      AnswerModel(
        text: 'Make eye contact with and then pass the pedestrian.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Slow down as you pass the pedestrian.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Stop and let the pedestrian finish crossing the street.',
        isCorrect: true,
      ),
    ],
  ),
  QuestionModel(
    id: 'w133',
    category: 'rules',
    text: 'A broken yellow centerline means that:',
    answers: [
      AnswerModel(text: 'Passing is not permitted.', isCorrect: false),
      AnswerModel(
        text: 'Passing on the right is permitted when the way ahead is clear.',
        isCorrect: false,
      ),
      AnswerModel(
        text: 'Passing on the left is permitted when the way ahead is clear.',
        isCorrect: true,
      ),
    ],
  ),
  QuestionModel(
    id: 'w134',
    category: 'rules',
    text: 'Alcohol is:',
    answers: [
      AnswerModel(text: 'A stimulant.', isCorrect: false),
      AnswerModel(text: 'An antihistamine.', isCorrect: false),
      AnswerModel(text: 'A depressant.', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w135',
    category: 'rules',
    text:
        'As the percentage of alcohol (BAC) in your blood increases, you become:',
    answers: [
      AnswerModel(text: 'More intoxicated.', isCorrect: true),
      AnswerModel(text: 'More sober.', isCorrect: false),
      AnswerModel(text: 'More coordinated.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w136',
    category: 'rules',
    text:
        'If you are driving a vehicle and are 21 years old or older, you are considered to be driving under the influence when your blood alcohol concentration (BAC) is:',
    answers: [
      AnswerModel(text: '0.02 percent.', isCorrect: false),
      AnswerModel(text: '0.04 percent.', isCorrect: false),
      AnswerModel(text: '0.08 percent.', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w137',
    category: 'rules',
    text: 'Reaction time is slower after:',
    answers: [
      AnswerModel(text: 'Drinking alcohol.', isCorrect: true),
      AnswerModel(text: 'Sleeping.', isCorrect: false),
      AnswerModel(text: 'Working hard.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w138',
    category: 'rules',
    text:
        'Which of these statements is true about driving and taking medications?',
    answers: [
      AnswerModel(
        text: 'Most cold medications can make a person drowsy.',
        isCorrect: true,
      ),
      AnswerModel(
        text:
            'Over-the-counter medications cannot impair driving ability if taken in the recommended dosages.',
        isCorrect: false,
      ),
      AnswerModel(
        text:
            'Medications are safe to take at any time, if prescribed by a doctor.',
        isCorrect: false,
      ),
    ],
  ),
  QuestionModel(
    id: 'w139',
    category: 'rules',
    text: 'What is the only effective way to remove alcohol from the body?',
    answers: [
      AnswerModel(text: 'Drink strong coffee.', isCorrect: false),
      AnswerModel(text: 'Wait.', isCorrect: true),
      AnswerModel(text: 'Take a cold shower.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w140',
    category: 'rules',
    text:
        'Your license can be suspended if you are under 21 and drive with a blood alcohol level of:',
    answers: [
      AnswerModel(text: '0.15 percent or more.', isCorrect: false),
      AnswerModel(text: '0.08 percent or more.', isCorrect: false),
      AnswerModel(text: 'Any amount.', isCorrect: true),
    ],
  ),
  QuestionModel(
    id: 'w141',
    category: 'rules',
    text: 'Alcohol in any concentration is:',
    answers: [
      AnswerModel(text: 'A stimulant.', isCorrect: false),
      AnswerModel(text: 'A depressant.', isCorrect: true),
      AnswerModel(text: 'Neither of the above.', isCorrect: false),
    ],
  ),
  QuestionModel(
    id: 'w142',
    category: 'rules',
    text:
        'Which of the following factors affect an individual\'s absorption of alcohol?',
    answers: [
      AnswerModel(text: 'Weight', isCorrect: true),
      AnswerModel(text: 'Height', isCorrect: false),
      AnswerModel(text: 'Intelligence', isCorrect: false),
    ],
  ), // <-- Đóng đúng mỗi câu hỏi
]; // <-- Đóng mảng

// Hàm lấy ngẫu nhiên 50 câu hỏi cho phần Exam
List<QuestionModel> getRandomExamQuestions({int count = 50}) {
  final random = Random();
  final questions = List<QuestionModel>.from(warningSignsQuestions)
    ..shuffle(random);
  return questions.take(count).toList();
}

// Ví dụ sử dụng: lấy 1 đề thi 50 câu hỏi ngẫu nhiên
final List<QuestionModel> examQuestions = getRandomExamQuestions();

List<QuestionModel> rulesQuestions = warningSignsQuestions
    .where((q) => q.category == 'rules')
    .toList();
List<QuestionModel> trafficQuestions = warningSignsQuestions
    .where((q) => q.category == 'traffic')
    .toList();
List<QuestionModel> defensiveQuestions = warningSignsQuestions
    .where((q) => q.category == 'defensive')
    .toList();
List<QuestionModel> specialQuestions = warningSignsQuestions
    .where((q) => q.category == 'special')
    .toList();
List<QuestionModel> sharingQuestions = warningSignsQuestions
    .where((q) => q.category == 'sharing')
    .toList();
List<QuestionModel> alcoholQuestions = warningSignsQuestions
    .where((q) => q.category == 'alcohol')
    .toList();
