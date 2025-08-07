import '../services/question_service.dart';

class QuestionLoader {
  static final QuestionService _questionService = QuestionService();

  // Load bộ câu hỏi mẫu cho tất cả categories
  static Future<void> loadSampleQuestions() async {
    try {
      final questionService = QuestionService();

      // Load Unit 1: Rules of the Road
      await _loadUnit1Questions(questionService);

      // Load Unit 2: Traffic Control
      await _loadUnit2Questions(questionService);

      // Load Unit 3: Defensive Driving
      await _loadUnit3Questions(questionService);

      // Load Unit 4: Special Driving Situations
      await _loadUnit4Questions(questionService);

      // Load Unit 5: Sharing the Road
      await _loadUnit5Questions(questionService);

      // Load Unit 6: Alcohol and Drugs
      await _loadUnit6Questions(questionService);
    } catch (e) {
      // Error loading questions
    }
  }

  // Unit 1: Rules of the Road
  static Future<void> _loadUnit1Questions(
    QuestionService questionService,
  ) async {
    final questions = [
      // Set 1: Basics – Recognizing traffic laws (3 questions)
      {
        'questionText': 'The speed limit in residential areas is usually:',
        'answers': [
          {'text': '25 mph', 'is_correct': true},
          {'text': '35 mph', 'is_correct': false},
          {'text': '45 mph', 'is_correct': false},
        ],
        'explanation':
            'The speed limit in residential areas is typically 25 mph for safety.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'When you see a "STOP" sign, you must:',
        'answers': [
          {'text': 'Slow down', 'is_correct': false},
          {'text': 'Stop completely', 'is_correct': true},
          {
            'text': 'Continue if you don\'t see any vehicles',
            'is_correct': false,
          },
        ],
        'explanation': 'STOP signs require a complete stop before proceeding.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'A red light means:',
        'answers': [
          {'text': 'Turn right if there are no vehicles', 'is_correct': false},
          {'text': 'Stop completely', 'is_correct': true},
          {'text': 'Stop for only 3 seconds', 'is_correct': false},
        ],
        'explanation':
            'Red traffic lights mean you must stop completely until the light changes.',
        'difficultyLevel': 1,
      },

      // Set 2: Basics – Intersections and turns (4 questions)
      {
        'questionText':
            'When you want to turn right at an intersection with a red light, you must:',
        'answers': [
          {'text': 'Turn immediately', 'is_correct': false},
          {'text': 'Stop first, look, then turn', 'is_correct': true},
          {'text': 'Honk and turn', 'is_correct': false},
        ],
        'explanation':
            'Right turns on red require a complete stop first, then proceed when safe.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'Who has the right of way at an intersection without a sign?',
        'answers': [
          {'text': 'Vehicle on the left', 'is_correct': false},
          {'text': 'Vehicle on the right', 'is_correct': true},
          {'text': 'Larger vehicle', 'is_correct': false},
        ],
        'explanation':
            'At uncontrolled intersections, the vehicle on the right has the right of way.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'When turning left from a two-way street, you should:',
        'answers': [
          {'text': 'Turn from the right lane', 'is_correct': false},
          {'text': 'Turn from the middle lane', 'is_correct': false},
          {
            'text': 'Turn from the lane near the center line',
            'is_correct': true,
          },
        ],
        'explanation':
            'Left turns should be made from the lane closest to the center line.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'To pass the vehicle in front, you must:',
        'answers': [
          {'text': 'Signal and pass on the left', 'is_correct': true},
          {'text': 'Signal and pass on the right', 'is_correct': false},
          {'text': 'Flash your lights and pass', 'is_correct': false},
        ],
        'explanation':
            'Passing should be done on the left after signaling your intention.',
        'difficultyLevel': 1,
      },

      // Set 3: Easy – Stop, yield, park (5 questions)
      {
        'questionText': 'When yielding to pedestrians at a crosswalk:',
        'answers': [
          {'text': 'Slow down', 'is_correct': false},
          {'text': 'Stop completely', 'is_correct': true},
          {'text': 'Honk to let them pass', 'is_correct': false},
        ],
        'explanation':
            'You must stop completely for pedestrians in crosswalks.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'Stopping on a steep, high curb:',
        'answers': [
          {'text': 'Turn the wheels toward the curb', 'is_correct': true},
          {'text': 'Turn the wheels toward the road', 'is_correct': false},
          {'text': 'Keep the wheels straight', 'is_correct': false},
        ],
        'explanation':
            'When parking on a hill, turn wheels toward the curb to prevent rolling.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When you see a school bus stop and turn on the red light:',
        'answers': [
          {'text': 'Continue going', 'is_correct': false},
          {'text': 'Stop in both directions', 'is_correct': true},
          {'text': 'Slow down and watch close', 'is_correct': false},
        ],
        'explanation':
            'All traffic must stop when a school bus has flashing red lights.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'When backing out onto the road, you must:',
        'answers': [
          {'text': 'Look in the rearview mirror', 'is_correct': false},
          {'text': 'Honk and back up', 'is_correct': false},
          {'text': 'Look directly over your shoulder', 'is_correct': true},
        ],
        'explanation':
            'When backing up, look directly over your shoulder to see behind you.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When stopping at an intersection with a red light and wanting to turn left, you:',
        'answers': [
          {
            'text': 'Wait for the green light and then turn',
            'is_correct': true,
          },
          {'text': 'Turn if there is no car', 'is_correct': false},
          {'text': 'No need to stop if it is empty', 'is_correct': false},
        ],
        'explanation':
            'Left turns on red are generally not allowed unless specifically permitted.',
        'difficultyLevel': 1,
      },

      // Set 4: Average - Speed & Signs (6 questions)
      {
        'questionText': 'The maximum speed on a highway is usually:',
        'answers': [
          {'text': '55 mph', 'is_correct': true},
          {'text': '45 mph', 'is_correct': false},
          {'text': '65 mph', 'is_correct': false},
        ],
        'explanation':
            'The typical maximum speed on highways is 55 mph unless otherwise posted.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When you see a "YIELD" sign, you must:',
        'answers': [
          {'text': 'Stop completely', 'is_correct': false},
          {'text': 'Yield if necessary', 'is_correct': true},
          {'text': 'Continue without looking', 'is_correct': false},
        ],
        'explanation':
            'YIELD signs mean you must slow down and yield to other traffic if necessary.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When turning left in an intersection, you should yield to:',
        'answers': [
          {'text': 'Oncoming vehicles going straight', 'is_correct': true},
          {'text': 'Pedestrians on the right', 'is_correct': false},
          {'text': 'Vehicles behind', 'is_correct': false},
        ],
        'explanation':
            'Left turns must yield to oncoming traffic going straight.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'The red octagonal sign is:',
        'answers': [
          {'text': 'Warning', 'is_correct': false},
          {'text': 'STOP', 'is_correct': true},
          {'text': 'YIELD', 'is_correct': false},
        ],
        'explanation': 'Red octagonal signs are STOP signs.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When changing lanes, you must turn on your turn signal:',
        'answers': [
          {'text': '100 feet before changing', 'is_correct': true},
          {'text': 'Immediately upon starting', 'is_correct': false},
          {'text': 'After changing', 'is_correct': false},
        ],
        'explanation':
            'Turn signals should be activated at least 100 feet before changing lanes.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'If the speed limit sign is 50 mph but the road is slippery, you should:',
        'answers': [
          {'text': 'Stay at 50 mph', 'is_correct': false},
          {'text': 'Speed up and pass quickly', 'is_correct': false},
          {'text': 'Drive slower', 'is_correct': true},
        ],
        'explanation':
            'When road conditions are poor, drive slower than the posted speed limit.',
        'difficultyLevel': 2,
      },

      // Set 5: Moderate – Dangerous & the law of reflexes (6 questions)
      {
        'questionText': 'When another vehicle is tailgating, you should:',
        'answers': [
          {'text': 'Brake hard', 'is_correct': false},
          {'text': 'Speed up', 'is_correct': false},
          {
            'text': 'Increase the distance from the vehicle in front',
            'is_correct': true,
          },
        ],
        'explanation':
            'When being tailgated, increase your following distance to allow more reaction time.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When encountering an intersection with no lights, you should:',
        'answers': [
          {'text': 'See who comes first', 'is_correct': false},
          {'text': 'Stop as if there is a STOP sign', 'is_correct': true},
          {
            'text': 'Continue if you do not see the vehicle',
            'is_correct': false,
          },
        ],
        'explanation':
            'At uncontrolled intersections, treat it as if there are STOP signs.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When you see a flashing yellow light, you should:',
        'answers': [
          {'text': 'Stop immediately', 'is_correct': false},
          {'text': 'Slow down and pass carefully', 'is_correct': true},
          {'text': 'Pass quickly', 'is_correct': false},
        ],
        'explanation': 'Flashing yellow lights mean proceed with caution.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When meeting a vehicle emergency siren, you should:',
        'answers': [
          {'text': 'Stop in the middle of the road', 'is_correct': false},
          {'text': 'Back up', 'is_correct': false},
          {'text': 'Move to the right side and stop', 'is_correct': true},
        ],
        'explanation':
            'When emergency vehicles approach, pull to the right and stop.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'If you miss a turn on the freeway:',
        'answers': [
          {'text': 'Turn around', 'is_correct': false},
          {'text': 'Continue to the next exit', 'is_correct': true},
          {'text': 'Stop immediately', 'is_correct': false},
        ],
        'explanation':
            'Never back up on a freeway. Continue to the next exit and turn around.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When the car skids, you should:',
        'answers': [
          {'text': 'Brake hard', 'is_correct': false},
          {
            'text': 'Turn the steering wheel in the direction of the skid',
            'is_correct': true,
          },
          {'text': 'Accelerate to maintain balance', 'is_correct': false},
        ],
        'explanation':
            'When skidding, steer in the direction you want the car to go.',
        'difficultyLevel': 2,
      },

      // Set 6: Medium – Turning, changing lanes, priority lanes (7 questions)
      {
        'questionText': 'When entering a freeway, you must:',
        'answers': [
          {'text': 'Stop before entering', 'is_correct': false},
          {
            'text': 'Enter directly regardless of other vehicles',
            'is_correct': false,
          },
          {
            'text': 'Accelerate in the merging lane and then enter when safe',
            'is_correct': true,
          },
        ],
        'explanation':
            'When entering a freeway, accelerate to match traffic speed and merge safely.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When turning left at an intersection with a green light, you must:',
        'answers': [
          {'text': 'Give priority to turning', 'is_correct': false},
          {'text': 'Let oncoming vehicles go straight', 'is_correct': true},
          {
            'text': 'Turn immediately if there are no pedestrians',
            'is_correct': false,
          },
        ],
        'explanation':
            'Left turns must yield to oncoming traffic going straight.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'Sudden lane changes can cause:',
        'answers': [
          {'text': 'Minor errors', 'is_correct': false},
          {'text': 'Serious accidents', 'is_correct': true},
          {'text': 'No problem if there are no vehicles', 'is_correct': false},
        ],
        'explanation':
            'Sudden lane changes are dangerous and can cause serious accidents.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When stuck in traffic at an intersection, you should:',
        'answers': [
          {'text': 'Try to cross quickly', 'is_correct': false},
          {
            'text': 'Wait for the traffic ahead to clear before entering',
            'is_correct': true,
          },
          {
            'text': 'Drive into the middle of the intersection',
            'is_correct': false,
          },
        ],
        'explanation':
            'Never enter an intersection unless you can clear it completely.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'Priority vehicles when arriving at a 4-way intersection together when:',
        'answers': [
          {'text': 'Vehicle on the left', 'is_correct': false},
          {'text': 'Vehicle coming first or right', 'is_correct': true},
          {'text': 'Larger vehicle', 'is_correct': false},
        ],
        'explanation':
            'At 4-way stops, the vehicle that arrives first goes first. If tied, the vehicle on the right goes first.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'At an intersection with a continuous yellow light:',
        'answers': [
          {'text': 'Must stop', 'is_correct': false},
          {'text': 'Prepare to stop if safe', 'is_correct': true},
          {'text': 'Continue without looking', 'is_correct': false},
        ],
        'explanation':
            'Yellow lights mean prepare to stop if it is safe to do so.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When changing lanes, in addition to signaling, you should:',
        'answers': [
          {'text': 'Look in the mirror is enough', 'is_correct': false},
          {'text': 'Check blind spots with your shoulder', 'is_correct': true},
          {
            'text': 'Turn quickly to avoid the vehicle behind',
            'is_correct': false,
          },
        ],
        'explanation':
            'Always check your blind spots by looking over your shoulder before changing lanes.',
        'difficultyLevel': 2,
      },

      // Set 7: Difficult - Priority rules and reflexes (7 questions)
      {
        'questionText': 'Vehicles in a roundabout have the right to:',
        'answers': [
          {'text': 'Yield to you', 'is_correct': false},
          {'text': 'Have the right of way', 'is_correct': true},
          {'text': 'Must stop', 'is_correct': false},
        ],
        'explanation':
            'Vehicles already in a roundabout have the right of way.',
        'difficultyLevel': 3,
      },
      {
        'questionText':
            'When you see a fire truck behind you on a busy road, you should:',
        'answers': [
          {'text': 'Move close to the right and stop', 'is_correct': true},
          {'text': 'Continue go', 'is_correct': false},
          {'text': 'Accelerate to avoid', 'is_correct': false},
        ],
        'explanation':
            'When emergency vehicles approach, pull to the right and stop.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When parallel parking, the distance to the curb is:',
        'answers': [
          {'text': '6–18 inches', 'is_correct': true},
          {'text': '24 inches', 'is_correct': false},
          {'text': '30 inches', 'is_correct': false},
        ],
        'explanation':
            'When parallel parking, stay within 6-18 inches of the curb.',
        'difficultyLevel': 3,
      },
      {
        'questionText':
            'When the road is slippery and you want to slow down, you should:',
        'answers': [
          {'text': 'Brake gently and evenly', 'is_correct': true},
          {'text': 'Brake suddenly', 'is_correct': false},
          {'text': 'Accelerate', 'is_correct': false},
        ],
        'explanation':
            'On slippery roads, brake gently and evenly to avoid skidding.',
        'difficultyLevel': 3,
      },
      {
        'questionText':
            'The car in front turns on the turn signal but does not turn, you should:',
        'answers': [
          {'text': 'Pass', 'is_correct': false},
          {'text': 'Keep distance', 'is_correct': true},
          {'text': 'Flash the lights', 'is_correct': false},
        ],
        'explanation':
            'Always maintain a safe following distance, even if the car ahead signals.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When you need to pass 2 cars in front, you should:',
        'answers': [
          {'text': 'Pass once', 'is_correct': false},
          {
            'text': 'Pass each car when there is enough space',
            'is_correct': true,
          },
          {'text': 'No need to signal', 'is_correct': false},
        ],
        'explanation':
            'When passing multiple vehicles, pass each one individually when safe.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'If you run a red light, the penalty may be:',
        'answers': [
          {'text': 'Warning', 'is_correct': false},
          {'text': 'Fine, driver\'s license deduction', 'is_correct': true},
          {'text': 'No problem if not cause an accident', 'is_correct': false},
        ],
        'explanation':
            'Running a red light can result in fines and points on your license.',
        'difficultyLevel': 3,
      },

      // Set 8: Difficult – Real-life simulation situation (8 questions)
      {
        'questionText':
            'When driving in a residential area, encountering children playing:',
        'answers': [
          {'text': 'Slow down and prepare to stop', 'is_correct': true},
          {'text': 'Flash the warning lights', 'is_correct': false},
          {'text': 'Continue if not obstructing', 'is_correct': false},
        ],
        'explanation':
            'When children are playing, slow down and be prepared to stop.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When your car loses its brakes, you should:',
        'answers': [
          {'text': 'Lightly brake', 'is_correct': true},
          {'text': 'Turn off the engine', 'is_correct': false},
          {'text': 'Use the horn', 'is_correct': false},
        ],
        'explanation':
            'If brakes fail, pump them lightly and downshift to slow down.',
        'difficultyLevel': 3,
      },
      {
        'questionText':
            'You come to an intersection with a red light, the car behind follows closely:',
        'answers': [
          {'text': 'Brake suddenly', 'is_correct': false},
          {'text': 'Lightly brake earlier', 'is_correct': true},
          {'text': 'Suddenly change lanes', 'is_correct': false},
        ],
        'explanation':
            'When being followed closely, brake earlier and more gradually.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'Seeing the "Wrong Way" sign means:',
        'answers': [
          {
            'text': 'The road is going in the opposite direction',
            'is_correct': true,
          },
          {'text': 'Allowed to go if safe', 'is_correct': false},
          {'text': 'No parking', 'is_correct': false},
        ],
        'explanation':
            'Wrong Way signs indicate you are traveling in the wrong direction.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'The car turning left in front is stuck, you:',
        'answers': [
          {'text': 'Overtake on the right', 'is_correct': false},
          {'text': 'Wait behind', 'is_correct': true},
          {'text': 'Honk to urge', 'is_correct': false},
        ],
        'explanation':
            'When a car is stuck in an intersection, wait patiently behind.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When a motorbike turns without signaling, you should:',
        'answers': [
          {'text': 'Speed up to pass', 'is_correct': false},
          {'text': 'Slow down and wait for them to turn', 'is_correct': true},
          {'text': 'Cut lanes', 'is_correct': false},
        ],
        'explanation':
            'When motorcycles don\'t signal, slow down and wait for them to complete their turn.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When parking uphill without a curb, turn the wheel:',
        'answers': [
          {'text': 'Turn left', 'is_correct': false},
          {'text': 'Turn right', 'is_correct': true},
          {'text': 'Keep straight', 'is_correct': false},
        ],
        'explanation':
            'When parking uphill without a curb, turn wheels to the right.',
        'difficultyLevel': 3,
      },
      {
        'questionText':
            'When driving at night, if the opposite vehicle has its headlights on:',
        'answers': [
          {'text': 'Look straight', 'is_correct': false},
          {'text': 'Look towards the right curb', 'is_correct': true},
          {'text': 'Turn on the high beams', 'is_correct': false},
        ],
        'explanation':
            'When blinded by oncoming headlights, look toward the right edge of the road.',
        'difficultyLevel': 3,
      },

      // Set 9: Difficult - Understanding the law & application (8 questions)
      {
        'questionText': 'According to the Basic Speed Law:',
        'answers': [
          {
            'text': 'Drive faster than the posted speed limit',
            'is_correct': false,
          },
          {
            'text': 'Drive in accordance with road conditions',
            'is_correct': true,
          },
          {
            'text': 'Drive within the posted speed limit is enough',
            'is_correct': false,
          },
        ],
        'explanation':
            'The Basic Speed Law requires driving at a speed appropriate for current conditions.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When the road is flooded, you should:',
        'answers': [
          {'text': 'Overtake fast', 'is_correct': false},
          {
            'text': 'Avoid completely if the depth is unknown',
            'is_correct': true,
          },
          {'text': 'Use high gear', 'is_correct': false},
        ],
        'explanation':
            'Never drive through flooded areas if you cannot determine the depth.',
        'difficultyLevel': 3,
      },
      {
        'questionText':
            'When the car behind is following closely and flashing its lights, you should:',
        'answers': [
          {'text': 'Change lanes if safe', 'is_correct': true},
          {'text': 'Stay in the same lane', 'is_correct': false},
          {'text': 'Brake to warn', 'is_correct': false},
        ],
        'explanation':
            'When being tailgated, change lanes when safe to let the faster vehicle pass.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'In a roundabout, when you want to turn right:',
        'answers': [
          {'text': 'Stay in the inner lane', 'is_correct': false},
          {'text': 'Stay in the outer lane and signal', 'is_correct': true},
          {'text': 'No need to signal', 'is_correct': false},
        ],
        'explanation':
            'In roundabouts, use the outer lane for right turns and signal your intention.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When braking urgently on slippery roads, you should:',
        'answers': [
          {'text': 'Press hard continuously', 'is_correct': false},
          {'text': 'Press the brake lightly in intervals', 'is_correct': true},
          {'text': 'Turn sharply', 'is_correct': false},
        ],
        'explanation':
            'On slippery roads, use gentle, intermittent braking to avoid skidding.',
        'difficultyLevel': 3,
      },
      {
        'questionText':
            'At an intersection, when the traffic lights are not working:',
        'answers': [
          {'text': 'Stop as if there is a STOP sign', 'is_correct': true},
          {'text': 'Continue', 'is_correct': false},
          {'text': 'Turn sharply', 'is_correct': false},
        ],
        'explanation':
            'When traffic lights are not working, treat the intersection as a 4-way stop.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'The safe distance between vehicles is:',
        'answers': [
          {'text': '1 second', 'is_correct': false},
          {'text': '2 seconds', 'is_correct': false},
          {'text': 'At least 3 seconds', 'is_correct': true},
        ],
        'explanation':
            'Maintain at least 3 seconds of following distance for safety.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When your headlights are lost at night, you should:',
        'answers': [
          {'text': 'Accelerate', 'is_correct': false},
          {'text': 'Stop in a safe position', 'is_correct': true},
          {'text': 'Flash your turn signals continuously', 'is_correct': false},
        ],
        'explanation':
            'If your headlights fail at night, pull over to a safe location and stop.',
        'difficultyLevel': 3,
      },

      // Set 10: Advanced Summary (6 questions)
      {
        'questionText': 'When your car is in the opposite lane, you should:',
        'answers': [
          {'text': 'Brake and turn sharply', 'is_correct': false},
          {
            'text': 'Return to the correct lane when it is safe',
            'is_correct': true,
          },
          {'text': 'Continue because no one is coming', 'is_correct': false},
        ],
        'explanation':
            'If you find yourself in the wrong lane, safely return to the correct lane.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When you see a "Do Not Enter" sign:',
        'answers': [
          {'text': 'Drive slowly and observe', 'is_correct': false},
          {'text': 'Do not enter', 'is_correct': true},
          {'text': 'For trucks', 'is_correct': false},
        ],
        'explanation':
            'Do Not Enter signs mean you cannot enter that road or area.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When you see an oil stain on the road, you should:',
        'answers': [
          {'text': 'Brake hard', 'is_correct': false},
          {
            'text': 'Avoid and keep the steering wheel straight',
            'is_correct': true,
          },
          {'text': 'Honk', 'is_correct': false},
        ],
        'explanation':
            'When encountering oil stains, avoid them and keep the steering wheel straight.',
        'difficultyLevel': 3,
      },
      {
        'questionText':
            'When your car is turning left but encounters an obstacle, you should:',
        'answers': [
          {'text': 'Change direction', 'is_correct': false},
          {'text': 'Stop and wait clearly', 'is_correct': true},
          {'text': 'Pass', 'is_correct': false},
        ],
        'explanation':
            'When encountering an obstacle during a turn, stop and wait for a clear path.',
        'difficultyLevel': 3,
      },
      {
        'questionText':
            'When the car reaches an intersection and it is unclear who is going first, you:',
        'answers': [
          {'text': 'Drive ahead', 'is_correct': false},
          {'text': 'Make eye contact and yield', 'is_correct': true},
          {'text': 'Honk and continue', 'is_correct': false},
        ],
        'explanation':
            'When unsure about right of way, make eye contact and yield to be safe.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When you are dazzled by another car:',
        'answers': [
          {'text': 'Look to the left', 'is_correct': false},
          {'text': 'Look down the road to the right', 'is_correct': true},
          {'text': 'Flash your headlights', 'is_correct': false},
        ],
        'explanation':
            'When blinded by oncoming headlights, look toward the right edge of the road.',
        'difficultyLevel': 3,
      },

      // Set 11: Simulation situations & test summary (6 questions)
      {
        'questionText': 'You are driving into a sharp turn, you should:',
        'answers': [
          {
            'text': 'Brake suddenly when entering the turn',
            'is_correct': false,
          },
          {'text': 'Slow down before turning', 'is_correct': true},
          {'text': 'Speed up to pass quickly', 'is_correct': false},
        ],
        'explanation': 'Always slow down before entering a sharp turn.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When you see a pedestrian walking down the sidewalk:',
        'answers': [
          {'text': 'Continue if not yet in the road', 'is_correct': false},
          {'text': 'Stop to let them pass', 'is_correct': true},
          {'text': 'Flash your lights', 'is_correct': false},
        ],
        'explanation':
            'Be prepared to stop for pedestrians, even if they are on the sidewalk.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'Your tire blew out while driving fast:',
        'answers': [
          {'text': 'Brake hard', 'is_correct': false},
          {
            'text': 'Hold the steering wheel tight and slow down',
            'is_correct': true,
          },
          {'text': 'Accelerate to escape', 'is_correct': false},
        ],
        'explanation':
            'When a tire blows out, hold the steering wheel firmly and gradually slow down.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When driving on a narrow road with oncoming vehicles:',
        'answers': [
          {
            'text': 'The person closest to the empty space must yield',
            'is_correct': true,
          },
          {'text': 'Whoever arrives first goes first', 'is_correct': false},
          {'text': 'Large vehicles go first', 'is_correct': false},
        ],
        'explanation':
            'On narrow roads, the vehicle closest to the wider area should yield.',
        'difficultyLevel': 3,
      },
      {
        'questionText':
            'When turning right at an intersection with pedestrians on the right, you:',
        'answers': [
          {'text': 'Turn right', 'is_correct': false},
          {'text': 'Stop and yield', 'is_correct': true},
          {'text': 'Honk', 'is_correct': false},
        ],
        'explanation':
            'When turning right, you must yield to pedestrians in the crosswalk.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'If you feel tired while driving:',
        'answers': [
          {'text': 'Open the window', 'is_correct': false},
          {'text': 'Stop and rest', 'is_correct': true},
          {'text': 'Turn up the music and continue', 'is_correct': false},
        ],
        'explanation':
            'If you feel tired while driving, pull over and rest before continuing.',
        'difficultyLevel': 3,
      },
      // Set 7: Behavior at intersections – Safety rules (6 questions)
      {
        'questionText':
            'When turning left at an intersection, you must yield to:',
        'answers': [
          {'text': 'The vehicle behind', 'is_correct': false},
          {
            'text': 'The vehicle going straight from the opposite direction',
            'is_correct': true,
          },
          {'text': 'The vehicle turning right', 'is_correct': false},
        ],
        'explanation':
            'When turning left, you must yield to vehicles going straight from the opposite direction.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When two vehicles arrive at an intersection without a sign at the same time, which vehicle goes first?',
        'answers': [
          {'text': 'Vehicle on the right', 'is_correct': true},
          {'text': 'Larger vehicle', 'is_correct': false},
          {'text': 'Vehicle turning left', 'is_correct': false},
        ],
        'explanation':
            'When two vehicles arrive at an uncontrolled intersection at the same time, the vehicle on the right has the right of way.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'Intersection with flashing yellow lights, you should:',
        'answers': [
          {'text': 'Go faster', 'is_correct': false},
          {'text': 'Slow down and go if safe', 'is_correct': true},
          {'text': 'Stop', 'is_correct': false},
        ],
        'explanation':
            'Flashing yellow lights mean slow down and proceed with caution.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'Intersection with flashing red lights, you should:',
        'answers': [
          {'text': 'Slow down', 'is_correct': false},
          {'text': 'Stop completely and go if safe', 'is_correct': true},
          {
            'text': 'Continue because there are no vehicles',
            'is_correct': false,
          },
        ],
        'explanation':
            'Flashing red lights mean stop completely, then proceed when safe.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When the vehicle in front stops at the intersection and you cannot see the signal clearly, you:',
        'answers': [
          {'text': 'Follow closely', 'is_correct': false},
          {'text': 'Wait for the vehicle in front to move', 'is_correct': true},
          {'text': 'Pass', 'is_correct': false},
        ],
        'explanation':
            'When you cannot see the signal clearly, wait for the vehicle in front to move.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When you turn left and the vehicle in front also wants to turn left, who goes first?',
        'answers': [
          {'text': 'Which car comes first', 'is_correct': false},
          {'text': 'The car on the right', 'is_correct': false},
          {
            'text': 'Both can turn at the same time if it is safe',
            'is_correct': true,
          },
        ],
        'explanation':
            'When both vehicles are turning left, they can turn at the same time if it is safe.',
        'difficultyLevel': 1,
      },
      // Set 8: Real traffic situations (7 questions)
      {
        'questionText':
            'When you see a traffic police officer driving against the traffic light, you:',
        'answers': [
          {'text': 'Follow the light', 'is_correct': false},
          {
            'text': 'Follow the police officer\'s instructions',
            'is_correct': true,
          },
          {'text': 'Follow the signs', 'is_correct': false},
        ],
        'explanation':
            'When a police officer is directing traffic, you must follow their instructions.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When a bus is stopping to pick up students on a two-way street:',
        'answers': [
          {'text': 'Both directions must stop', 'is_correct': true},
          {
            'text': 'Only the direction where the bus is stopped',
            'is_correct': false,
          },
          {'text': 'Continue if there is a turning lane', 'is_correct': false},
        ],
        'explanation':
            'When a school bus is stopping with flashing lights, both directions must stop.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'Red light + "No Turn on Red" sign means:',
        'answers': [
          {'text': 'Turn if it is safe', 'is_correct': false},
          {'text': 'No right turns on red', 'is_correct': true},
          {'text': 'Only trucks are prohibited', 'is_correct': false},
        ],
        'explanation':
            'The "No Turn on Red" sign prohibits right turns on red lights.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When you see a "Lane Ends Merge Left" sign, you should:',
        'answers': [
          {'text': 'Keep lane', 'is_correct': false},
          {'text': 'Change to the left lane when safe', 'is_correct': true},
          {'text': 'Brake suddenly', 'is_correct': false},
        ],
        'explanation':
            'When you see a "Lane Ends Merge Left" sign, change to the left lane when safe.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When another vehicle asks to enter the lane, you should:',
        'answers': [
          {'text': 'Speed up to avoid', 'is_correct': false},
          {'text': 'Yield when possible', 'is_correct': true},
          {'text': 'Don\'t care', 'is_correct': false},
        ],
        'explanation':
            'When another vehicle asks to enter your lane, yield when possible.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When you enter the freeway, the vehicle in the main lane has:',
        'answers': [
          {'text': 'Responsibility to yield', 'is_correct': false},
          {'text': 'Right of way', 'is_correct': true},
          {'text': 'Must stop', 'is_correct': false},
        ],
        'explanation':
            'When entering the freeway, vehicles in the main lane have the right of way.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When passing through an intersection with many bicycles, you:',
        'answers': [
          {'text': 'Yield to bicycles like motor vehicles', 'is_correct': true},
          {'text': 'Pass quickly', 'is_correct': false},
          {'text': 'Honk', 'is_correct': false},
        ],
        'explanation':
            'When passing through an intersection with many bicycles, yield to bicycles like motor vehicles.',
        'difficultyLevel': 1,
      },
      // Set 9: Construction site and temporary signs (7 questions)
      {
        'questionText': 'Orange diamond-shaped signs indicate:',
        'answers': [
          {'text': 'Construction site or temporary change', 'is_correct': true},
          {'text': 'No overtaking', 'is_correct': false},
          {'text': 'Turning lane', 'is_correct': false},
        ],
        'explanation':
            'Orange diamond-shaped signs indicate construction sites or temporary changes.',
        'difficultyLevel': 1,
      },
      {
        'questionText': '"Flagger Ahead" sign means:',
        'answers': [
          {'text': 'Traffic controller ahead', 'is_correct': true},
          {'text': 'Signal lights', 'is_correct': false},
          {'text': 'One-way road', 'is_correct': false},
        ],
        'explanation':
            'The "Flagger Ahead" sign warns of a traffic controller ahead.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'When you see a "Road Work Ahead" sign, you should:',
        'answers': [
          {'text': 'Slow down and be alert', 'is_correct': true},
          {'text': 'Overtake quickly before entering', 'is_correct': false},
          {'text': 'Continue as normal', 'is_correct': false},
        ],
        'explanation':
            'When you see a "Road Work Ahead" sign, slow down and be alert.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'In construction sites, the speed limit is usually:',
        'answers': [
          {
            'text': 'Reduced according to the auxiliary sign',
            'is_correct': true,
          },
          {'text': 'Unchanged', 'is_correct': false},
          {'text': 'Applies only to trucks', 'is_correct': false},
        ],
        'explanation':
            'In construction sites, the speed limit is usually reduced according to auxiliary signs.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'If you see a "Detour" sign, you understand that:',
        'answers': [
          {'text': 'Shortcut', 'is_correct': false},
          {'text': 'Must go in an alternative direction', 'is_correct': true},
          {'text': 'No motorbikes', 'is_correct': false},
        ],
        'explanation':
            'A "Detour" sign means you must go in an alternative direction.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The sign "End Road Work" means:',
        'answers': [
          {'text': 'Start of construction site', 'is_correct': false},
          {'text': 'End of construction road', 'is_correct': true},
          {'text': 'Change to the left lane', 'is_correct': false},
        ],
        'explanation':
            'The "End Road Work" sign indicates the end of construction work.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'When passing a construction site with a flagman:',
        'answers': [
          {'text': 'Must listen to the coordinator', 'is_correct': true},
          {'text': 'Just follow the traffic light', 'is_correct': false},
          {'text': 'Honk to remind them to avoid', 'is_correct': false},
        ],
        'explanation':
            'When passing a construction site with a flagman, you must follow their instructions.',
        'difficultyLevel': 1,
      },
      // Set 10: Electronic signs and electronic signs (7 questions)
      {
        'questionText': 'Electronic signs can display:',
        'answers': [
          {'text': 'Traffic conditions, accidents, routes', 'is_correct': true},
          {'text': 'Advertisements', 'is_correct': false},
          {'text': 'Stopping and parking instructions', 'is_correct': false},
        ],
        'explanation':
            'Electronic signs can display traffic conditions, accidents, and route information.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The sign "Congestion Ahead" means:',
        'answers': [
          {'text': 'Road clear', 'is_correct': false},
          {'text': 'Traffic jam ahead', 'is_correct': true},
          {'text': 'Construction site', 'is_correct': false},
        ],
        'explanation':
            'The "Congestion Ahead" sign warns of traffic congestion ahead.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When the electronic sign says "Accident Ahead", you should:',
        'answers': [
          {'text': 'Speed up to pass', 'is_correct': false},
          {'text': 'Slow down and prepare to change lanes', 'is_correct': true},
          {'text': 'Honk', 'is_correct': false},
        ],
        'explanation':
            'When the electronic sign says "Accident Ahead", slow down and prepare to change lanes.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The "Amber Alert" sign is a warning about:',
        'answers': [
          {'text': 'Bad weather', 'is_correct': false},
          {
            'text': 'Missing children, danger to the community',
            'is_correct': true,
          },
          {'text': 'Vehicle breakdown', 'is_correct': false},
        ],
        'explanation':
            'The "Amber Alert" sign warns about missing children and danger to the community.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'An electronic sign with the words "Exit Closed" means:',
        'answers': [
          {'text': 'No right turn', 'is_correct': false},
          {'text': 'Exit temporarily closed', 'is_correct': true},
          {'text': 'Nothing important', 'is_correct': false},
        ],
        'explanation':
            'An electronic sign with "Exit Closed" means the exit is temporarily closed.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'If the electronic sign requires a speed reduction:',
        'answers': [
          {'text': 'Ignore it', 'is_correct': false},
          {'text': 'Must obey as a regular sign', 'is_correct': true},
          {'text': 'For trucks only', 'is_correct': false},
        ],
        'explanation':
            'If the electronic sign requires a speed reduction, you must obey it as a regular sign.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'Electronic lane notifications are only applicable:',
        'answers': [
          {'text': 'During rush hour', 'is_correct': true},
          {'text': 'All day', 'is_correct': false},
          {'text': 'Not required', 'is_correct': false},
        ],
        'explanation':
            'Electronic lane notifications are typically only applicable during rush hour.',
        'difficultyLevel': 1,
      },
      // Set 11: Highway signs – Highway signs (7 questions)
      {
        'questionText': 'A blue sign with a road number (e.g. I-80) is:',
        'answers': [
          {'text': 'Interstate', 'is_correct': true},
          {'text': 'Local name', 'is_correct': false},
          {'text': 'No stopping', 'is_correct': false},
        ],
        'explanation':
            'A blue sign with a road number indicates an interstate highway.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'A "Rest Area 1 Mile" sign means:',
        'answers': [
          {'text': 'Rest area 1 mile away', 'is_correct': true},
          {'text': 'Residential area', 'is_correct': false},
          {'text': 'No stopping zone', 'is_correct': false},
        ],
        'explanation':
            'A "Rest Area 1 Mile" sign indicates a rest area is 1 mile away.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'A "Exit 12A" sign indicates:',
        'answers': [
          {'text': 'Freeway entrance', 'is_correct': false},
          {'text': '12th exit', 'is_correct': true},
          {'text': 'End of road', 'is_correct': false},
        ],
        'explanation': 'An "Exit 12A" sign indicates the 12th exit.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'A "Mile Marker 123" sign is useful for:',
        'answers': [
          {
            'text': 'Calling for help or indicating a location',
            'is_correct': true,
          },
          {'text': 'Speeding', 'is_correct': false},
          {'text': 'Parking sign', 'is_correct': false},
        ],
        'explanation':
            'A "Mile Marker 123" sign is useful for calling for help or indicating a location.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'A brown sign usually indicates:',
        'answers': [
          {'text': 'Industrial area', 'is_correct': false},
          {'text': 'Recreational or park area', 'is_correct': true},
          {'text': 'Slippery Road', 'is_correct': false},
        ],
        'explanation':
            'A brown sign usually indicates a recreational or park area.',
        'difficultyLevel': 1,
      },
      {
        'questionText': '"Weigh Station" sign is used for:',
        'answers': [
          {'text': 'Private vehicles', 'is_correct': false},
          {'text': 'Trucks must stop for weight check', 'is_correct': true},
          {'text': 'Gas station', 'is_correct': false},
        ],
        'explanation':
            'A "Weigh Station" sign indicates that trucks must stop for weight checks.',
        'difficultyLevel': 1,
      },
      {
        'questionText': '"No Services" sign means:',
        'answers': [
          {'text': 'There is service nearby', 'is_correct': false},
          {
            'text': 'There is no gas station, water, rest stop',
            'is_correct': true,
          },
          {'text': 'Stopping is prohibited', 'is_correct': false},
        ],
        'explanation':
            'A "No Services" sign means there are no gas stations, water, or rest stops.',
        'difficultyLevel': 1,
      },
      // Set 12: Advanced Intersection Situations (7 questions)
      {
        'questionText':
            'When the light is green but the car in front has not moved, you should:',
        'answers': [
          {'text': 'Honk', 'is_correct': false},
          {
            'text': 'Wait for a safe distance and then move',
            'is_correct': true,
          },
          {'text': 'Pass into another lane', 'is_correct': false},
        ],
        'explanation':
            'When the light is green but the car in front has not moved, wait for a safe distance and then move.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'If you are in the left turn lane but want to go straight, you:',
        'answers': [
          {'text': 'Just go straight', 'is_correct': false},
          {'text': 'Turn in the direction of the lane', 'is_correct': true},
          {'text': 'Back up', 'is_correct': false},
        ],
        'explanation':
            'If you are in the left turn lane, you must turn in the direction of the lane.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When the light turns yellow in the middle of the intersection, you should:',
        'answers': [
          {
            'text': 'Continue if you have entered the intersection',
            'is_correct': true,
          },
          {'text': 'Brake suddenly', 'is_correct': false},
          {'text': 'Turn around', 'is_correct': false},
        ],
        'explanation':
            'When the light turns yellow in the middle of the intersection, continue if you have entered the intersection.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'At a busy intersection, you should:',
        'answers': [
          {'text': 'Move in if the light is green', 'is_correct': false},
          {
            'text': 'Wait for a space ahead before entering',
            'is_correct': true,
          },
          {'text': 'Continue, other vehicles will yield', 'is_correct': false},
        ],
        'explanation':
            'At a busy intersection, wait for a space ahead before entering.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'A red light with a green arrow for a left turn means:',
        'answers': [
          {'text': 'Turn left without stopping', 'is_correct': true},
          {'text': 'No turning', 'is_correct': false},
          {'text': 'Turn left but must yield', 'is_correct': false},
        ],
        'explanation':
            'A red light with a green arrow for a left turn means you can turn left without stopping.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When a vehicle is driving in the wrong lane at an intersection, you:',
        'answers': [
          {
            'text': 'Yield if necessary to avoid a collision',
            'is_correct': true,
          },
          {'text': 'Honk', 'is_correct': false},
          {'text': 'Swerve quickly', 'is_correct': false},
        ],
        'explanation':
            'When a vehicle is driving in the wrong lane at an intersection, yield if necessary to avoid a collision.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When the traffic light and the stop line do not match:',
        'answers': [
          {'text': 'Stop at the stop line', 'is_correct': true},
          {'text': 'Stop immediately at the light', 'is_correct': false},
          {'text': 'Stop after the light', 'is_correct': false},
        ],
        'explanation':
            'When the traffic light and the stop line do not match, stop at the stop line.',
        'difficultyLevel': 1,
      },
      // Set 13: Special Warning Signs (8 questions)
      {
        'questionText': 'The "Falling Rocks" sign warns of:',
        'answers': [
          {'text': 'Slippery area', 'is_correct': false},
          {
            'text': 'Falling rocks – drive slowly and carefully',
            'is_correct': true,
          },
          {'text': 'Trucks are prohibited', 'is_correct': false},
        ],
        'explanation':
            'The "Falling Rocks" sign warns of falling rocks and advises driving slowly and carefully.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The "Animal Crossing" sign warns of:',
        'answers': [
          {'text': 'Farm area', 'is_correct': false},
          {'text': 'Animals may cross', 'is_correct': true},
          {'text': 'Park road', 'is_correct': false},
        ],
        'explanation':
            'The "Animal Crossing" sign warns that animals may cross the road.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The "Truck Rollover Risk" sign warns of:',
        'answers': [
          {
            'text': 'Trucks should slow down when cornering',
            'is_correct': true,
          },
          {'text': 'Trucks have priority', 'is_correct': false},
          {'text': 'Not applicable to private vehicles', 'is_correct': false},
        ],
        'explanation':
            'The "Truck Rollover Risk" sign warns that trucks should slow down when cornering.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The "Road Narrows" sign means:',
        'answers': [
          {'text': 'Road widening', 'is_correct': false},
          {'text': 'Road ahead narrowing', 'is_correct': true},
          {'text': 'Road turning left', 'is_correct': false},
        ],
        'explanation':
            'The "Road Narrows" sign means the road ahead is narrowing.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The "Soft Shoulder" sign means:',
        'answers': [
          {'text': 'Weak shoulder, do not drive on', 'is_correct': true},
          {'text': 'For bicycles', 'is_correct': false},
          {'text': 'Rest stop', 'is_correct': false},
        ],
        'explanation':
            'The "Soft Shoulder" sign means the shoulder is weak and you should not drive on it.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The sign "Cross Traffic Does Not Stop" means:',
        'answers': [
          {'text': 'Oncoming vehicles have priority', 'is_correct': true},
          {'text': 'All vehicles stop', 'is_correct': false},
          {'text': 'No STOP sign', 'is_correct': false},
        ],
        'explanation':
            'The "Cross Traffic Does Not Stop" sign means oncoming vehicles have priority.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The sign "Hidden Driveway" warns:',
        'answers': [
          {
            'text': 'There is a turn that is hidden from view',
            'is_correct': true,
          },
          {'text': 'End of road', 'is_correct': false},
          {'text': 'Soft shoulder', 'is_correct': false},
        ],
        'explanation':
            'The "Hidden Driveway" sign warns of a turn that is hidden from view.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The sign "Dip" on the road surface means:',
        'answers': [
          {'text': 'Steep slope', 'is_correct': false},
          {'text': 'Unexpected depression/sag', 'is_correct': true},
          {'text': 'Puddle', 'is_correct': false},
        ],
        'explanation':
            'The "Dip" sign on the road surface means there is an unexpected depression or sag.',
        'difficultyLevel': 1,
      },
      // Set 14: Strange situations, special auxiliary signs (8 questions)
      {
        'questionText': 'The auxiliary sign "Next 5 Miles" means:',
        'answers': [
          {
            'text': 'The main law/sign applies for the next 5 miles',
            'is_correct': true,
          },
          {'text': '5 miles traveled through', 'is_correct': false},
          {'text': 'Temporary sign', 'is_correct': false},
        ],
        'explanation':
            'The auxiliary sign "Next 5 Miles" means the main law or sign applies for the next 5 miles.',
        'difficultyLevel': 1,
      },
      {
        'questionText': '"Share The Road" sign means:',
        'answers': [
          {'text': 'Narrow road', 'is_correct': false},
          {'text': 'Must share with bicycles/pedestrians', 'is_correct': true},
          {'text': 'No overtaking', 'is_correct': false},
        ],
        'explanation':
            'The "Share The Road" sign means you must share the road with bicycles and pedestrians.',
        'difficultyLevel': 1,
      },
      {
        'questionText': '"Advisory Speed 35" sign means:',
        'answers': [
          {'text': 'Mandatory speed', 'is_correct': false},
          {'text': 'Recommended speed in a curve', 'is_correct': true},
          {'text': 'Minimum speed', 'is_correct': false},
        ],
        'explanation':
            'The "Advisory Speed 35" sign indicates the recommended speed in a curve.',
        'difficultyLevel': 1,
      },
      {
        'questionText': '"Minimum Speed 45" sign means:',
        'answers': [
          {'text': 'Maximum speed', 'is_correct': false},
          {'text': 'Minimum speed', 'is_correct': true},
          {'text': 'Turn restriction', 'is_correct': false},
        ],
        'explanation':
            'The "Minimum Speed 45" sign indicates the minimum speed allowed.',
        'difficultyLevel': 1,
      },
      {
        'questionText': '"Yield Ahead" sign indicates:',
        'answers': [
          {'text': 'Yield ahead', 'is_correct': true},
          {'text': 'No overtaking', 'is_correct': false},
          {'text': 'Stop immediately', 'is_correct': false},
        ],
        'explanation':
            'The "Yield Ahead" sign indicates that a yield sign is ahead.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            '"Wrong Way" sign accompanied by "Do Not Enter" usually:',
        'answers': [
          {'text': 'Indicates going the wrong way', 'is_correct': true},
          {'text': 'Time warning section', 'is_correct': false},
          {'text': 'Not applicable at night', 'is_correct': false},
        ],
        'explanation':
            'The "Wrong Way" sign accompanied by "Do Not Enter" indicates you are going the wrong way.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The "Low Clearance" sign has the effect of:',
        'answers': [
          {
            'text': 'Warning of low bridge, prohibiting high vehicles',
            'is_correct': true,
          },
          {'text': 'Prohibiting container trucks', 'is_correct': false},
          {'text': 'Slowing down', 'is_correct': false},
        ],
        'explanation':
            'The "Low Clearance" sign warns of a low bridge and prohibits high vehicles.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The "No Outlet" sign means:',
        'answers': [
          {'text': 'Dead end – no other exit', 'is_correct': true},
          {'text': 'No overtaking', 'is_correct': false},
          {'text': 'No service station', 'is_correct': false},
        ],
        'explanation':
            'The "No Outlet" sign means it is a dead end with no other exit.',
        'difficultyLevel': 1,
      },
      // Set 15: Mixed and complex traffic (10 questions)
      {
        'questionText':
            'When the intersection has overlapping STOP and YIELD signs:',
        'answers': [
          {'text': 'Stop completely', 'is_correct': true},
          {'text': 'Just slow down', 'is_correct': false},
          {'text': 'Yield if you see a vehicle', 'is_correct': false},
        ],
        'explanation':
            'When the intersection has overlapping STOP and YIELD signs, you must stop completely.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When the light flashes green with a left turn arrow, you:',
        'answers': [
          {'text': 'Must stop', 'is_correct': false},
          {'text': 'Can turn left without yielding', 'is_correct': true},
          {'text': 'Turn right', 'is_correct': false},
        ],
        'explanation':
            'When the light flashes green with a left turn arrow, you can turn left without yielding.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When you see the "Reduced Speed Ahead" sign, you should:',
        'answers': [
          {'text': 'Maintain speed', 'is_correct': false},
          {'text': 'Slow down before next sign', 'is_correct': true},
          {'text': 'Accelerate quickly', 'is_correct': false},
        ],
        'explanation':
            'When you see the "Reduced Speed Ahead" sign, slow down before the next sign.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The "Emergency Stopping Only" sign means:',
        'answers': [
          {'text': 'Stop at any time', 'is_correct': false},
          {'text': 'Stop only in emergency situations', 'is_correct': true},
          {'text': 'No stopping', 'is_correct': false},
        ],
        'explanation':
            'The "Emergency Stopping Only" sign means you should stop only in emergency situations.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When there are multiple STOP lines at an intersection, you:',
        'answers': [
          {'text': 'Stop at the first line', 'is_correct': true},
          {
            'text': 'Cross the line if there are no vehicles',
            'is_correct': false,
          },
          {'text': 'Stop anywhere', 'is_correct': false},
        ],
        'explanation':
            'When there are multiple STOP lines at an intersection, stop at the first line.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'A traffic light hanging to the right of the road means:',
        'answers': [
          {'text': 'Applies to the right lane', 'is_correct': true},
          {'text': 'Invalid', 'is_correct': false},
          {'text': 'Only for trucks', 'is_correct': false},
        ],
        'explanation':
            'A traffic light hanging to the right of the road applies to the right lane.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When you see the "Photo Enforced" sign, you understand:',
        'answers': [
          {
            'text': 'There is a camera to take pictures of traffic violations',
            'is_correct': true,
          },
          {'text': 'Security camera', 'is_correct': false},
          {'text': 'Only to scare', 'is_correct': false},
        ],
        'explanation':
            'The "Photo Enforced" sign indicates there is a camera to take pictures of traffic violations.',
        'difficultyLevel': 1,
      },
      {
        'questionText': '"Left Turn Yield" sign on Green" means:',
        'answers': [
          {
            'text':
                'Left turn is allowed when the light is green but must yield',
            'is_correct': true,
          },
          {'text': 'Left turn is prohibited', 'is_correct': false},
          {'text': 'Left turn is required', 'is_correct': false},
        ],
        'explanation':
            'The "Left Turn Yield on Green" sign means left turn is allowed when the light is green but must yield.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'The intersection has many traffic light arrows, which direction do you go?',
        'answers': [
          {'text': 'Follow your lane arrow', 'is_correct': true},
          {'text': 'Nearest arrow', 'is_correct': false},
          {'text': 'Any lane', 'is_correct': false},
        ],
        'explanation':
            'When the intersection has many traffic light arrows, follow your lane arrow.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When you see the sign "End Divided Highway", you understand:',
        'answers': [
          {
            'text': 'The road changes from 2 lanes to 1 way',
            'is_correct': true,
          },
          {'text': 'Start of freeway', 'is_correct': false},
          {'text': 'End of road', 'is_correct': false},
        ],
        'explanation':
            'The "End Divided Highway" sign means the road changes from 2 lanes to 1 way.',
        'difficultyLevel': 1,
      },
      // Set 16: Advanced comprehensive review (10 questions)
      {
        'questionText':
            'When you see the "Yield" sign but there are no vehicles, you:',
        'answers': [
          {'text': 'Still have to stop', 'is_correct': false},
          {'text': 'Can continue if it is safe', 'is_correct': true},
          {'text': 'Turn around', 'is_correct': false},
        ],
        'explanation':
            'When you see a "Yield" sign but there are no vehicles, you can continue if it is safe.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The sign "Two Way Traffic" means:',
        'answers': [
          {'text': 'One-way road', 'is_correct': false},
          {'text': 'Road with oncoming vehicles', 'is_correct': true},
          {'text': 'Bus lane', 'is_correct': false},
        ],
        'explanation':
            'The "Two Way Traffic" sign means the road has oncoming vehicles.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The sign "School Zone When Flashing" means:',
        'answers': [
          {
            'text': 'Speed limit applies when the lights are flashing',
            'is_correct': true,
          },
          {'text': 'Always effective force', 'is_correct': false},
          {'text': 'Only applies at night', 'is_correct': false},
        ],
        'explanation':
            'The "School Zone When Flashing" sign means the speed limit applies when the lights are flashing.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'When you see a "Merge Right" sign, you are:',
        'answers': [
          {
            'text': 'Preparing to merge into the right lane',
            'is_correct': true,
          },
          {'text': 'Turning left', 'is_correct': false},
          {'text': 'Stopping', 'is_correct': false},
        ],
        'explanation':
            'When you see a "Merge Right" sign, you are preparing to merge into the right lane.',
        'difficultyLevel': 1,
      },
      {
        'questionText': '"No Left Turn" sign but you need to turn around, you:',
        'answers': [
          {'text': 'Turn around if it is safe', 'is_correct': false},
          {'text': 'Do not turn around here', 'is_correct': true},
          {'text': 'Turn right instead', 'is_correct': false},
        ],
        'explanation':
            'When there is a "No Left Turn" sign, you should not turn around here.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'Intersection with a "Yield" sign and pedestrians crossing the road:',
        'answers': [
          {'text': 'Give pedestrians priority', 'is_correct': true},
          {'text': 'Honk', 'is_correct': false},
          {'text': 'Continue if you are going faster', 'is_correct': false},
        ],
        'explanation':
            'At an intersection with a "Yield" sign and pedestrians crossing, give pedestrians priority.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            '"Lane Ends Merge Left" sign but you are in the right lane:',
        'answers': [
          {'text': 'Yield and merge left', 'is_correct': true},
          {'text': 'Speed up', 'is_correct': false},
          {
            'text': 'Stay in your lane and wait for another vehicle to pass',
            'is_correct': false,
          },
        ],
        'explanation':
            'When you see a "Lane Ends Merge Left" sign and you are in the right lane, yield and merge left.',
        'difficultyLevel': 1,
      },
      {
        'questionText': '"No Turn on Red" sign but you do not see a vehicle:',
        'answers': [
          {
            'text': 'Still have to stop and wait for the light green',
            'is_correct': true,
          },
          {'text': 'Turn fast', 'is_correct': false},
          {'text': 'Flash and go', 'is_correct': false},
        ],
        'explanation':
            'When there is a "No Turn on Red" sign, you still have to stop and wait for the green light.',
        'difficultyLevel': 1,
      },
      {
        'questionText': '"Slower Traffic Keep Right" sign means:',
        'answers': [
          {'text': 'Slower vehicles must keep right', 'is_correct': true},
          {'text': 'Speed up', 'is_correct': false},
          {'text': 'Do not need to obey', 'is_correct': false},
        ],
        'explanation':
            'The "Slower Traffic Keep Right" sign means slower vehicles must keep to the right.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When the electronic sign updates the speed in real time, you:',
        'answers': [
          {'text': 'Must obey', 'is_correct': true},
          {'text': 'Can ignore it', 'is_correct': false},
          {'text': 'Only applies to trucks', 'is_correct': false},
        ],
        'explanation':
            'When the electronic sign updates the speed in real time, you must obey it.',
        'difficultyLevel': 1,
      },
    ];

    for (var question in questions) {
      try {
        await questionService.addQuestion(
          categoryId: 1,
          questionText: question['questionText'] as String,
          answers: question['answers'] as List<Map<String, dynamic>>,
          explanation: question['explanation'] as String,
          difficultyLevel: question['difficultyLevel'] as int,
        );
      } catch (e) {
        // Skip this question if there's an error
        continue;
      }
    }
  }

  // Unit 2: Traffic Control
  static Future<void> _loadUnit2Questions(
    QuestionService questionService,
  ) async {
    final questions = [
      // Set 1: Recognizing signs in shape and color (4 questions)
      {
        'questionText': 'What is a red octagonal sign?',
        'answers': [
          {'text': '"STOP" sign', 'is_correct': true},
          {'text': '"Yield" sign', 'is_correct': false},
          {'text': '"Do Not Enter" sign', 'is_correct': false},
        ],
        'explanation': 'A red octagonal sign is a STOP sign.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'The inverted red triangle sign with a white border is:',
        'answers': [
          {'text': 'No overtaking', 'is_correct': false},
          {'text': '"Yield" sign', 'is_correct': true},
          {'text': 'Mandatory left turn', 'is_correct': false},
        ],
        'explanation':
            'An inverted red triangle with white border is a YIELD sign.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The circular sign, white background, red border is:',
        'answers': [
          {'text': 'Warning sign', 'is_correct': false},
          {'text': 'Regulatory sign', 'is_correct': true},
          {'text': 'Information sign', 'is_correct': false},
        ],
        'explanation':
            'Circular signs with white background and red border are regulatory signs.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'Orange signs are often used to indicate:',
        'answers': [
          {'text': 'Construction area', 'is_correct': true},
          {'text': 'One-way street', 'is_correct': false},
          {'text': 'Residential area', 'is_correct': false},
        ],
        'explanation':
            'Orange signs typically indicate construction or work zones.',
        'difficultyLevel': 1,
      },
      // Set 2: Basic signs - Regulatory Signs (4 questions)
      {
        'questionText': 'The "Do Not Enter" sign means:',
        'answers': [
          {
            'text': 'Allowed to enter if there is no vehicle',
            'is_correct': false,
          },
          {
            'text': 'Prohibition of entering the opposite direction',
            'is_correct': true,
          },
          {'text': 'Only No trucks', 'is_correct': false},
        ],
        'explanation':
            'The "Do Not Enter" sign prohibits entering the opposite direction.',
        'difficultyLevel': 1,
      },
      {
        'questionText': '"No U-Turn" sign means:',
        'answers': [
          {'text': 'No left turn', 'is_correct': false},
          {'text': 'No U-turn', 'is_correct': true},
          {'text': 'No entry', 'is_correct': false},
        ],
        'explanation': 'The "No U-Turn" sign prohibits making U-turns.',
        'difficultyLevel': 1,
      },
      {
        'questionText': '"Speed Limit 55" sign means:',
        'answers': [
          {'text': 'Do not exceed 55 mph', 'is_correct': true},
          {'text': 'Recommended speed', 'is_correct': false},
          {'text': 'Minimum speed', 'is_correct': false},
        ],
        'explanation': 'Speed limit signs indicate the maximum speed allowed.',
        'difficultyLevel': 1,
      },
      {
        'questionText': '"One Way" sign indicates:',
        'answers': [
          {'text': 'One-way street', 'is_correct': true},
          {'text': 'Buses only', 'is_correct': false},
          {'text': 'Left turn lane', 'is_correct': false},
        ],
        'explanation':
            'The "One Way" sign indicates traffic flows in one direction only.',
        'difficultyLevel': 1,
      },
      // Set 2: Traffic Signs (12 questions)
      {
        'questionText': 'What does a "No Parking" sign mean?',
        'answers': [
          {'text': 'You can park for a short time', 'is_correct': false},
          {'text': 'You cannot park at any time', 'is_correct': true},
          {'text': 'You can park at night only', 'is_correct': false},
          {'text': 'You can park on weekends', 'is_correct': false},
        ],
        'explanation':
            'No Parking sign means you cannot park at any time in that area.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'What does a "One Way" sign indicate?',
        'answers': [
          {'text': 'Traffic flows in both directions', 'is_correct': false},
          {'text': 'Traffic flows in one direction only', 'is_correct': true},
          {'text': 'You can turn around', 'is_correct': false},
          {'text': 'The road is closed', 'is_correct': false},
        ],
        'explanation':
            'One Way sign indicates that traffic flows in one direction only.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'What does a "Speed Limit" sign show?',
        'answers': [
          {'text': 'The minimum speed you must drive', 'is_correct': false},
          {'text': 'The maximum speed you can drive', 'is_correct': true},
          {'text': 'The recommended speed', 'is_correct': false},
          {'text': 'The average speed of other drivers', 'is_correct': false},
        ],
        'explanation':
            'Speed Limit sign shows the maximum speed you can legally drive.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'What does a "Do Not Enter" sign mean?',
        'answers': [
          {'text': 'You can enter if no traffic', 'is_correct': false},
          {'text': 'You cannot enter this road', 'is_correct': true},
          {'text': 'You can enter at night', 'is_correct': false},
          {'text': 'You can enter on weekends', 'is_correct': false},
        ],
        'explanation':
            'Do Not Enter sign means you cannot enter this road or area.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'What does a "School Zone" sign indicate?',
        'answers': [
          {'text': 'A school is nearby', 'is_correct': true},
          {'text': 'A hospital is nearby', 'is_correct': false},
          {'text': 'A park is nearby', 'is_correct': false},
          {'text': 'A shopping center is nearby', 'is_correct': false},
        ],
        'explanation':
            'School Zone sign indicates that a school is nearby and you should be extra cautious.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'What does a "Railroad Crossing" sign warn about?',
        'answers': [
          {'text': 'A bridge ahead', 'is_correct': false},
          {'text': 'A train crossing ahead', 'is_correct': true},
          {'text': 'A tunnel ahead', 'is_correct': false},
          {'text': 'A sharp curve ahead', 'is_correct': false},
        ],
        'explanation':
            'Railroad Crossing sign warns that a train crossing is ahead.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'What does a "Merge" sign mean?',
        'answers': [
          {'text': 'Two lanes are coming together', 'is_correct': true},
          {'text': 'The road is ending', 'is_correct': false},
          {'text': 'You must turn around', 'is_correct': false},
          {'text': 'The road is closed', 'is_correct': false},
        ],
        'explanation':
            'Merge sign means two lanes are coming together and you should merge safely.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'What does a "Divided Highway" sign indicate?',
        'answers': [
          {'text': 'The road is closed', 'is_correct': false},
          {'text': 'The road has a median', 'is_correct': true},
          {'text': 'The road is one way', 'is_correct': false},
          {'text': 'The road is under construction', 'is_correct': false},
        ],
        'explanation':
            'Divided Highway sign indicates that the road has a median separating traffic.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'What does a "T-Intersection" sign warn about?',
        'answers': [
          {'text': 'A sharp curve ahead', 'is_correct': false},
          {'text': 'A T-shaped intersection ahead', 'is_correct': true},
          {'text': 'A bridge ahead', 'is_correct': false},
          {'text': 'A tunnel ahead', 'is_correct': false},
        ],
        'explanation':
            'T-Intersection sign warns that a T-shaped intersection is ahead.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'What does a "Slippery When Wet" sign mean?',
        'answers': [
          {'text': 'The road is always slippery', 'is_correct': false},
          {'text': 'The road may be slippery when wet', 'is_correct': true},
          {'text': 'The road is under construction', 'is_correct': false},
          {'text': 'The road is closed', 'is_correct': false},
        ],
        'explanation':
            'Slippery When Wet sign means the road may be slippery when wet.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'What does a "Pedestrian Crossing" sign indicate?',
        'answers': [
          {'text': 'A crosswalk is ahead', 'is_correct': true},
          {'text': 'A school is ahead', 'is_correct': false},
          {'text': 'A park is ahead', 'is_correct': false},
          {'text': 'A hospital is ahead', 'is_correct': false},
        ],
        'explanation':
            'Pedestrian Crossing sign indicates that a crosswalk is ahead.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'What does a "Construction Zone" sign mean?',
        'answers': [
          {'text': 'The road is closed', 'is_correct': false},
          {'text': 'Construction work is ahead', 'is_correct': true},
          {'text': 'A school is ahead', 'is_correct': false},
          {'text': 'A hospital is ahead', 'is_correct': false},
        ],
        'explanation':
            'Construction Zone sign means construction work is ahead.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'What does a "Deer Crossing" sign warn about?',
        'answers': [
          {'text': 'A zoo is ahead', 'is_correct': false},
          {'text': 'Deer may cross the road', 'is_correct': true},
          {'text': 'A park is ahead', 'is_correct': false},
          {'text': 'A farm is ahead', 'is_correct': false},
        ],
        'explanation': 'Deer Crossing sign warns that deer may cross the road.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'What does a "Curve" sign indicate?',
        'answers': [
          {'text': 'A sharp curve ahead', 'is_correct': true},
          {'text': 'A bridge ahead', 'is_correct': false},
          {'text': 'A tunnel ahead', 'is_correct': false},
          {'text': 'A hill ahead', 'is_correct': false},
        ],
        'explanation': 'Curve sign indicates that a sharp curve is ahead.',
        'difficultyLevel': 1,
      },
      // Set 3: Warning Signs (5 questions)
      {
        'questionText':
            'Yellow diamond-shaped signs usually serve the following purposes:',
        'answers': [
          {'text': 'Warning of impending danger', 'is_correct': true},
          {'text': 'No stopping', 'is_correct': false},
          {'text': 'Informing instructions', 'is_correct': false},
        ],
        'explanation':
            'Yellow diamond-shaped signs are warning signs that alert drivers to potential hazards.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'A sign with a picture of a construction site in progress is:',
        'answers': [
          {'text': 'Warning of a construction area', 'is_correct': true},
          {'text': 'No vehicles load', 'is_correct': false},
          {'text': 'Slippery road', 'is_correct': false},
        ],
        'explanation': 'Construction signs warn drivers of work zones ahead.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The sign that curves to the right is:',
        'answers': [
          {'text': 'Sharp turn', 'is_correct': false},
          {'text': 'Right curve coming', 'is_correct': true},
          {'text': 'Mandatory right turn', 'is_correct': false},
        ],
        'explanation':
            'Curve signs indicate the direction of the upcoming curve.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The "Slippery When Wet" sign warns of:',
        'answers': [
          {'text': 'Muddy road', 'is_correct': false},
          {'text': 'Slippery road when wet', 'is_correct': true},
          {'text': 'Heavy vehicles prohibited', 'is_correct': false},
        ],
        'explanation':
            'The "Slippery When Wet" sign warns that the road surface may be slippery when wet.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The "Merge" sign means:',
        'answers': [
          {'text': 'Stop', 'is_correct': false},
          {'text': 'Two lanes merge', 'is_correct': true},
          {'text': 'Dead-end road', 'is_correct': false},
        ],
        'explanation':
            'The "Merge" sign indicates that two lanes are coming together.',
        'difficultyLevel': 1,
      },
      // Set 4: Additional signs and regulations (5 questions)
      {
        'questionText': 'The "No Parking Any Time" sign means:',
        'answers': [
          {'text': 'Parking is allowed at night', 'is_correct': false},
          {'text': 'Parking is not allowed at any time', 'is_correct': true},
          {'text': 'Stopping is prohibited', 'is_correct': false},
        ],
        'explanation':
            'The "No Parking Any Time" sign prohibits parking at any time.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'When does the "No Right Turn" sign apply?',
        'answers': [
          {'text': 'When the light is red', 'is_correct': false},
          {'text': 'At all times', 'is_correct': true},
          {'text': 'When there is a police officer', 'is_correct': false},
        ],
        'explanation':
            'The "No Right Turn" sign applies at all times, regardless of traffic light status.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The "Keep Right" sign indicates:',
        'answers': [
          {'text': 'Keep left', 'is_correct': false},
          {'text': 'Keep right of obstruction or divider', 'is_correct': true},
          {'text': 'No turning', 'is_correct': false},
        ],
        'explanation':
            'The "Keep Right" sign indicates you should keep to the right of an obstruction or divider.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The "Trucks Use Low Gear" sign means:',
        'answers': [
          {'text': 'Trucks must stop', 'is_correct': false},
          {
            'text': 'Trucks use low gear when going downhill',
            'is_correct': true,
          },
          {'text': 'Trucks are prohibited from passing', 'is_correct': false},
        ],
        'explanation':
            'The "Trucks Use Low Gear" sign advises trucks to use low gear when going downhill.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The "End School Zone" sign indicates:',
        'answers': [
          {'text': 'End of school zone', 'is_correct': true},
          {'text': 'Start of speed limit', 'is_correct': false},
          {'text': 'Buses are prohibited', 'is_correct': false},
        ],
        'explanation':
            'The "End School Zone" sign indicates the end of a school zone.',
        'difficultyLevel': 1,
      },
      // Set 5: Road Markings – Simple and Practical (5 questions)
      {
        'questionText':
            'What does the solid yellow line that separates the lanes mean?',
        'answers': [
          {'text': 'Allows overtaking', 'is_correct': false},
          {
            'text': 'Prohibits overtaking in the opposite lane',
            'is_correct': true,
          },
          {'text': 'Only prohibits motorbikes', 'is_correct': false},
        ],
        'explanation':
            'A solid yellow line prohibits overtaking in the opposite lane.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The white broken line is used to:',
        'answers': [
          {'text': 'Separate lanes in the same direction', 'is_correct': true},
          {
            'text': 'Separate lanes in the opposite direction',
            'is_correct': false,
          },
          {'text': 'Stop signal', 'is_correct': false},
        ],
        'explanation':
            'White broken lines separate lanes traveling in the same direction.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The double solid yellow line means:',
        'answers': [
          {'text': 'Prohibits all types of overtaking', 'is_correct': true},
          {'text': 'Overtaking is allowed if it is safe', 'is_correct': false},
          {'text': 'Only prohibits trucks', 'is_correct': false},
        ],
        'explanation':
            'Double solid yellow lines prohibit all types of overtaking.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'When you see the "STOP" line on the road, you must:',
        'answers': [
          {'text': 'Slow down', 'is_correct': false},
          {'text': 'Stop at the line', 'is_correct': true},
          {'text': 'Overtake if there are no vehicles', 'is_correct': false},
        ],
        'explanation':
            'When you see a "STOP" line on the road, you must stop at the line.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'The "X" line and the shape of the railway on the road surface mean:',
        'answers': [
          {'text': 'Intersection with trains', 'is_correct': true},
          {'text': 'Construction area', 'is_correct': false},
          {'text': 'Prohibit U-turns', 'is_correct': false},
        ],
        'explanation':
            'The "X" line and railway shape on the road surface indicate a railroad crossing.',
        'difficultyLevel': 1,
      },
      // Set 6: Traffic signals – Basic (6 questions)
      {
        'questionText': 'Red light means:',
        'answers': [
          {'text': 'Slow down', 'is_correct': false},
          {'text': 'Stop completely', 'is_correct': true},
          {'text': 'Turn left', 'is_correct': false},
        ],
        'explanation': 'Red light means you must stop completely.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'Yellow light means:',
        'answers': [
          {'text': 'Speed up', 'is_correct': false},
          {'text': 'Prepare to stop if safe', 'is_correct': true},
          {'text': 'May proceed if turning right', 'is_correct': false},
        ],
        'explanation':
            'Yellow light means prepare to stop if it is safe to do so.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'Green light means:',
        'answers': [
          {'text': 'Go if the road is clear', 'is_correct': true},
          {'text': 'Overtake is allowed', 'is_correct': false},
          {'text': 'Left turn is required', 'is_correct': false},
        ],
        'explanation':
            'Green light means you may proceed if the road is clear.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'Green left arrow means:',
        'answers': [
          {'text': 'Go straight only', 'is_correct': false},
          {'text': 'Turn left safely without yielding', 'is_correct': true},
          {'text': 'No left turn', 'is_correct': false},
        ],
        'explanation':
            'Green left arrow means you can turn left safely without yielding.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'Red light with right turn arrow, you should:',
        'answers': [
          {'text': 'Turn if safe', 'is_correct': false},
          {'text': 'Stop, look, then turn right', 'is_correct': true},
          {'text': 'Ignore the light', 'is_correct': false},
        ],
        'explanation':
            'Red light with right turn arrow means stop, look, then turn right if safe.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When the light is not working at an intersection, you should handle it as follows after:',
        'answers': [
          {'text': 'Continue as usual', 'is_correct': false},
          {'text': 'Stop as if there is a "STOP" sign', 'is_correct': true},
          {'text': 'Wait for the police to come', 'is_correct': false},
        ],
        'explanation':
            'When traffic lights are not working, treat the intersection as if there are STOP signs.',
        'difficultyLevel': 1,
      },
      // Set 8: Real traffic situations (7 questions)
      {
        'questionText':
            'When you see a traffic police officer driving against the traffic light, you:',
        'answers': [
          {'text': 'Follow the light', 'is_correct': false},
          {
            'text': 'Follow the police officer\'s instructions',
            'is_correct': true,
          },
          {'text': 'Follow the signs', 'is_correct': false},
        ],
        'explanation':
            'When a police officer is directing traffic, you must follow their instructions.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When a bus is stopping to pick up students on a two-way street:',
        'answers': [
          {'text': 'Both directions must stop', 'is_correct': true},
          {
            'text': 'Only the direction where the bus is stopped',
            'is_correct': false,
          },
          {'text': 'Continue if there is a turning lane', 'is_correct': false},
        ],
        'explanation':
            'When a school bus is stopping with flashing lights, both directions must stop.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'Red light + "No Turn on Red" sign means:',
        'answers': [
          {'text': 'Turn if it is safe', 'is_correct': false},
          {'text': 'No right turns on red', 'is_correct': true},
          {'text': 'Only trucks are prohibited', 'is_correct': false},
        ],
        'explanation':
            'The "No Turn on Red" sign prohibits right turns on red lights.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When you see a "Lane Ends Merge Left" sign, you should:',
        'answers': [
          {'text': 'Keep lane', 'is_correct': false},
          {'text': 'Change to the left lane when safe', 'is_correct': true},
          {'text': 'Brake suddenly', 'is_correct': false},
        ],
        'explanation':
            'When you see a "Lane Ends Merge Left" sign, change to the left lane when safe.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When another vehicle asks to enter the lane, you should:',
        'answers': [
          {'text': 'Speed up to avoid', 'is_correct': false},
          {'text': 'Yield when possible', 'is_correct': true},
          {'text': 'Don\'t care', 'is_correct': false},
        ],
        'explanation':
            'When another vehicle asks to enter your lane, yield when possible.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When you enter the freeway, the vehicle in the main lane has:',
        'answers': [
          {'text': 'Responsibility to yield', 'is_correct': false},
          {'text': 'Right of way', 'is_correct': true},
          {'text': 'Must stop', 'is_correct': false},
        ],
        'explanation':
            'When entering the freeway, vehicles in the main lane have the right of way.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When passing through an intersection with many bicycles, you:',
        'answers': [
          {'text': 'Yield to bicycles like motor vehicles', 'is_correct': true},
          {'text': 'Pass quickly', 'is_correct': false},
          {'text': 'Honk', 'is_correct': false},
        ],
        'explanation':
            'When passing through an intersection with many bicycles, yield to bicycles like motor vehicles.',
        'difficultyLevel': 1,
      },
      // Set 9: Construction site and temporary signs (7 questions)
      {
        'questionText': 'Orange diamond-shaped signs indicate:',
        'answers': [
          {'text': 'Construction site or temporary change', 'is_correct': true},
          {'text': 'No overtaking', 'is_correct': false},
          {'text': 'Turning lane', 'is_correct': false},
        ],
        'explanation':
            'Orange diamond-shaped signs indicate construction sites or temporary changes.',
        'difficultyLevel': 1,
      },
      {
        'questionText': '"Flagger Ahead" sign means:',
        'answers': [
          {'text': 'Traffic controller ahead', 'is_correct': true},
          {'text': 'Signal lights', 'is_correct': false},
          {'text': 'One-way road', 'is_correct': false},
        ],
        'explanation':
            'The "Flagger Ahead" sign warns of a traffic controller ahead.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'When you see a "Road Work Ahead" sign, you should:',
        'answers': [
          {'text': 'Slow down and be alert', 'is_correct': true},
          {'text': 'Overtake quickly before entering', 'is_correct': false},
          {'text': 'Continue as normal', 'is_correct': false},
        ],
        'explanation':
            'When you see a "Road Work Ahead" sign, slow down and be alert.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'In construction sites, the speed limit is usually:',
        'answers': [
          {
            'text': 'Reduced according to the auxiliary sign',
            'is_correct': true,
          },
          {'text': 'Unchanged', 'is_correct': false},
          {'text': 'Applies only to trucks', 'is_correct': false},
        ],
        'explanation':
            'In construction sites, the speed limit is usually reduced according to auxiliary signs.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'If you see a "Detour" sign, you understand that:',
        'answers': [
          {'text': 'Shortcut', 'is_correct': false},
          {'text': 'Must go in an alternative direction', 'is_correct': true},
          {'text': 'No motorbikes', 'is_correct': false},
        ],
        'explanation':
            'A "Detour" sign means you must go in an alternative direction.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The sign "End Road Work" means:',
        'answers': [
          {'text': 'Start of construction site', 'is_correct': false},
          {'text': 'End of construction road', 'is_correct': true},
          {'text': 'Change to the left lane', 'is_correct': false},
        ],
        'explanation':
            'The "End Road Work" sign indicates the end of construction work.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'When passing a construction site with a flagman:',
        'answers': [
          {'text': 'Must listen to the coordinator', 'is_correct': true},
          {'text': 'Just follow the traffic light', 'is_correct': false},
          {'text': 'Honk to remind them to avoid', 'is_correct': false},
        ],
        'explanation':
            'When passing a construction site with a flagman, you must follow their instructions.',
        'difficultyLevel': 1,
      },
      // Set 10: Electronic signs and electronic signs (7 questions)
      {
        'questionText': 'Electronic signs can display:',
        'answers': [
          {'text': 'Traffic conditions, accidents, routes', 'is_correct': true},
          {'text': 'Advertisements', 'is_correct': false},
          {'text': 'Stopping and parking instructions', 'is_correct': false},
        ],
        'explanation':
            'Electronic signs can display traffic conditions, accidents, and route information.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The sign "Congestion Ahead" means:',
        'answers': [
          {'text': 'Road clear', 'is_correct': false},
          {'text': 'Traffic jam ahead', 'is_correct': true},
          {'text': 'Construction site', 'is_correct': false},
        ],
        'explanation':
            'The "Congestion Ahead" sign warns of traffic congestion ahead.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When the electronic sign says "Accident Ahead", you should:',
        'answers': [
          {'text': 'Speed up to pass', 'is_correct': false},
          {'text': 'Slow down and prepare to change lanes', 'is_correct': true},
          {'text': 'Honk', 'is_correct': false},
        ],
        'explanation':
            'When the electronic sign says "Accident Ahead", slow down and prepare to change lanes.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The "Amber Alert" sign is a warning about:',
        'answers': [
          {'text': 'Bad weather', 'is_correct': false},
          {
            'text': 'Missing children, danger to the community',
            'is_correct': true,
          },
          {'text': 'Vehicle breakdown', 'is_correct': false},
        ],
        'explanation':
            'The "Amber Alert" sign warns about missing children and danger to the community.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'An electronic sign with the words "Exit Closed" means:',
        'answers': [
          {'text': 'No right turn', 'is_correct': false},
          {'text': 'Exit temporarily closed', 'is_correct': true},
          {'text': 'Nothing important', 'is_correct': false},
        ],
        'explanation':
            'An electronic sign with "Exit Closed" means the exit is temporarily closed.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'If the electronic sign requires a speed reduction:',
        'answers': [
          {'text': 'Ignore it', 'is_correct': false},
          {'text': 'Must obey as a regular sign', 'is_correct': true},
          {'text': 'For trucks only', 'is_correct': false},
        ],
        'explanation':
            'If the electronic sign requires a speed reduction, you must obey it as a regular sign.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'Electronic lane notifications are only applicable:',
        'answers': [
          {'text': 'During rush hour', 'is_correct': true},
          {'text': 'All day', 'is_correct': false},
          {'text': 'Not required', 'is_correct': false},
        ],
        'explanation':
            'Electronic lane notifications are typically only applicable during rush hour.',
        'difficultyLevel': 1,
      },
      // Set 11: Highway signs – Highway signs (7 questions)
      {
        'questionText': 'A blue sign with a road number (e.g. I-80) is:',
        'answers': [
          {'text': 'Interstate', 'is_correct': true},
          {'text': 'Local name', 'is_correct': false},
          {'text': 'No stopping', 'is_correct': false},
        ],
        'explanation':
            'A blue sign with a road number indicates an interstate highway.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'A "Rest Area 1 Mile" sign means:',
        'answers': [
          {'text': 'Rest area 1 mile away', 'is_correct': true},
          {'text': 'Residential area', 'is_correct': false},
          {'text': 'No stopping zone', 'is_correct': false},
        ],
        'explanation':
            'A "Rest Area 1 Mile" sign indicates a rest area is 1 mile away.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'A "Exit 12A" sign indicates:',
        'answers': [
          {'text': 'Freeway entrance', 'is_correct': false},
          {'text': '12th exit', 'is_correct': true},
          {'text': 'End of road', 'is_correct': false},
        ],
        'explanation': 'An "Exit 12A" sign indicates the 12th exit.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'A "Mile Marker 123" sign is useful for:',
        'answers': [
          {
            'text': 'Calling for help or indicating a location',
            'is_correct': true,
          },
          {'text': 'Speeding', 'is_correct': false},
          {'text': 'Parking sign', 'is_correct': false},
        ],
        'explanation':
            'A "Mile Marker 123" sign is useful for calling for help or indicating a location.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'A brown sign usually indicates:',
        'answers': [
          {'text': 'Industrial area', 'is_correct': false},
          {'text': 'Recreational or park area', 'is_correct': true},
          {'text': 'Slippery Road', 'is_correct': false},
        ],
        'explanation':
            'A brown sign usually indicates a recreational or park area.',
        'difficultyLevel': 1,
      },
      {
        'questionText': '"Weigh Station" sign is used for:',
        'answers': [
          {'text': 'Private vehicles', 'is_correct': false},
          {'text': 'Trucks must stop for weight check', 'is_correct': true},
          {'text': 'Gas station', 'is_correct': false},
        ],
        'explanation':
            'A "Weigh Station" sign indicates that trucks must stop for weight checks.',
        'difficultyLevel': 1,
      },
      {
        'questionText': '"No Services" sign means:',
        'answers': [
          {'text': 'There is service nearby', 'is_correct': false},
          {
            'text': 'There is no gas station, water, rest stop',
            'is_correct': true,
          },
          {'text': 'Stopping is prohibited', 'is_correct': false},
        ],
        'explanation':
            'A "No Services" sign means there are no gas stations, water, or rest stops.',
        'difficultyLevel': 1,
      },
      // Set 12: Advanced Intersection Situations (7 questions)
      {
        'questionText':
            'When the light is green but the car in front has not moved, you should:',
        'answers': [
          {'text': 'Honk', 'is_correct': false},
          {
            'text': 'Wait for a safe distance and then move',
            'is_correct': true,
          },
          {'text': 'Pass into another lane', 'is_correct': false},
        ],
        'explanation':
            'When the light is green but the car in front has not moved, wait for a safe distance and then move.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'If you are in the left turn lane but want to go straight, you:',
        'answers': [
          {'text': 'Just go straight', 'is_correct': false},
          {'text': 'Turn in the direction of the lane', 'is_correct': true},
          {'text': 'Back up', 'is_correct': false},
        ],
        'explanation':
            'If you are in the left turn lane, you must turn in the direction of the lane.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When the light turns yellow in the middle of the intersection, you should:',
        'answers': [
          {
            'text': 'Continue if you have entered the intersection',
            'is_correct': true,
          },
          {'text': 'Brake suddenly', 'is_correct': false},
          {'text': 'Turn around', 'is_correct': false},
        ],
        'explanation':
            'When the light turns yellow in the middle of the intersection, continue if you have entered the intersection.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'At a busy intersection, you should:',
        'answers': [
          {'text': 'Move in if the light is green', 'is_correct': false},
          {
            'text': 'Wait for a space ahead before entering',
            'is_correct': true,
          },
          {'text': 'Continue, other vehicles will yield', 'is_correct': false},
        ],
        'explanation':
            'At a busy intersection, wait for a space ahead before entering.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'A red light with a green arrow for a left turn means:',
        'answers': [
          {'text': 'Turn left without stopping', 'is_correct': true},
          {'text': 'No turning', 'is_correct': false},
          {'text': 'Turn left but must yield', 'is_correct': false},
        ],
        'explanation':
            'A red light with a green arrow for a left turn means you can turn left without stopping.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When a vehicle is driving in the wrong lane at an intersection, you:',
        'answers': [
          {
            'text': 'Yield if necessary to avoid a collision',
            'is_correct': true,
          },
          {'text': 'Honk', 'is_correct': false},
          {'text': 'Swerve quickly', 'is_correct': false},
        ],
        'explanation':
            'When a vehicle is driving in the wrong lane at an intersection, yield if necessary to avoid a collision.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When the traffic light and the stop line do not match:',
        'answers': [
          {'text': 'Stop at the stop line', 'is_correct': true},
          {'text': 'Stop immediately at the light', 'is_correct': false},
          {'text': 'Stop after the light', 'is_correct': false},
        ],
        'explanation':
            'When the traffic light and the stop line do not match, stop at the stop line.',
        'difficultyLevel': 1,
      },
      // Set 13: Special Warning Signs (8 questions)
      {
        'questionText': 'The "Falling Rocks" sign warns of:',
        'answers': [
          {'text': 'Slippery area', 'is_correct': false},
          {
            'text': 'Falling rocks – drive slowly and carefully',
            'is_correct': true,
          },
          {'text': 'Trucks are prohibited', 'is_correct': false},
        ],
        'explanation':
            'The "Falling Rocks" sign warns of falling rocks and advises driving slowly and carefully.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The "Animal Crossing" sign warns of:',
        'answers': [
          {'text': 'Farm area', 'is_correct': false},
          {'text': 'Animals may cross', 'is_correct': true},
          {'text': 'Park road', 'is_correct': false},
        ],
        'explanation':
            'The "Animal Crossing" sign warns that animals may cross the road.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The "Truck Rollover Risk" sign warns of:',
        'answers': [
          {
            'text': 'Trucks should slow down when cornering',
            'is_correct': true,
          },
          {'text': 'Trucks have priority', 'is_correct': false},
          {'text': 'Not applicable to private vehicles', 'is_correct': false},
        ],
        'explanation':
            'The "Truck Rollover Risk" sign warns that trucks should slow down when cornering.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The "Road Narrows" sign means:',
        'answers': [
          {'text': 'Road widening', 'is_correct': false},
          {'text': 'Road ahead narrowing', 'is_correct': true},
          {'text': 'Road turning left', 'is_correct': false},
        ],
        'explanation':
            'The "Road Narrows" sign means the road ahead is narrowing.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The "Soft Shoulder" sign means:',
        'answers': [
          {'text': 'Weak shoulder, do not drive on', 'is_correct': true},
          {'text': 'For bicycles', 'is_correct': false},
          {'text': 'Rest stop', 'is_correct': false},
        ],
        'explanation':
            'The "Soft Shoulder" sign means the shoulder is weak and you should not drive on it.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The sign "Cross Traffic Does Not Stop" means:',
        'answers': [
          {'text': 'Oncoming vehicles have priority', 'is_correct': true},
          {'text': 'All vehicles stop', 'is_correct': false},
          {'text': 'No STOP sign', 'is_correct': false},
        ],
        'explanation':
            'The "Cross Traffic Does Not Stop" sign means oncoming vehicles have priority.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The sign "Hidden Driveway" warns:',
        'answers': [
          {
            'text': 'There is a turn that is hidden from view',
            'is_correct': true,
          },
          {'text': 'End of road', 'is_correct': false},
          {'text': 'Soft shoulder', 'is_correct': false},
        ],
        'explanation':
            'The "Hidden Driveway" sign warns of a turn that is hidden from view.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The sign "Dip" on the road surface means:',
        'answers': [
          {'text': 'Steep slope', 'is_correct': false},
          {'text': 'Unexpected depression/sag', 'is_correct': true},
          {'text': 'Puddle', 'is_correct': false},
        ],
        'explanation':
            'The "Dip" sign on the road surface means there is an unexpected depression or sag.',
        'difficultyLevel': 1,
      },
      // Set 14: Strange situations, special auxiliary signs (8 questions)
      {
        'questionText': 'The auxiliary sign "Next 5 Miles" means:',
        'answers': [
          {
            'text': 'The main law/sign applies for the next 5 miles',
            'is_correct': true,
          },
          {'text': '5 miles traveled through', 'is_correct': false},
          {'text': 'Temporary sign', 'is_correct': false},
        ],
        'explanation':
            'The auxiliary sign "Next 5 Miles" means the main law or sign applies for the next 5 miles.',
        'difficultyLevel': 1,
      },
      {
        'questionText': '"Share The Road" sign means:',
        'answers': [
          {'text': 'Narrow road', 'is_correct': false},
          {'text': 'Must share with bicycles/pedestrians', 'is_correct': true},
          {'text': 'No overtaking', 'is_correct': false},
        ],
        'explanation':
            'The "Share The Road" sign means you must share the road with bicycles and pedestrians.',
        'difficultyLevel': 1,
      },
      {
        'questionText': '"Advisory Speed 35" sign means:',
        'answers': [
          {'text': 'Mandatory speed', 'is_correct': false},
          {'text': 'Recommended speed in a curve', 'is_correct': true},
          {'text': 'Minimum speed', 'is_correct': false},
        ],
        'explanation':
            'The "Advisory Speed 35" sign indicates the recommended speed in a curve.',
        'difficultyLevel': 1,
      },
      {
        'questionText': '"Minimum Speed 45" sign means:',
        'answers': [
          {'text': 'Maximum speed', 'is_correct': false},
          {'text': 'Minimum speed', 'is_correct': true},
          {'text': 'Turn restriction', 'is_correct': false},
        ],
        'explanation':
            'The "Minimum Speed 45" sign indicates the minimum speed allowed.',
        'difficultyLevel': 1,
      },
      {
        'questionText': '"Yield Ahead" sign indicates:',
        'answers': [
          {'text': 'Yield ahead', 'is_correct': true},
          {'text': 'No overtaking', 'is_correct': false},
          {'text': 'Stop immediately', 'is_correct': false},
        ],
        'explanation':
            'The "Yield Ahead" sign indicates that a yield sign is ahead.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            '"Wrong Way" sign accompanied by "Do Not Enter" usually:',
        'answers': [
          {'text': 'Indicates going the wrong way', 'is_correct': true},
          {'text': 'Time warning section', 'is_correct': false},
          {'text': 'Not applicable at night', 'is_correct': false},
        ],
        'explanation':
            'The "Wrong Way" sign accompanied by "Do Not Enter" indicates you are going the wrong way.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The "Low Clearance" sign has the effect of:',
        'answers': [
          {
            'text': 'Warning of low bridge, prohibiting high vehicles',
            'is_correct': true,
          },
          {'text': 'Prohibiting container trucks', 'is_correct': false},
          {'text': 'Slowing down', 'is_correct': false},
        ],
        'explanation':
            'The "Low Clearance" sign warns of a low bridge and prohibits high vehicles.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The "No Outlet" sign means:',
        'answers': [
          {'text': 'Dead end – no other exit', 'is_correct': true},
          {'text': 'No overtaking', 'is_correct': false},
          {'text': 'No service station', 'is_correct': false},
        ],
        'explanation':
            'The "No Outlet" sign means it is a dead end with no other exit.',
        'difficultyLevel': 1,
      },
      // Set 15: Mixed and complex traffic (10 questions)
      {
        'questionText':
            'When the intersection has overlapping STOP and YIELD signs:',
        'answers': [
          {'text': 'Stop completely', 'is_correct': true},
          {'text': 'Just slow down', 'is_correct': false},
          {'text': 'Yield if you see a vehicle', 'is_correct': false},
        ],
        'explanation':
            'When the intersection has overlapping STOP and YIELD signs, you must stop completely.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When the light flashes green with a left turn arrow, you:',
        'answers': [
          {'text': 'Must stop', 'is_correct': false},
          {'text': 'Can turn left without yielding', 'is_correct': true},
          {'text': 'Turn right', 'is_correct': false},
        ],
        'explanation':
            'When the light flashes green with a left turn arrow, you can turn left without yielding.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When you see the "Reduced Speed Ahead" sign, you should:',
        'answers': [
          {'text': 'Maintain speed', 'is_correct': false},
          {'text': 'Slow down before next sign', 'is_correct': true},
          {'text': 'Accelerate quickly', 'is_correct': false},
        ],
        'explanation':
            'When you see the "Reduced Speed Ahead" sign, slow down before the next sign.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The "Emergency Stopping Only" sign means:',
        'answers': [
          {'text': 'Stop at any time', 'is_correct': false},
          {'text': 'Stop only in emergency situations', 'is_correct': true},
          {'text': 'No stopping', 'is_correct': false},
        ],
        'explanation':
            'The "Emergency Stopping Only" sign means you should stop only in emergency situations.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When there are multiple STOP lines at an intersection, you:',
        'answers': [
          {'text': 'Stop at the first line', 'is_correct': true},
          {
            'text': 'Cross the line if there are no vehicles',
            'is_correct': false,
          },
          {'text': 'Stop anywhere', 'is_correct': false},
        ],
        'explanation':
            'When there are multiple STOP lines at an intersection, stop at the first line.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'A traffic light hanging to the right of the road means:',
        'answers': [
          {'text': 'Applies to the right lane', 'is_correct': true},
          {'text': 'Invalid', 'is_correct': false},
          {'text': 'Only for trucks', 'is_correct': false},
        ],
        'explanation':
            'A traffic light hanging to the right of the road applies to the right lane.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When you see the "Photo Enforced" sign, you understand:',
        'answers': [
          {
            'text': 'There is a camera to take pictures of traffic violations',
            'is_correct': true,
          },
          {'text': 'Security camera', 'is_correct': false},
          {'text': 'Only to scare', 'is_correct': false},
        ],
        'explanation':
            'The "Photo Enforced" sign indicates there is a camera to take pictures of traffic violations.',
        'difficultyLevel': 1,
      },
      {
        'questionText': '"Left Turn Yield" sign on Green" means:',
        'answers': [
          {
            'text':
                'Left turn is allowed when the light is green but must yield',
            'is_correct': true,
          },
          {'text': 'Left turn is prohibited', 'is_correct': false},
          {'text': 'Left turn is required', 'is_correct': false},
        ],
        'explanation':
            'The "Left Turn Yield on Green" sign means left turn is allowed when the light is green but must yield.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'The intersection has many traffic light arrows, which direction do you go?',
        'answers': [
          {'text': 'Follow your lane arrow', 'is_correct': true},
          {'text': 'Nearest arrow', 'is_correct': false},
          {'text': 'Any lane', 'is_correct': false},
        ],
        'explanation':
            'When the intersection has many traffic light arrows, follow your lane arrow.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When you see the sign "End Divided Highway", you understand:',
        'answers': [
          {
            'text': 'The road changes from 2 lanes to 1 way',
            'is_correct': true,
          },
          {'text': 'Start of freeway', 'is_correct': false},
          {'text': 'End of road', 'is_correct': false},
        ],
        'explanation':
            'The "End Divided Highway" sign means the road changes from 2 lanes to 1 way.',
        'difficultyLevel': 1,
      },
      // Set 16: Advanced comprehensive review (10 questions)
      {
        'questionText':
            'When you see the "Yield" sign but there are no vehicles, you:',
        'answers': [
          {'text': 'Still have to stop', 'is_correct': false},
          {'text': 'Can continue if it is safe', 'is_correct': true},
          {'text': 'Turn around', 'is_correct': false},
        ],
        'explanation':
            'When you see a "Yield" sign but there are no vehicles, you can continue if it is safe.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The sign "Two Way Traffic" means:',
        'answers': [
          {'text': 'One-way road', 'is_correct': false},
          {'text': 'Road with oncoming vehicles', 'is_correct': true},
          {'text': 'Bus lane', 'is_correct': false},
        ],
        'explanation':
            'The "Two Way Traffic" sign means the road has oncoming vehicles.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'The sign "School Zone When Flashing" means:',
        'answers': [
          {
            'text': 'Speed limit applies when the lights are flashing',
            'is_correct': true,
          },
          {'text': 'Always effective force', 'is_correct': false},
          {'text': 'Only applies at night', 'is_correct': false},
        ],
        'explanation':
            'The "School Zone When Flashing" sign means the speed limit applies when the lights are flashing.',
        'difficultyLevel': 1,
      },
      {
        'questionText': 'When you see a "Merge Right" sign, you are:',
        'answers': [
          {
            'text': 'Preparing to merge into the right lane',
            'is_correct': true,
          },
          {'text': 'Turning left', 'is_correct': false},
          {'text': 'Stopping', 'is_correct': false},
        ],
        'explanation':
            'When you see a "Merge Right" sign, you are preparing to merge into the right lane.',
        'difficultyLevel': 1,
      },
      {
        'questionText': '"No Left Turn" sign but you need to turn around, you:',
        'answers': [
          {'text': 'Turn around if it is safe', 'is_correct': false},
          {'text': 'Do not turn around here', 'is_correct': true},
          {'text': 'Turn right instead', 'is_correct': false},
        ],
        'explanation':
            'When there is a "No Left Turn" sign, you should not turn around here.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'Intersection with a "Yield" sign and pedestrians crossing the road:',
        'answers': [
          {'text': 'Give pedestrians priority', 'is_correct': true},
          {'text': 'Honk', 'is_correct': false},
          {'text': 'Continue if you are going faster', 'is_correct': false},
        ],
        'explanation':
            'At an intersection with a "Yield" sign and pedestrians crossing, give pedestrians priority.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            '"Lane Ends Merge Left" sign but you are in the right lane:',
        'answers': [
          {'text': 'Yield and merge left', 'is_correct': true},
          {'text': 'Speed up', 'is_correct': false},
          {
            'text': 'Stay in your lane and wait for another vehicle to pass',
            'is_correct': false,
          },
        ],
        'explanation':
            'When you see a "Lane Ends Merge Left" sign and you are in the right lane, yield and merge left.',
        'difficultyLevel': 1,
      },
      {
        'questionText': '"No Turn on Red" sign but you do not see a vehicle:',
        'answers': [
          {
            'text': 'Still have to stop and wait for the light green',
            'is_correct': true,
          },
          {'text': 'Turn fast', 'is_correct': false},
          {'text': 'Flash and go', 'is_correct': false},
        ],
        'explanation':
            'When there is a "No Turn on Red" sign, you still have to stop and wait for the green light.',
        'difficultyLevel': 1,
      },
      {
        'questionText': '"Slower Traffic Keep Right" sign means:',
        'answers': [
          {'text': 'Slower vehicles must keep right', 'is_correct': true},
          {'text': 'Speed up', 'is_correct': false},
          {'text': 'Do not need to obey', 'is_correct': false},
        ],
        'explanation':
            'The "Slower Traffic Keep Right" sign means slower vehicles must keep to the right.',
        'difficultyLevel': 1,
      },
      {
        'questionText':
            'When the electronic sign updates the speed in real time, you:',
        'answers': [
          {'text': 'Must obey', 'is_correct': true},
          {'text': 'Can ignore it', 'is_correct': false},
          {'text': 'Only applies to trucks', 'is_correct': false},
        ],
        'explanation':
            'When the electronic sign updates the speed in real time, you must obey it.',
        'difficultyLevel': 1,
      },
    ];

    for (var question in questions) {
      try {
        await questionService.addQuestion(
          categoryId: 2,
          questionText: question['questionText'] as String,
          answers: question['answers'] as List<Map<String, dynamic>>,
          explanation: question['explanation'] as String,
          difficultyLevel: question['difficultyLevel'] as int,
        );
      } catch (e) {
        // Skip this question if there's an error
        continue;
      }
    }
  }

  // Unit 3: Defensive Driving
  static Future<void> _loadUnit3Questions(
    QuestionService questionService,
  ) async {
    final questions = [
      // Set 1: Keep your distance and observe (5 questions)
      {
        'questionText': 'The 3-second rule is used to:',
        'answers': [
          {'text': 'Remember the road', 'is_correct': false},
          {
            'text': 'Ensure a safe distance between vehicles',
            'is_correct': true,
          },
          {'text': 'Accelerate behind another vehicle', 'is_correct': false},
        ],
        'explanation':
            'The 3-second rule is used to ensure a safe distance between vehicles.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'The way to check the safe distance is:',
        'answers': [
          {
            'text':
                'Count 1–2–3 when the vehicle in front passes a fixed object',
            'is_correct': true,
          },
          {'text': 'Follow the vehicle in front closely', 'is_correct': false},
          {'text': 'Look in the mirror', 'is_correct': false},
        ],
        'explanation':
            'Count 1–2–3 when the vehicle in front passes a fixed object to check safe distance.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When it is raining or the road is slippery, the distance should be:',
        'answers': [
          {'text': 'Shorten', 'is_correct': false},
          {'text': 'Keep the same', 'is_correct': false},
          {'text': 'Double', 'is_correct': true},
        ],
        'explanation':
            'When it is raining or the road is slippery, the distance should be doubled.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'The most effective way to observe blind spots is to:',
        'answers': [
          {'text': 'Use the rearview mirror', 'is_correct': false},
          {'text': 'Look directly over your shoulder', 'is_correct': true},
          {'text': 'Look at the rearview camera', 'is_correct': false},
        ],
        'explanation':
            'The most effective way to observe blind spots is to look directly over your shoulder.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When the vehicle in front shows signs of braking, you should:',
        'answers': [
          {'text': 'Brake hard immediately', 'is_correct': false},
          {
            'text': 'Observe and brake gently from a distance',
            'is_correct': true,
          },
          {'text': 'Overtake immediately', 'is_correct': false},
        ],
        'explanation':
            'When the vehicle in front shows signs of braking, observe and brake gently from a distance.',
        'difficultyLevel': 2,
      },

      // Set 2: Identifying danger and reacting (6 questions)
      {
        'questionText':
            'When you see children playing near the road, you should:',
        'answers': [
          {'text': 'Honk', 'is_correct': false},
          {'text': 'Speed up', 'is_correct': false},
          {'text': 'Slow down and be ready to stop', 'is_correct': true},
        ],
        'explanation':
            'When you see children playing near the road, slow down and be ready to stop.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'The car in front moves erratically, you:',
        'answers': [
          {'text': 'Keep a larger distance', 'is_correct': true},
          {'text': 'Overtake immediately', 'is_correct': false},
          {'text': 'Stick to the warning', 'is_correct': false},
        ],
        'explanation':
            'When the car in front moves erratically, keep a larger distance.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When you are blocked by a "blind spot", you should:',
        'answers': [
          {'text': 'Accelerate', 'is_correct': false},
          {
            'text': 'Adjust your position to have a better view',
            'is_correct': true,
          },
          {'text': 'Ignore', 'is_correct': false},
        ],
        'explanation':
            'When you are blocked by a "blind spot", adjust your position to have a better view.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'The car on the opposite side is going in the wrong lane, you should:',
        'answers': [
          {'text': 'Honk', 'is_correct': false},
          {
            'text': 'Slow down, move to the right if necessary',
            'is_correct': true,
          },
          {'text': 'Overtake on the left', 'is_correct': false},
        ],
        'explanation':
            'When the car on the opposite side is going in the wrong lane, slow down, move to the right if necessary.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When your car is encroached by the car on the other side next to:',
        'answers': [
          {'text': 'Brake and keep lane', 'is_correct': true},
          {'text': 'Follow closely', 'is_correct': false},
          {
            'text': 'Change lanes in the opposite direction',
            'is_correct': false,
          },
        ],
        'explanation':
            'When your car is encroached by the car on the other side, brake and keep lane.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'If you detect a pedestrian suddenly crossing the road:',
        'answers': [
          {'text': 'Honk', 'is_correct': false},
          {'text': 'Stop immediately if safe', 'is_correct': true},
          {'text': 'Turn to another lane', 'is_correct': false},
        ],
        'explanation':
            'If you detect a pedestrian suddenly crossing the road, stop immediately if safe.',
        'difficultyLevel': 2,
      },

      // Set 3: Weather and special conditions (6 questions)
      {
        'questionText': 'When it rains heavily, you should turn on:',
        'answers': [
          {'text': 'High beams', 'is_correct': false},
          {'text': 'Low beams and wipers', 'is_correct': true},
          {'text': 'Hazard lights (flashing)', 'is_correct': false},
        ],
        'explanation': 'When it rains heavily, turn on low beams and wipers.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When the road is slippery, you should:',
        'answers': [
          {'text': 'Maintain speed', 'is_correct': false},
          {'text': 'Slow down and avoid sudden braking', 'is_correct': true},
          {'text': 'Accelerate quickly to pass', 'is_correct': false},
        ],
        'explanation':
            'When the road is slippery, slow down and avoid sudden braking.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When the fog is thick, you should:',
        'answers': [
          {'text': 'Turn on high beams', 'is_correct': false},
          {'text': 'Turn on fog lights or low beams', 'is_correct': true},
          {'text': 'Turn off lights', 'is_correct': false},
        ],
        'explanation':
            'When the fog is thick, turn on fog lights or low beams.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'It is dark If there are street lights, you should:',
        'answers': [
          {
            'text': 'Turn on high beams if there are no oncoming vehicles',
            'is_correct': true,
          },
          {'text': 'Turn off lights to avoid glare', 'is_correct': false},
          {'text': 'Turn continuously', 'is_correct': false},
        ],
        'explanation':
            'When it is dark and there are street lights, turn on high beams if there are no oncoming vehicles.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When there is a strong wind (crosswind), especially with a large vehicle:',
        'answers': [
          {
            'text': 'Hold the steering wheel firmly and slow down',
            'is_correct': true,
          },
          {'text': 'Speed up', 'is_correct': false},
          {'text': 'Turn sharply', 'is_correct': false},
        ],
        'explanation':
            'When there is a strong wind (crosswind), especially with a large vehicle, hold the steering wheel firmly and slow down.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'Driving after a heavy rain, you should:',
        'answers': [
          {'text': 'Speed up to avoid flooding', 'is_correct': false},
          {'text': 'Drive slowly and avoid large puddles', 'is_correct': true},
          {'text': 'Honk when passing through puddles', 'is_correct': false},
        ],
        'explanation':
            'When driving after a heavy rain, drive slowly and avoid large puddles.',
        'difficultyLevel': 2,
      },

      // Set 4: Bad weather and handling situations (7 questions)
      {
        'questionText':
            'When the tire loses traction due to slippery roads, you should:',
        'answers': [
          {'text': 'Brake hard', 'is_correct': false},
          {
            'text':
                'Gently turn the steering wheel in the direction of the slide',
            'is_correct': true,
          },
          {'text': 'Release the steering wheel', 'is_correct': false},
        ],
        'explanation':
            'When the tire loses traction due to slippery roads, gently turn the steering wheel in the direction of the slide.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When driving through thick fog, the distance from the vehicle in front should:',
        'answers': [
          {'text': 'Maintain the same', 'is_correct': false},
          {'text': 'Double or more', 'is_correct': true},
          {
            'text': 'Follow closely to observe the taillights',
            'is_correct': false,
          },
        ],
        'explanation':
            'When driving through thick fog, the distance from the vehicle in front should double or more.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'In rainy conditions, you should avoid:',
        'answers': [
          {'text': 'Accelerate when flooded', 'is_correct': false},
          {'text': 'Brake suddenly', 'is_correct': true},
          {'text': 'Turn on the turn signal', 'is_correct': false},
        ],
        'explanation': 'In rainy conditions, avoid braking suddenly.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When visibility is limited by glare:',
        'answers': [
          {'text': 'Use sunglasses or sunshades', 'is_correct': true},
          {'text': 'Look straight ahead', 'is_correct': false},
          {'text': 'Accelerate to escape quickly', 'is_correct': false},
        ],
        'explanation':
            'When visibility is limited by glare, use sunglasses or sunshades.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When encountering an icy road, you should:',
        'answers': [
          {
            'text': 'Brake lightly and maintain a steady speed',
            'is_correct': true,
          },
          {'text': 'Turn quickly', 'is_correct': false},
          {'text': 'Use the handbrake', 'is_correct': false},
        ],
        'explanation':
            'When encountering an icy road, brake lightly and maintain a steady speed.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When driving across a bridge in winter:',
        'answers': [
          {
            'text': 'Go slowly because the bridge is prone to ice',
            'is_correct': true,
          },
          {'text': 'Accelerate to avoid slipping', 'is_correct': false},
          {'text': 'Do not change behavior', 'is_correct': false},
        ],
        'explanation':
            'When driving across a bridge in winter, go slowly because the bridge is prone to ice.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'Driving at night with fog should use:',
        'answers': [
          {'text': 'Low beams', 'is_correct': true},
          {'text': 'High beams', 'is_correct': false},
          {'text': 'No lights needed', 'is_correct': false},
        ],
        'explanation': 'When driving at night with fog, use low beams.',
        'difficultyLevel': 2,
      },

      // Set 5: Collision prevention - simulation (7 questions)
      {
        'questionText': 'If the car in front brakes suddenly, you should:',
        'answers': [
          {'text': 'Brake gently and steer to avoid', 'is_correct': true},
          {'text': 'Pass to the left lane', 'is_correct': false},
          {'text': 'Honk the horn', 'is_correct': false},
        ],
        'explanation':
            'If the car in front brakes suddenly, brake gently and steer to avoid.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When the car skids in a curve:',
        'answers': [
          {'text': 'Reverse the steering wheel', 'is_correct': false},
          {
            'text':
                'Keep the steering wheel in the direction of the slide and reduce the throttle',
            'is_correct': true,
          },
          {'text': 'Brake hard', 'is_correct': false},
        ],
        'explanation':
            'When the car skids in a curve, keep the steering wheel in the direction of the slide and reduce the throttle.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When encountering a car cutting in front of you suddenly, you should:',
        'answers': [
          {'text': 'Brake hard, stay in the lane', 'is_correct': true},
          {'text': 'Change lanes suddenly', 'is_correct': false},
          {'text': 'Honk and overtake', 'is_correct': false},
        ],
        'explanation':
            'When encountering a car cutting in front of you suddenly, brake hard, stay in the lane.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When the oncoming vehicle encroaches on your lane, you:',
        'answers': [
          {'text': 'Honk', 'is_correct': false},
          {'text': 'Dodge to the right and slow down', 'is_correct': true},
          {'text': 'Accelerate to avoid', 'is_correct': false},
        ],
        'explanation':
            'When the oncoming vehicle encroaches on your lane, dodge to the right and slow down.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'If your tire bursts while driving fast:',
        'answers': [
          {
            'text': 'Hold the steering wheel tightly, do not brake suddenly',
            'is_correct': true,
          },
          {'text': 'Turn the steering wheel', 'is_correct': false},
          {'text': 'Stop immediately', 'is_correct': false},
        ],
        'explanation':
            'If your tire bursts while driving fast, hold the steering wheel tightly, do not brake suddenly.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When you are blinded by the headlights of the oncoming vehicle:',
        'answers': [
          {
            'text': 'Look down at the right line of the road',
            'is_correct': true,
          },
          {'text': 'Look straight ahead', 'is_correct': false},
          {'text': 'Close your eyes', 'is_correct': false},
        ],
        'explanation':
            'When you are blinded by the headlights of the oncoming vehicle, look down at the right line of the road.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'The first reaction when the vehicle starts to lose control is:',
        'answers': [
          {'text': 'Reduce the throttle and stay calm', 'is_correct': true},
          {'text': 'Brake immediately', 'is_correct': false},
          {'text': 'Turn the steering wheel sharply', 'is_correct': false},
        ],
        'explanation':
            'The first reaction when the vehicle starts to lose control is to reduce the throttle and stay calm.',
        'difficultyLevel': 2,
      },

      // Set 6: Defensive behavior – with other drivers (9 questions)
      {
        'questionText':
            'If there is an aggressive driver in front of you after:',
        'answers': [
          {'text': 'Yield when safe', 'is_correct': true},
          {'text': 'Brake to intimidate', 'is_correct': false},
          {'text': 'Speed up', 'is_correct': false},
        ],
        'explanation':
            'If there is an aggressive driver in front of you, yield when safe.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When you encounter a driver who suddenly changes lanes, you should:',
        'answers': [
          {'text': 'Keep your distance and be cautious', 'is_correct': true},
          {'text': 'Drive parallel', 'is_correct': false},
          {'text': 'Try to pass', 'is_correct': false},
        ],
        'explanation':
            'When you encounter a driver who suddenly changes lanes, keep your distance and be cautious.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When someone else uses their horn, you:',
        'answers': [
          {'text': 'React', 'is_correct': false},
          {'text': 'Stay calm and check your surroundings', 'is_correct': true},
          {'text': 'Ignore', 'is_correct': false},
        ],
        'explanation':
            'When someone else uses their horn, stay calm and check your surroundings.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When you encounter a driver who is weaving in and out:',
        'answers': [
          {'text': 'Stay close', 'is_correct': false},
          {
            'text': 'Stay away and notify the police if necessary',
            'is_correct': true,
          },
          {'text': 'Chase', 'is_correct': false},
        ],
        'explanation':
            'When you encounter a driver who is weaving in and out, stay away and notify the police if necessary.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When you encounter a driver who is illegally overtaking:',
        'answers': [
          {'text': 'Compete', 'is_correct': false},
          {'text': 'Slow down and yield', 'is_correct': true},
          {'text': 'Speed up to overtake', 'is_correct': false},
        ],
        'explanation':
            'When you encounter a driver who is illegally overtaking, slow down and yield.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'If the car in front turns on its turn signal but does not turn:',
        'answers': [
          {'text': 'Wait for them to turn', 'is_correct': false},
          {'text': 'Overtake only when sure and safety', 'is_correct': true},
          {'text': 'Honk', 'is_correct': false},
        ],
        'explanation':
            'If the car in front turns on its turn signal but does not turn, overtake only when sure and safety.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'A truck has a large blind spot, you should:',
        'answers': [
          {'text': 'Not tailgate', 'is_correct': true},
          {'text': 'Pass on the right', 'is_correct': false},
          {'text': 'Turn behind', 'is_correct': false},
        ],
        'explanation':
            'A truck has a large blind spot, you should not tailgate.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'Other drivers are behaving dangerously:',
        'answers': [
          {'text': 'Try to pass', 'is_correct': false},
          {'text': 'Observe and create distance', 'is_correct': true},
          {'text': 'React by honking', 'is_correct': false},
        ],
        'explanation':
            'When other drivers are behaving dangerously, observe and create distance.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'If tailgating:',
        'answers': [
          {'text': 'Brake lightly or change lanes if safe', 'is_correct': true},
          {'text': 'Brake hard', 'is_correct': false},
          {'text': 'Accelerate', 'is_correct': false},
        ],
        'explanation': 'If tailgating, brake lightly or change lanes if safe.',
        'difficultyLevel': 2,
      },

      // Set 7: Advanced Summary (9 questions)
      {
        'questionText': 'Defensive driving is:',
        'answers': [
          {'text': 'Always yielding', 'is_correct': false},
          {
            'text': 'Detecting hazards and responding appropriately',
            'is_correct': true,
          },
          {'text': 'Slowing down', 'is_correct': false},
        ],
        'explanation':
            'Defensive driving is detecting hazards and responding appropriately.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'What is the priority of defensive driving?',
        'answers': [
          {'text': 'Finish early', 'is_correct': false},
          {'text': 'Safety for yourself and others', 'is_correct': true},
          {'text': 'Avoid traffic jams', 'is_correct': false},
        ],
        'explanation':
            'The priority of defensive driving is safety for yourself and others.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'Effective intersection observation is:',
        'answers': [
          {'text': 'Look left → right → left', 'is_correct': true},
          {'text': 'Look straight', 'is_correct': false},
          {'text': 'Look right', 'is_correct': false},
        ],
        'explanation':
            'Effective intersection observation is look left → right → left.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When driving near a bicycle:',
        'answers': [
          {'text': 'Keep a distance of 3 feet or more', 'is_correct': true},
          {'text': 'Honk', 'is_correct': false},
          {'text': 'Pass quickly', 'is_correct': false},
        ],
        'explanation':
            'When driving near a bicycle, keep a distance of 3 feet or more.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'The appropriate speed in a densely populated area is:',
        'answers': [
          {'text': 'Follow the sign', 'is_correct': false},
          {'text': 'Depends on conditions and situations', 'is_correct': true},
          {'text': 'As slow as possible', 'is_correct': false},
        ],
        'explanation':
            'The appropriate speed in a densely populated area depends on conditions and situations.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When changing lanes, you should check:',
        'answers': [
          {'text': 'Side mirrors', 'is_correct': false},
          {'text': 'Shoulder-level blind spot mirrors', 'is_correct': true},
          {'text': 'Rearview camera', 'is_correct': false},
        ],
        'explanation':
            'When changing lanes, you should check shoulder-level blind spot mirrors.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'If you are unsure of the direction at an intersection:',
        'answers': [
          {'text': 'Stop', 'is_correct': false},
          {'text': 'Look carefully and go when it is safe', 'is_correct': true},
          {'text': 'Turn left', 'is_correct': false},
        ],
        'explanation':
            'If you are unsure of the direction at an intersection, look carefully and go when it is safe.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'Unexpected situations such as objects falling on the road:',
        'answers': [
          {'text': 'Turn the steering wheel sharply', 'is_correct': false},
          {
            'text': 'Hold the steering wheel, slow down and gradually avoid',
            'is_correct': true,
          },
          {'text': 'Honk the horn', 'is_correct': false},
        ],
        'explanation':
            'For unexpected situations such as objects falling on the road, hold the steering wheel, slow down and gradually avoid.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'Limit the risk of collision from other drivers by:',
        'answers': [
          {
            'text': 'Drive carefully, keep distance, observe',
            'is_correct': true,
          },
          {'text': 'Drive faster', 'is_correct': false},
          {'text': 'Drive parallel to other vehicles', 'is_correct': false},
        ],
        'explanation':
            'Limit the risk of collision from other drivers by driving carefully, keep distance, observe.',
        'difficultyLevel': 2,
      },
    ];

    for (var question in questions) {
      try {
        await questionService.addQuestion(
          categoryId: 3,
          questionText: question['questionText'] as String,
          answers: question['answers'] as List<Map<String, dynamic>>,
          explanation: question['explanation'] as String,
          difficultyLevel: question['difficultyLevel'] as int,
        );
      } catch (e) {
        // Skip this question if there's an error
        continue;
      }
    }
  }

  // Unit 4: Special Driving Situations
  static Future<void> _loadUnit4Questions(
    QuestionService questionService,
  ) async {
    final questions = [
      // Set 1: Driving in rain, snow, slippery roads (5 questions)
      {
        'questionText': 'When it rains heavily, you should:',
        'answers': [
          {'text': 'Turn on high beams', 'is_correct': false},
          {'text': 'Slow down and keep a longer distance', 'is_correct': true},
          {
            'text': 'Stick close to the car in front to avoid water',
            'is_correct': false,
          },
        ],
        'explanation':
            'When it rains heavily, slow down and keep a longer distance.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When there are large puddles on the road, you should:',
        'answers': [
          {'text': 'Accelerate to pass quickly', 'is_correct': false},
          {'text': 'Brake suddenly', 'is_correct': false},
          {'text': 'Stay away or slow down', 'is_correct': true},
        ],
        'explanation':
            'When there are large puddles on the road, stay away or slow down.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When the car is "hydroplaning", you should:',
        'answers': [
          {
            'text':
                'Keep the steering wheel straight, reduce the throttle gradually',
            'is_correct': true,
          },
          {'text': 'Brake suddenly', 'is_correct': false},
          {'text': 'Turn the steering wheel', 'is_correct': false},
        ],
        'explanation':
            'When the car is hydroplaning, keep the steering wheel straight, reduce the throttle gradually.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When driving in snow, you should use:',
        'answers': [
          {'text': 'Regular tires', 'is_correct': false},
          {'text': 'Special tires and reduce speed', 'is_correct': true},
          {'text': 'Drive normally', 'is_correct': false},
        ],
        'explanation':
            'When driving in snow, use special tires and reduce speed.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When braking on icy roads, you should:',
        'answers': [
          {'text': 'Brake hard', 'is_correct': false},
          {
            'text': 'Apply the brake lightly and keep it steady',
            'is_correct': true,
          },
          {'text': 'No braking', 'is_correct': false},
        ],
        'explanation':
            'When braking on icy roads, apply the brake lightly and keep it steady.',
        'difficultyLevel': 3,
      },

      // Set 2: Driving at night and limited visibility (6 questions)
      {
        'questionText': 'When driving at night, you should observe by:',
        'answers': [
          {'text': 'Looking far towards the lights', 'is_correct': false},
          {
            'text': 'Observing the bright area of the headlights',
            'is_correct': true,
          },
          {'text': 'Looking to the left', 'is_correct': false},
        ],
        'explanation':
            'When driving at night, observe the bright area of the headlights.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When meeting an oncoming vehicle with high beams:',
        'answers': [
          {'text': 'Looking straight', 'is_correct': false},
          {'text': 'Looking to the right of the road', 'is_correct': true},
          {'text': 'Turn on the headlights in response', 'is_correct': false},
        ],
        'explanation':
            'When meeting an oncoming vehicle with high beams, look to the right of the road.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'To increase visibility at night, you should:',
        'answers': [
          {
            'text': 'Use high beams when there are no oncoming vehicles',
            'is_correct': true,
          },
          {'text': 'Turn off the headlights', 'is_correct': false},
          {'text': 'Drive close to the vehicle in front', 'is_correct': false},
        ],
        'explanation':
            'To increase visibility at night, use high beams when there are no oncoming vehicles.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When it is foggy at night, you should:',
        'answers': [
          {'text': 'Use high beams', 'is_correct': false},
          {'text': 'Turn on fog lights or low beams', 'is_correct': true},
          {'text': 'Use hazard lights (flashing)', 'is_correct': false},
        ],
        'explanation':
            'When it is foggy at night, turn on fog lights or low beams.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When driving at night in an area without lights road:',
        'answers': [
          {'text': 'Slow down and watch carefully', 'is_correct': true},
          {'text': 'Drive normally', 'is_correct': false},
          {'text': 'Accelerate to avoid danger', 'is_correct': false},
        ],
        'explanation':
            'When driving at night in an area without lights, slow down and watch carefully.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'If your headlights fail at night, you:',
        'answers': [
          {
            'text': 'Turn on the hazard lights and continue driving',
            'is_correct': false,
          },
          {'text': 'Stop in a safe place', 'is_correct': true},
          {'text': 'Turn onto a major road', 'is_correct': false},
        ],
        'explanation':
            'If your headlights fail at night, stop in a safe place.',
        'difficultyLevel': 3,
      },

      // Set 3: Driving on steep hills and difficult terrain (6 questions)
      {
        'questionText': 'When going down a long slope, you should:',
        'answers': [
          {'text': 'Brake continuously', 'is_correct': false},
          {'text': 'Shift to a low gear and brake gently', 'is_correct': true},
          {'text': 'Accelerate to control', 'is_correct': false},
        ],
        'explanation':
            'When going down a long slope, shift to a low gear and brake gently.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When going up a steep slope, you should:',
        'answers': [
          {
            'text': 'Keep a low gear and accelerate steadily',
            'is_correct': true,
          },
          {'text': 'Stop in the middle of the slope', 'is_correct': false},
          {'text': 'Turn on the hazard lights', 'is_correct': false},
        ],
        'explanation':
            'When going up a steep slope, keep a low gear and accelerate steadily.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When parking uphill with a curb:',
        'answers': [
          {'text': 'Turn the wheels away from the curb', 'is_correct': true},
          {'text': 'Turn to the curb', 'is_correct': false},
          {'text': 'Keep straight wheels', 'is_correct': false},
        ],
        'explanation':
            'When parking uphill with a curb, turn the wheels away from the curb.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When parking downhill, the wheels must:',
        'answers': [
          {'text': 'Turn to the curb', 'is_correct': true},
          {'text': 'Turn out', 'is_correct': false},
          {'text': 'Keep straight', 'is_correct': false},
        ],
        'explanation':
            'When parking downhill, the wheels must turn to the curb.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'On a narrow slope, which vehicle must yield?',
        'answers': [
          {'text': 'Downhill vehicle', 'is_correct': true},
          {'text': 'Uphill vehicle', 'is_correct': false},
          {'text': 'Larger vehicle', 'is_correct': false},
        ],
        'explanation': 'On a narrow slope, the downhill vehicle must yield.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When braking a lot on a hill, the risk is:',
        'answers': [
          {'text': 'Running out of gas', 'is_correct': false},
          {'text': 'Losing brakes due to overheating', 'is_correct': true},
          {'text': 'Flipping the vehicle', 'is_correct': false},
        ],
        'explanation':
            'When braking a lot on a hill, the risk is losing brakes due to overheating.',
        'difficultyLevel': 3,
      },

      // Set 4: Driving on country roads, small roads (6 questions)
      {
        'questionText':
            'When driving on country roads without lane markings, you should:',
        'answers': [
          {'text': 'Drive in the middle of the road', 'is_correct': false},
          {'text': 'Keep close to the right', 'is_correct': true},
          {'text': 'Go by feel', 'is_correct': false},
        ],
        'explanation':
            'When driving on country roads without lane markings, keep close to the right.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'If you encounter a sharp turn without a sign, you:',
        'answers': [
          {'text': 'Slow down before entering', 'is_correct': true},
          {'text': 'Speed up quickly', 'is_correct': false},
          {'text': 'Honk to warn', 'is_correct': false},
        ],
        'explanation':
            'If you encounter a sharp turn without a sign, slow down before entering.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When you see an animal crossing the road, you should:',
        'answers': [
          {'text': 'Honk', 'is_correct': false},
          {'text': 'Stop or slow down', 'is_correct': true},
          {'text': 'Overtake quickly', 'is_correct': false},
        ],
        'explanation':
            'When you see an animal crossing the road, stop or slow down.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When visibility is limited by trees, you:',
        'answers': [
          {'text': 'Turn on the headlights', 'is_correct': false},
          {'text': 'Slow down and stay close to the right', 'is_correct': true},
          {'text': 'Speed up to avoid danger', 'is_correct': false},
        ],
        'explanation':
            'When visibility is limited by trees, slow down and stay close to the right.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When there is almost no oncoming traffic:',
        'answers': [
          {'text': 'Keep to the right', 'is_correct': true},
          {'text': 'Drive in the middle road', 'is_correct': false},
          {'text': 'Move freely', 'is_correct': false},
        ],
        'explanation':
            'When there is almost no oncoming traffic, keep to the right.',
        'difficultyLevel': 3,
      },
      {
        'questionText':
            'If there is no STOP line but you come to a three-way intersection, you:',
        'answers': [
          {
            'text': 'Observe carefully and yield if necessary',
            'is_correct': true,
          },
          {'text': 'Continue driving', 'is_correct': false},
          {'text': 'Wait for the light', 'is_correct': false},
        ],
        'explanation':
            'If there is no STOP line but you come to a three-way intersection, observe carefully and yield if necessary.',
        'difficultyLevel': 3,
      },

      // Set 5: Driving in a crowded city (7 questions)
      {
        'questionText': 'When driving during rush hour, you should:',
        'answers': [
          {'text': 'Speed up to avoid traffic jams', 'is_correct': false},
          {'text': 'Keep your distance and be patient', 'is_correct': true},
          {'text': 'Drive close to the car in front', 'is_correct': false},
        ],
        'explanation':
            'When driving during rush hour, keep your distance and be patient.',
        'difficultyLevel': 3,
      },
      {
        'questionText':
            'When another car suddenly stops in the middle of the road, you:',
        'answers': [
          {'text': 'Keep your distance to react', 'is_correct': true},
          {'text': 'Honk', 'is_correct': false},
          {'text': 'Pass immediately', 'is_correct': false},
        ],
        'explanation':
            'When another car suddenly stops in the middle of the road, keep your distance to react.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When passing a crowded intersection, you should:',
        'answers': [
          {'text': 'Observe pedestrians', 'is_correct': true},
          {'text': 'Prioritize your own car', 'is_correct': false},
          {'text': 'Go fast', 'is_correct': false},
        ],
        'explanation':
            'When passing a crowded intersection, observe pedestrians.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'Driving in a narrow two-way street, you:',
        'answers': [
          {'text': 'Back up if you need to yield', 'is_correct': true},
          {'text': 'Try to dodge', 'is_correct': false},
          {'text': 'Turn sharply', 'is_correct': false},
        ],
        'explanation':
            'When driving in a narrow two-way street, back up if you need to yield.',
        'difficultyLevel': 3,
      },
      {
        'questionText':
            'When you see a truck stopping to deliver goods, you should:',
        'answers': [
          {'text': 'Stop behind', 'is_correct': false},
          {
            'text': 'Overtake when there are no people or obstacles',
            'is_correct': true,
          },
          {'text': 'Honk the horn', 'is_correct': false},
        ],
        'explanation':
            'When you see a truck stopping to deliver goods, overtake when there are no people or obstacles.',
        'difficultyLevel': 3,
      },
      {
        'questionText':
            'When someone suddenly steps out from between parked cars:',
        'answers': [
          {'text': 'Honk the horn', 'is_correct': false},
          {'text': 'Make an emergency stop if necessary', 'is_correct': true},
          {'text': 'Continue driving', 'is_correct': false},
        ],
        'explanation':
            'When someone suddenly steps out from between parked cars, make an emergency stop if necessary.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'Bicycles and motorbikes traveling in the city should:',
        'answers': [
          {
            'text': 'Observe and yield according to the law',
            'is_correct': true,
          },
          {'text': 'Overtake closely', 'is_correct': false},
          {'text': 'Ignore', 'is_correct': false},
        ],
        'explanation':
            'Bicycles and motorbikes traveling in the city should observe and yield according to the law.',
        'difficultyLevel': 3,
      },

      // Set 6: Large vehicles - SUVs, trucks, trailers (7 questions)
      {
        'questionText': 'Where do trucks have large blind spots?',
        'answers': [
          {'text': 'In front and behind the vehicle', 'is_correct': true},
          {'text': 'Only behind', 'is_correct': false},
          {'text': 'None', 'is_correct': false},
        ],
        'explanation':
            'Trucks have large blind spots in front and behind the vehicle.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'Which side should you not overtake a truck on?',
        'answers': [
          {'text': 'Right', 'is_correct': true},
          {'text': 'Left', 'is_correct': false},
          {'text': 'Middle', 'is_correct': false},
        ],
        'explanation': 'You should not overtake a truck on the right side.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When passing a trailer, you should:',
        'answers': [
          {
            'text': 'Pass quickly and not drive parallel for too long',
            'is_correct': true,
          },
          {'text': 'Pass slowly', 'is_correct': false},
          {'text': 'Pass when entering a curve', 'is_correct': false},
        ],
        'explanation':
            'When passing a trailer, pass quickly and not drive parallel for too long.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'Trucks need more space when turning:',
        'answers': [
          {'text': 'Left', 'is_correct': false},
          {'text': 'Right', 'is_correct': true},
          {'text': 'U-turn', 'is_correct': false},
        ],
        'explanation': 'Trucks need more space when turning right.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'The stopping distance of a truck is longer because:',
        'answers': [
          {'text': 'Larger weight', 'is_correct': true},
          {'text': 'Accelerate faster', 'is_correct': false},
          {'text': 'Larger wheels', 'is_correct': false},
        ],
        'explanation':
            'The stopping distance of a truck is longer because of larger weight.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When a truck enters a lane, you should:',
        'answers': [
          {'text': 'Yield if safe', 'is_correct': true},
          {'text': 'Try to stay in the lane', 'is_correct': false},
          {'text': 'Accelerate', 'is_correct': false},
        ],
        'explanation': 'When a truck enters a lane, yield if safe.',
        'difficultyLevel': 3,
      },
      {
        'questionText':
            'When driving an SUV with a high center of gravity, you should:',
        'answers': [
          {
            'text': 'Slow down when turning to avoid tipping',
            'is_correct': true,
          },
          {'text': 'Accelerate to pass', 'is_correct': false},
          {'text': 'Try to stay straight', 'is_correct': false},
        ],
        'explanation':
            'When driving an SUV with a high center of gravity, slow down when turning to avoid tipping.',
        'difficultyLevel': 3,
      },

      // Set 7: Crossing the railway tracks (6 questions)
      {
        'questionText': 'When you see a railway warning sign, you should:',
        'answers': [
          {'text': 'Observe and prepare to stop', 'is_correct': true},
          {'text': 'Speed up', 'is_correct': false},
          {'text': 'Honk the horn', 'is_correct': false},
        ],
        'explanation':
            'When you see a railway warning sign, observe and prepare to stop.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'If the barrier is lowering, you:',
        'answers': [
          {'text': 'Pass quickly', 'is_correct': false},
          {'text': 'Stop far from the barrier', 'is_correct': true},
          {'text': 'Go around the barrier', 'is_correct': false},
        ],
        'explanation': 'If the barrier is lowering, stop far from the barrier.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'You must not stop on the railway tracks because:',
        'answers': [
          {'text': 'Parking is prohibited', 'is_correct': false},
          {'text': 'The risk of collision is very high', 'is_correct': true},
          {'text': 'Obstruct traffic', 'is_correct': false},
        ],
        'explanation':
            'You must not stop on the railway tracks because the risk of collision is very high.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'If the vehicle stalls on the railway tracks:',
        'answers': [
          {'text': 'Restart', 'is_correct': false},
          {
            'text': 'Leave the vehicle and call for help immediately',
            'is_correct': true,
          },
          {'text': 'Honk the horn', 'is_correct': false},
        ],
        'explanation':
            'If the vehicle stalls on the railway tracks, leave the vehicle and call for help immediately.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When a trailer crosses the railway tracks:',
        'answers': [
          {
            'text': 'Go slowly and check for sufficient length',
            'is_correct': true,
          },
          {'text': 'Pass immediately', 'is_correct': false},
          {'text': 'Honk the horn', 'is_correct': false},
        ],
        'explanation':
            'When a trailer crosses the railway tracks, go slowly and check for sufficient length.',
        'difficultyLevel': 3,
      },
      {
        'questionText':
            'Minimum stopping distance The minimum distance before the rail is:',
        'answers': [
          {'text': '5 feet', 'is_correct': false},
          {'text': '15 feet', 'is_correct': true},
          {'text': '25 feet', 'is_correct': false},
        ],
        'explanation':
            'The minimum stopping distance before the rail is 15 feet.',
        'difficultyLevel': 3,
      },

      // Set 8: Turning, reversing and parking (6 questions)
      {
        'questionText': 'When reversing, you should:',
        'answers': [
          {'text': 'Look in the rearview mirror', 'is_correct': false},
          {'text': 'Turn around and look directly', 'is_correct': true},
          {'text': 'Use the camera', 'is_correct': false},
        ],
        'explanation': 'When reversing, turn around and look directly.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When turning at an intersection, make sure:',
        'answers': [
          {'text': 'There is no sign prohibiting U-turns', 'is_correct': true},
          {'text': 'There is a vehicle turning right', 'is_correct': false},
          {'text': 'There is a red light', 'is_correct': false},
        ],
        'explanation':
            'When turning at an intersection, make sure there is no sign prohibiting U-turns.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When parallel parking, the distance from the curb is:',
        'answers': [
          {'text': 'No more than 18 inches', 'is_correct': true},
          {'text': '1 meter', 'is_correct': false},
          {'text': '3 feet', 'is_correct': false},
        ],
        'explanation':
            'When parallel parking, the distance from the curb is no more than 18 inches.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When reversing off the curb, you should:',
        'answers': [
          {
            'text': 'Look all the way to the sides and back',
            'is_correct': true,
          },
          {'text': 'Look in the left mirror', 'is_correct': false},
          {'text': 'Press horn', 'is_correct': false},
        ],
        'explanation':
            'When reversing off the curb, look all the way to the sides and back.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When you need to turn around in a residential area:',
        'answers': [
          {
            'text': 'Look for pedestrians, vehicles, and signs',
            'is_correct': true,
          },
          {'text': 'Do it quickly', 'is_correct': false},
          {'text': 'Wait for the horn', 'is_correct': false},
        ],
        'explanation':
            'When you need to turn around in a residential area, look for pedestrians, vehicles, and signs.',
        'difficultyLevel': 3,
      },
      {
        'questionText':
            'When parking on an incline, you need to pull the handbrake and:',
        'answers': [
          {'text': 'Turn the wheel up the slope', 'is_correct': true},
          {'text': 'Put the gear down', 'is_correct': false},
          {'text': 'Turn off the engine is enough', 'is_correct': false},
        ],
        'explanation':
            'When parking on an incline, pull the handbrake and turn the wheel up the slope.',
        'difficultyLevel': 3,
      },

      // Set 9: Combining unusual situations (7 questions)
      {
        'questionText':
            'When the car in front has a problem and stops in the middle of the road:',
        'answers': [
          {'text': 'Overtake immediately', 'is_correct': false},
          {
            'text': 'Keep distance, turn on the hazard lights',
            'is_correct': true,
          },
          {'text': 'Turn quickly', 'is_correct': false},
        ],
        'explanation':
            'When the car in front has a problem and stops in the middle of the road, keep distance and turn on the hazard lights.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When the tire explodes while driving:',
        'answers': [
          {
            'text': 'Hold the steering wheel and slow down slowly',
            'is_correct': true,
          },
          {'text': 'Brake suddenly', 'is_correct': false},
          {'text': 'Turn off the engine', 'is_correct': false},
        ],
        'explanation':
            'When the tire explodes while driving, hold the steering wheel and slow down slowly.',
        'difficultyLevel': 3,
      },
      {
        'questionText':
            'When you encounter an emergency vehicle stopping in the middle of the road, you:',
        'answers': [
          {'text': 'Stop far away and observe', 'is_correct': true},
          {'text': 'Continue driving', 'is_correct': false},
          {'text': 'Overtake', 'is_correct': false},
        ],
        'explanation':
            'When you encounter an emergency vehicle stopping in the middle of the road, stop far away and observe.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When the car in front suddenly reverses, you:',
        'answers': [
          {'text': 'Honk the horn', 'is_correct': false},
          {'text': 'Stop and keep a safe distance', 'is_correct': true},
          {'text': 'Back up', 'is_correct': false},
        ],
        'explanation':
            'When the car in front suddenly reverses, stop and keep a safe distance.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'If a large animal crosses the road, you should:',
        'answers': [
          {'text': 'Honk the horn', 'is_correct': false},
          {'text': 'Slow down and stop if necessary', 'is_correct': true},
          {'text': 'Dodge', 'is_correct': false},
        ],
        'explanation':
            'If a large animal crosses the road, slow down and stop if necessary.',
        'difficultyLevel': 3,
      },
      {
        'questionText':
            'When your car skids slightly, your first reflex is to:',
        'answers': [
          {
            'text': 'Release the accelerator and hold the steering wheel',
            'is_correct': true,
          },
          {'text': 'Brake suddenly', 'is_correct': false},
          {'text': 'Turn the steering wheel', 'is_correct': false},
        ],
        'explanation':
            'When your car skids slightly, your first reflex is to release the accelerator and hold the steering wheel.',
        'difficultyLevel': 3,
      },
      {
        'questionText':
            'When you have to stop in the middle of the road due to an obstacle, you:',
        'answers': [
          {'text': 'Turn on the hazard lights', 'is_correct': true},
          {'text': 'Stop and be quiet', 'is_correct': false},
          {'text': 'Leave the car', 'is_correct': false},
        ],
        'explanation':
            'When you have to stop in the middle of the road due to an obstacle, turn on the hazard lights.',
        'difficultyLevel': 3,
      },

      // Set 10: Advanced Summary & Simulation (8 questions)
      {
        'questionText':
            'You are driving into a small alley where children are playing soccer:',
        'answers': [
          {
            'text': 'Slow down as much as possible and prepare to stop',
            'is_correct': true,
          },
          {'text': 'Honk and pass', 'is_correct': false},
          {'text': 'Accelerate to go faster', 'is_correct': false},
        ],
        'explanation':
            'When driving into a small alley where children are playing, slow down as much as possible and prepare to stop.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When passing an intersection without lights at night:',
        'answers': [
          {'text': 'Look and yield as if it were daytime', 'is_correct': true},
          {'text': 'No need to stop', 'is_correct': false},
          {'text': 'Pass', 'is_correct': false},
        ],
        'explanation':
            'When passing an intersection without lights at night, look and yield as if it were daytime.',
        'difficultyLevel': 3,
      },
      {
        'questionText':
            'Seeing a school bus that has stopped with flashing lights:',
        'answers': [
          {'text': 'Stop at least 20 feet away', 'is_correct': true},
          {'text': 'Continue if on the left', 'is_correct': false},
          {'text': 'Honk', 'is_correct': false},
        ],
        'explanation':
            'When seeing a school bus that has stopped with flashing lights, stop at least 20 feet away.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'If you encounter a large obstacle on the highway:',
        'answers': [
          {
            'text': 'Report the hazard, slow down, and find a safe lane',
            'is_correct': true,
          },
          {'text': 'Pass', 'is_correct': false},
          {'text': 'Honk', 'is_correct': false},
        ],
        'explanation':
            'If you encounter a large obstacle on the highway, report the hazard, slow down, and find a safe lane.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When your vision is completely blocked, you:',
        'answers': [
          {'text': 'Slow down and stop if necessary', 'is_correct': true},
          {'text': 'Turn right away', 'is_correct': false},
          {'text': 'Continue', 'is_correct': false},
        ],
        'explanation':
            'When your vision is completely blocked, slow down and stop if necessary.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'If a vehicle is on fire ahead:',
        'answers': [
          {'text': 'Turn quickly, call 911', 'is_correct': true},
          {'text': 'Honk', 'is_correct': false},
          {'text': 'Continue', 'is_correct': false},
        ],
        'explanation':
            'If a vehicle is on fire ahead, turn quickly and call 911.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When going down a steep slope in a parking garage:',
        'answers': [
          {'text': 'Slow down and shift into a lower gear', 'is_correct': true},
          {'text': 'Accelerate', 'is_correct': false},
          {'text': 'No change required', 'is_correct': false},
        ],
        'explanation':
            'When going down a steep slope in a parking garage, slow down and shift into a lower gear.',
        'difficultyLevel': 3,
      },
      {
        'questionText': 'When driving in a lightly flooded area:',
        'answers': [
          {'text': 'Go slowly and do not brake suddenly', 'is_correct': true},
          {'text': 'Accelerate', 'is_correct': false},
          {'text': 'Pass another vehicle', 'is_correct': false},
        ],
        'explanation':
            'When driving in a lightly flooded area, go slowly and do not brake suddenly.',
        'difficultyLevel': 3,
      },
    ];

    for (var question in questions) {
      try {
        await questionService.addQuestion(
          categoryId: 4,
          questionText: question['questionText'] as String,
          answers: question['answers'] as List<Map<String, dynamic>>,
          explanation: question['explanation'] as String,
          difficultyLevel: question['difficultyLevel'] as int,
        );
      } catch (e) {
        // Skip this question if there's an error
        continue;
      }
    }
  }

  // Unit 5: Sharing the Road
  static Future<void> _loadUnit5Questions(
    QuestionService questionService,
  ) async {
    final questions = [
      // Set 1: Pedestrians – Yield Rules (5 questions)
      {
        'questionText':
            'When a pedestrian is crossing the road at a crosswalk, you:',
        'answers': [
          {'text': 'Slow down and continue', 'is_correct': false},
          {'text': 'Stop completely to let them go', 'is_correct': true},
          {'text': 'Honk to let them go faster', 'is_correct': false},
        ],
        'explanation':
            'When a pedestrian is crossing the road at a crosswalk, stop completely to let them go.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'Pedestrians crossing the road in the wrong place (jaywalking):',
        'answers': [
          {
            'text': 'You still have to pay attention and slow down',
            'is_correct': true,
          },
          {'text': 'Don\'t care', 'is_correct': false},
          {'text': 'Honk', 'is_correct': false},
        ],
        'explanation':
            'Even when pedestrians are jaywalking, you still have to pay attention and slow down.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'Children near a school or park:',
        'answers': [
          {
            'text': 'May cross unexpectedly, need to slow down',
            'is_correct': true,
          },
          {'text': 'Keep close to the curb', 'is_correct': false},
          {'text': 'No impact', 'is_correct': false},
        ],
        'explanation':
            'Children near a school or park may cross unexpectedly, so you need to slow down.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When turning right at an intersection with a pedestrian on the right:',
        'answers': [
          {'text': 'Let them cross first', 'is_correct': true},
          {'text': 'Overtake quickly', 'is_correct': false},
          {'text': 'Honk to let them go', 'is_correct': false},
        ],
        'explanation':
            'When turning right at an intersection with a pedestrian on the right, let them cross first.',
        'difficultyLevel': 2,
      },
      {
        'questionText': '"Pedestrian Crossing" sign means:',
        'answers': [
          {
            'text': 'Area where pedestrians regularly cross',
            'is_correct': true,
          },
          {'text': 'No bicycles', 'is_correct': false},
          {'text': 'Delivery area', 'is_correct': false},
        ],
        'explanation':
            'A "Pedestrian Crossing" sign indicates an area where pedestrians regularly cross.',
        'difficultyLevel': 2,
      },

      // Set 2: Bicycles and motorbikes – Safe distance (6 questions)
      {
        'questionText':
            'When passing a bicycle, you must keep a minimum distance of:',
        'answers': [
          {'text': '1 foot', 'is_correct': false},
          {'text': '3 feet', 'is_correct': true},
          {'text': 'No distance required', 'is_correct': false},
        ],
        'explanation':
            'When passing a bicycle, you must keep a minimum distance of 3 feet.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'If you see a bicycle moving between lanes:',
        'answers': [
          {
            'text': 'Keep your distance and do not pass when it is unsafe',
            'is_correct': true,
          },
          {'text': 'Honk', 'is_correct': false},
          {'text': 'Pass closely', 'is_correct': false},
        ],
        'explanation':
            'If you see a bicycle moving between lanes, keep your distance and do not pass when it is unsafe.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When driving at night near a bicycle, you should:',
        'answers': [
          {'text': 'Turn on high beams', 'is_correct': false},
          {'text': 'Slow down and look', 'is_correct': true},
          {'text': 'Pass quickly', 'is_correct': false},
        ],
        'explanation':
            'When driving at night near a bicycle, slow down and look carefully.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'Motorcycles have the right to use the lane as:',
        'answers': [
          {'text': 'Bicycles', 'is_correct': false},
          {'text': 'Cars', 'is_correct': true},
          {'text': 'Only lane outermost', 'is_correct': false},
        ],
        'explanation': 'Motorcycles have the right to use the lane as cars.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When a bicycle turns left at an intersection, you:',
        'answers': [
          {'text': 'Yield if they signal', 'is_correct': true},
          {'text': 'Continue as normal', 'is_correct': false},
          {'text': 'Honk', 'is_correct': false},
        ],
        'explanation':
            'When a bicycle turns left at an intersection, yield if they signal.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When a motorbike in front of you brakes suddenly:',
        'answers': [
          {'text': 'Pass', 'is_correct': false},
          {
            'text': 'Keep enough distance to avoid a collision',
            'is_correct': true,
          },
          {'text': 'Turn the other way', 'is_correct': false},
        ],
        'explanation':
            'When a motorbike in front of you brakes suddenly, keep enough distance to avoid a collision.',
        'difficultyLevel': 2,
      },

      // Set 3: Buses, trucks – Driving around large vehicles (6 questions)
      {
        'questionText': 'Trucks have large blind spots in:',
        'answers': [
          {'text': 'Behind and to the sides', 'is_correct': true},
          {'text': 'Ahead only', 'is_correct': false},
          {'text': 'Left only', 'is_correct': false},
        ],
        'explanation': 'Trucks have large blind spots behind and to the sides.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'Do not pass a truck or bus in:',
        'answers': [
          {'text': 'Left', 'is_correct': false},
          {'text': 'Right', 'is_correct': true},
          {'text': 'On a bridge', 'is_correct': false},
        ],
        'explanation': 'Do not pass a truck or bus on the right side.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When a school bus stops and turns on its red light:',
        'answers': [
          {
            'text': 'Both directions must stop (if there is no median)',
            'is_correct': true,
          },
          {'text': 'Only oncoming vehicles', 'is_correct': false},
          {'text': 'Continue if no one is present', 'is_correct': false},
        ],
        'explanation':
            'When a school bus stops and turns on its red light, both directions must stop if there is no median.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'Trucks preparing to turn right usually:',
        'answers': [
          {'text': 'Cut across the left lane', 'is_correct': false},
          {
            'text': 'Need a lot of space – do not overtake on the right',
            'is_correct': true,
          },
          {'text': 'Turn very quickly', 'is_correct': false},
        ],
        'explanation':
            'Trucks preparing to turn right usually need a lot of space – do not overtake on the right.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When overtaking a bus that is stopped at a stop:',
        'answers': [
          {'text': 'Overtake from the right', 'is_correct': false},
          {'text': 'Overtake from the left when safe', 'is_correct': true},
          {'text': 'No need to signal', 'is_correct': false},
        ],
        'explanation':
            'When overtaking a bus that is stopped at a stop, overtake from the left when safe.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When a truck enters the lane, you should:',
        'answers': [
          {'text': 'Stop', 'is_correct': false},
          {'text': 'Yield if there is enough space', 'is_correct': true},
          {'text': 'Overtake immediately', 'is_correct': false},
        ],
        'explanation':
            'When a truck enters the lane, yield if there is enough space.',
        'difficultyLevel': 2,
      },

      // Set 4: Emergency Vehicles – Correct Handling (6 questions)
      {
        'questionText':
            'When encountering a fire truck or police car with sirens behind:',
        'answers': [
          {'text': 'Stop close to the right and yield', 'is_correct': true},
          {'text': 'Continue if there is no obstruction', 'is_correct': false},
          {'text': 'Overtake immediately', 'is_correct': false},
        ],
        'explanation':
            'When encountering a fire truck or police car with sirens behind, stop close to the right and yield.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'If you are at an intersection and hear the emergency siren level:',
        'answers': [
          {'text': 'Stop in place', 'is_correct': false},
          {'text': 'Complete the turn, then pull over', 'is_correct': true},
          {'text': 'Turn around', 'is_correct': false},
        ],
        'explanation':
            'If you are at an intersection and hear the emergency siren, complete the turn, then pull over.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When an emergency vehicle is traveling in a convoy (e.g. 2 ambulances):',
        'answers': [
          {'text': 'Cut across the convoy', 'is_correct': false},
          {'text': 'Yield to the entire convoy', 'is_correct': true},
          {'text': 'Yield to the leading vehicle only', 'is_correct': false},
        ],
        'explanation':
            'When an emergency vehicle is traveling in a convoy, yield to the entire convoy.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When parking on the side of the road, avoid blocking the path of a fire truck by:',
        'answers': [
          {'text': 'Park at least 15 feet from a hydrant', 'is_correct': true},
          {'text': 'Park close to the curb', 'is_correct': false},
          {'text': 'Turn on hazard lights', 'is_correct': false},
        ],
        'explanation':
            'When parking on the side of the road, avoid blocking the path of a fire truck by parking at least 15 feet from a hydrant.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'The "Emergency Vehicle Station Ahead" sign indicates:',
        'answers': [
          {'text': 'Police patrol', 'is_correct': false},
          {
            'text':
                'Emergency station – watch for vehicles entering or exiting',
            'is_correct': true,
          },
          {'text': 'Does not apply to cars', 'is_correct': false},
        ],
        'explanation':
            'The "Emergency Vehicle Station Ahead" sign indicates an emergency station – watch for vehicles entering or exiting.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When an emergency vehicle is traveling in the opposite direction, you:',
        'answers': [
          {'text': 'Stay still', 'is_correct': false},
          {
            'text': 'Slow down and pull to the right if safe',
            'is_correct': true,
          },
          {'text': 'Accelerate forward', 'is_correct': false},
        ],
        'explanation':
            'When an emergency vehicle is traveling in the opposite direction, slow down and pull to the right if safe.',
        'difficultyLevel': 2,
      },

      // Set 5: Near Schools and Residential Areas (6 questions)
      {
        'questionText':
            'When approaching a school zone with a "School Zone" sign:',
        'answers': [
          {'text': 'Slow down according to the sign', 'is_correct': true},
          {'text': 'Drive as usual', 'is_correct': false},
          {'text': 'Overtake other vehicles', 'is_correct': false},
        ],
        'explanation':
            'When approaching a school zone with a "School Zone" sign, slow down according to the sign.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When the lights are flashing at the "School Zone", you:',
        'answers': [
          {'text': 'Ignore if there are no people', 'is_correct': false},
          {'text': 'Obey the new speed limit', 'is_correct': true},
          {'text': 'Honk your horn', 'is_correct': false},
        ],
        'explanation':
            'When the lights are flashing at the "School Zone", obey the new speed limit.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When you meet a school crossing guard:',
        'answers': [
          {'text': 'Follow their instructions', 'is_correct': true},
          {'text': 'Overtake when clear', 'is_correct': false},
          {'text': 'Flash your lights to let them out', 'is_correct': false},
        ],
        'explanation':
            'When you meet a school crossing guard, follow their instructions.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'Children may run out from behind a parked car unexpectedly:',
        'answers': [
          {'text': 'Slow down and watch constantly', 'is_correct': true},
          {'text': 'Honk your horn', 'is_correct': false},
          {'text': 'Don\'t pay attention', 'is_correct': false},
        ],
        'explanation':
            'Children may run out from behind a parked car unexpectedly, so slow down and watch constantly.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When a school bus has its flashing yellow lights on:',
        'answers': [
          {'text': 'Prepare to stop', 'is_correct': true},
          {'text': 'Overtake quickly', 'is_correct': false},
          {'text': 'Accelerate to go ahead', 'is_correct': false},
        ],
        'explanation':
            'When a school bus has its flashing yellow lights on, prepare to stop.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'A school bus stops in a two-way residential area:',
        'answers': [
          {'text': 'Both directions must stop', 'is_correct': true},
          {'text': 'Only in the opposite direction', 'is_correct': false},
          {
            'text': 'No need to stop if you don\'t see students',
            'is_correct': false,
          },
        ],
        'explanation':
            'A school bus stops in a two-way residential area, both directions must stop.',
        'difficultyLevel': 2,
      },

      // Set 6: Polite behavior and yielding (6 questions)
      {
        'questionText':
            'When you see another vehicle trying to merge into the lane, you:',
        'answers': [
          {'text': 'Speed up', 'is_correct': false},
          {'text': 'Yield if there is space', 'is_correct': true},
          {'text': 'Dodge', 'is_correct': false},
        ],
        'explanation':
            'When you see another vehicle trying to merge into the lane, yield if there is space.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When you see a slow-moving vehicle in front, you should:',
        'answers': [
          {'text': 'Overtake closely', 'is_correct': false},
          {'text': 'Observe and overtake only when safe', 'is_correct': true},
          {'text': 'Honk', 'is_correct': false},
        ],
        'explanation':
            'When you see a slow-moving vehicle in front, observe and overtake only when safe.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When another vehicle gives way for you to turn:',
        'answers': [
          {'text': 'Turn quickly without signaling', 'is_correct': false},
          {
            'text': 'Say thank you if possible and turn safely',
            'is_correct': true,
          },
          {'text': 'Stop', 'is_correct': false},
        ],
        'explanation':
            'When another vehicle gives way for you to turn, say thank you if possible and turn safely.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When you see an elderly person cross the road slowly:',
        'answers': [
          {'text': 'Yield, wait for them to cross', 'is_correct': true},
          {'text': 'Honk to urge', 'is_correct': false},
          {'text': 'Overtake from behind', 'is_correct': false},
        ],
        'explanation':
            'When you see an elderly person cross the road slowly, yield and wait for them to cross.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When entering a parking lot, you should:',
        'answers': [
          {'text': 'Observe and yield to pedestrians', 'is_correct': true},
          {'text': 'Stay in your lane', 'is_correct': false},
          {'text': 'Speed up to make room', 'is_correct': false},
        ],
        'explanation':
            'When entering a parking lot, observe and yield to pedestrians.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When you see an ambulance parked on the side of the road assisting an injured person:',
        'answers': [
          {'text': 'Slow down and keep your distance', 'is_correct': true},
          {'text': 'Honk', 'is_correct': false},
          {'text': 'Drive close to see clearly', 'is_correct': false},
        ],
        'explanation':
            'When you see an ambulance parked on the side of the road assisting an injured person, slow down and keep your distance.',
        'difficultyLevel': 2,
      },

      // Set 7: Advanced synthesis & simulation (6 questions)
      {
        'questionText':
            'Encountering a person in a wheelchair preparing to cross the road:',
        'answers': [
          {'text': 'Stop and yield', 'is_correct': true},
          {'text': 'Overtake if they are slow', 'is_correct': false},
          {'text': 'Honk to warn', 'is_correct': false},
        ],
        'explanation':
            'When encountering a person in a wheelchair preparing to cross the road, stop and yield.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'If the pedestrian does not cross the road correctly:',
        'answers': [
          {
            'text': 'Still slow down and yield if necessary',
            'is_correct': true,
          },
          {'text': 'Skip pass', 'is_correct': false},
          {'text': 'Honk', 'is_correct': false},
        ],
        'explanation':
            'If the pedestrian does not cross the road correctly, still slow down and yield if necessary.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When meeting a group of students on bicycles:',
        'answers': [
          {'text': 'Keep a greater distance than usual', 'is_correct': true},
          {'text': 'Overtake closely', 'is_correct': false},
          {'text': 'Ride parallel', 'is_correct': false},
        ],
        'explanation':
            'When meeting a group of students on bicycles, keep a greater distance than usual.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When traffic is heavy and the pedestrian is in the middle of the lane:',
        'answers': [
          {'text': 'Stop and let them pass', 'is_correct': true},
          {'text': 'Honk', 'is_correct': false},
          {'text': 'Swerve to the left', 'is_correct': false},
        ],
        'explanation':
            'When traffic is heavy and the pedestrian is in the middle of the lane, stop and let them pass.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When meeting a blind person holding a white cane or a guide dog:',
        'answers': [
          {'text': 'Always stop and yield completely', 'is_correct': true},
          {'text': 'Wait for them to cross partially', 'is_correct': false},
          {'text': 'Overtake quickly', 'is_correct': false},
        ],
        'explanation':
            'When meeting a blind person holding a white cane or a guide dog, always stop and yield completely.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'When there are pedestrians, bicycles and cars at an intersection:',
        'answers': [
          {
            'text':
                'Observe carefully and yield according to the right-of-way law',
            'is_correct': true,
          },
          {'text': 'Try to go first', 'is_correct': false},
          {'text': 'Honk continuously', 'is_correct': false},
        ],
        'explanation':
            'When there are pedestrians, bicycles and cars at an intersection, observe carefully and yield according to the right-of-way law.',
        'difficultyLevel': 2,
      },
    ];

    for (var question in questions) {
      try {
        await questionService.addQuestion(
          categoryId: 5,
          questionText: question['questionText'] as String,
          answers: question['answers'] as List<Map<String, dynamic>>,
          explanation: question['explanation'] as String,
          difficultyLevel: question['difficultyLevel'] as int,
        );
      } catch (e) {
        // Skip this question if there's an error
        continue;
      }
    }
  }

  // Unit 6: Alcohol and Drugs
  static Future<void> _loadUnit6Questions(
    QuestionService questionService,
  ) async {
    final questions = [
      // Set 1: Basics – Alcohol Concentrations and Effects (5 questions)
      {
        'questionText':
            'The maximum legal alcohol concentration (BAC) for adults to drive is:',
        'answers': [
          {'text': '0.02%', 'is_correct': false},
          {'text': '0.05%', 'is_correct': false},
          {'text': '0.08%', 'is_correct': true},
        ],
        'explanation':
            'The maximum legal alcohol concentration (BAC) for adults to drive is 0.08%.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'If your BAC is 0.08%, your driving ability:',
        'answers': [
          {'text': 'Is still normal', 'is_correct': false},
          {'text': 'Is significantly impaired', 'is_correct': true},
          {'text': 'Increases reflexes', 'is_correct': false},
        ],
        'explanation':
            'If your BAC is 0.08%, your driving ability is significantly impaired.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'Alcohol affects driving skills by:',
        'answers': [
          {
            'text': 'Slowing reflexes and reducing concentration',
            'is_correct': true,
          },
          {'text': 'Increasing alertness', 'is_correct': false},
          {
            'text': 'Has no effect if only 1 drink is consumed',
            'is_correct': false,
          },
        ],
        'explanation':
            'Alcohol affects driving skills by slowing reflexes and reducing concentration.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'The types of drinks that can contain alcohol are similar to:',
        'answers': [
          {
            'text': '1 glass of wine, 1 can of beer, 1 shot',
            'is_correct': true,
          },
          {'text': 'Beer is weaker than wine', 'is_correct': false},
          {'text': 'Only wine has alcohol', 'is_correct': false},
        ],
        'explanation':
            'The types of drinks that can contain alcohol are similar to 1 glass of wine, 1 can of beer, 1 shot.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'The only way to sober up is to:',
        'answers': [
          {'text': 'Drink coffee', 'is_correct': false},
          {'text': 'Sleep or wait', 'is_correct': true},
          {'text': 'Take a cold shower', 'is_correct': false},
        ],
        'explanation': 'The only way to sober up is to sleep or wait.',
        'difficultyLevel': 2,
      },

      // Set 2: Drugs and effects similar to alcohol (6 questions)
      {
        'questionText': 'Taking over-the-counter cold/cold medicines can:',
        'answers': [
          {
            'text': 'Cause drowsiness and reduce driving ability',
            'is_correct': true,
          },
          {'text': 'Make you alert', 'is_correct': false},
          {'text': 'Have no effect', 'is_correct': false},
        ],
        'explanation':
            'Taking over-the-counter cold/cold medicines can cause drowsiness and reduce driving ability.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'Taking sedatives or antihistamines can cause:',
        'answers': [
          {'text': 'Increase concentration', 'is_correct': false},
          {'text': 'Drowsiness, slow reactions', 'is_correct': true},
          {'text': 'Have no effect', 'is_correct': false},
        ],
        'explanation':
            'Taking sedatives or antihistamines can cause drowsiness and slow reactions.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'Driving after using marijuana:',
        'answers': [
          {'text': 'Not penalized', 'is_correct': false},
          {
            'text': 'Considered a violation if it affects driving ability',
            'is_correct': true,
          },
          {'text': 'Completely legal', 'is_correct': false},
        ],
        'explanation':
            'Driving after using marijuana is considered a violation if it affects driving ability.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'Prescription drugs single-agent drugs such as opioids or strong painkillers:',
        'answers': [
          {
            'text': 'May cause dizziness, loss of alertness',
            'is_correct': true,
          },
          {'text': 'Makes you more alert', 'is_correct': false},
          {'text': 'Increases reflexes', 'is_correct': false},
        ],
        'explanation':
            'Prescription drugs such as opioids or strong painkillers may cause dizziness and loss of alertness.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'What should you do before driving if you are taking medication?',
        'answers': [
          {'text': 'Don\'t worry', 'is_correct': false},
          {'text': 'Read the label and ask your doctor', 'is_correct': true},
          {'text': 'Test drive to check', 'is_correct': false},
        ],
        'explanation':
            'Before driving if you are taking medication, read the label and ask your doctor.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'Signs of a driver being affected by drugs/alcohol:',
        'answers': [
          {
            'text': 'Drifting off lane, slow reactions, lack of control',
            'is_correct': true,
          },
          {'text': 'Driving at the right speed', 'is_correct': false},
          {'text': 'Honking a lot', 'is_correct': false},
        ],
        'explanation':
            'Signs of a driver being affected by drugs/alcohol include drifting off lane, slow reactions, and lack of control.',
        'difficultyLevel': 2,
      },

      // Set 3: Laws and legal consequences (7 questions)
      {
        'questionText':
            'When caught driving with a BAC ≥ 0.08%, the first consequence is:',
        'answers': [
          {'text': 'Warning', 'is_correct': false},
          {'text': 'License suspension and fine', 'is_correct': true},
          {'text': 'Reminded', 'is_correct': false},
        ],
        'explanation':
            'When caught driving with a BAC ≥ 0.08%, the first consequence is license suspension and fine.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'If you refuse to take a breathalyzer test, you will:',
        'answers': [
          {'text': 'Not be punished', 'is_correct': false},
          {
            'text': 'Have your license revoked under the "Implied Consent" law',
            'is_correct': true,
          },
          {'text': 'Permanently banned', 'is_correct': false},
        ],
        'explanation':
            'If you refuse to take a breathalyzer test, you will have your license revoked under the "Implied Consent" law.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'DUI stands for:',
        'answers': [
          {'text': 'Driving Under Influence', 'is_correct': true},
          {'text': 'Drive Until Impaired', 'is_correct': false},
          {'text': 'Drug User Index', 'is_correct': false},
        ],
        'explanation': 'DUI stands for Driving Under Influence.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'DUI can apply to:',
        'answers': [
          {'text': 'Alcohol only', 'is_correct': false},
          {
            'text': 'Alcohol and drugs (including legal drugs)',
            'is_correct': true,
          },
          {'text': 'Accident only', 'is_correct': false},
        ],
        'explanation':
            'DUI can apply to alcohol and drugs (including legal drugs).',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'A person under 21 with a BAC ≥ 0.01% will be:',
        'answers': [
          {'text': 'No consequences if below 0.08%', 'is_correct': false},
          {
            'text': 'Prosecuted under the "Zero Tolerance" policy',
            'is_correct': true,
          },
          {'text': 'Warning only', 'is_correct': false},
        ],
        'explanation':
            'A person under 21 with a BAC ≥ 0.01% will be prosecuted under the "Zero Tolerance" policy.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'DUI accidents often result in:',
        'answers': [
          {'text': 'Minor', 'is_correct': false},
          {'text': 'Very serious, high fatality', 'is_correct': true},
          {'text': 'No impact', 'is_correct': false},
        ],
        'explanation':
            'DUI accidents often result in very serious injuries and high fatality.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'In addition to fines and license revocation, DUI can also result in:',
        'answers': [
          {'text': 'Arrest, community service', 'is_correct': true},
          {'text': 'Driving ban pedal', 'is_correct': false},
          {'text': 'Lower the exam score', 'is_correct': false},
        ],
        'explanation':
            'In addition to fines and license revocation, DUI can also result in arrest and community service.',
        'difficultyLevel': 2,
      },

      // Set 4: Simulation scenarios – Behavioral judgment (8 questions)
      {
        'questionText': 'A person who just left the bar, staggered to the car:',
        'answers': [
          {'text': 'Not a concern', 'is_correct': false},
          {
            'text':
                'Signs of intoxication, need to report to the police or stop',
            'is_correct': true,
          },
          {'text': 'Let it go', 'is_correct': false},
        ],
        'explanation':
            'A person who just left the bar and staggered to the car shows signs of intoxication and should be reported to the police or stopped.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'You see your friend drinking 3 cans of beer and trying to drive:',
        'answers': [
          {'text': 'Give them the keys and call a taxi', 'is_correct': true},
          {'text': 'Believe they are okay', 'is_correct': false},
          {'text': 'Encourage to drive slowly', 'is_correct': false},
        ],
        'explanation':
            'If you see your friend drinking 3 cans of beer and trying to drive, take their keys and call a taxi.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'After a light party, you feel "okay":',
        'answers': [
          {
            'text': 'Let someone else drive or wait to sober up',
            'is_correct': true,
          },
          {'text': 'Drive because there is no police', 'is_correct': false},
          {'text': 'Drink coffee and drive', 'is_correct': false},
        ],
        'explanation':
            'After a light party, even if you feel "okay", let someone else drive or wait to sober up.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When asked by the police to take a breathalyzer test:',
        'answers': [
          {'text': 'Refusal is a personal right', 'is_correct': false},
          {'text': 'Must comply with the law', 'is_correct': true},
          {'text': 'Avoid', 'is_correct': false},
        ],
        'explanation':
            'When asked by the police to take a breathalyzer test, you must comply with the law.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'A driver weaving in and out of traffic at night:',
        'answers': [
          {'text': 'Try to pass', 'is_correct': false},
          {'text': 'Keep a safe distance and call 911', 'is_correct': true},
          {'text': 'Honk', 'is_correct': false},
        ],
        'explanation':
            'If you see a driver weaving in and out of traffic at night, keep a safe distance and call 911.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'When feeling tired like drunk:',
        'answers': [
          {'text': 'Stop for a break or change drivers', 'is_correct': true},
          {'text': 'Turn up the music', 'is_correct': false},
          {'text': 'Drive fast to finish', 'is_correct': false},
        ],
        'explanation':
            'When feeling tired like drunk, stop for a break or change drivers.',
        'difficultyLevel': 2,
      },
      {
        'questionText':
            'Driving after taking cough medicine containing alcohol is:',
        'answers': [
          {'text': 'OK if little', 'is_correct': false},
          {'text': 'Can be a violation if not sober', 'is_correct': true},
          {'text': 'Completely legal', 'is_correct': false},
        ],
        'explanation':
            'Driving after taking cough medicine containing alcohol can be a violation if you are not sober.',
        'difficultyLevel': 2,
      },
      {
        'questionText': 'You are a passenger and the driver is drunk:',
        'answers': [
          {
            'text': 'Convince him to stop driving and change drivers',
            'is_correct': true,
          },
          {'text': 'Ignore him', 'is_correct': false},
          {'text': 'Take a video', 'is_correct': false},
        ],
        'explanation':
            'If you are a passenger and the driver is drunk, convince him to stop driving and change drivers.',
        'difficultyLevel': 2,
      },
    ];

    for (var question in questions) {
      try {
        await questionService.addQuestion(
          categoryId: 6,
          questionText: question['questionText'] as String,
          answers: question['answers'] as List<Map<String, dynamic>>,
          explanation: question['explanation'] as String,
          difficultyLevel: question['difficultyLevel'] as int,
        );
      } catch (e) {
        // Skip this question if there's an error
        continue;
      }
    }
  }

  // Load từ JSON file
  static Future<void> loadFromJsonFile(String filePath) async {
    try {
      // TODO: Implement loading from JSON file
      // final jsonString = await File(filePath).readAsString();
      // final questionsData = jsonDecode(jsonString) as List<dynamic>;
      // await _questionService.importQuestionsFromJson(questionsData);
    } catch (e) {
      // Error loading from JSON file
    }
  }

  // Export to JSON file
  static Future<void> exportToJsonFile(String filePath) async {
    try {
      final questions = await _questionService.exportQuestionsToJson();
      // final jsonString = jsonEncode(questions);
      // await File(filePath).writeAsString(jsonString);
    } catch (e) {
      // Error exporting to JSON file
    }
  }
}
