class QuizData {
  final String title;
  final List<String> options;
  final int correctAnswer;
  final List<String> explanations;

  QuizData({
    required this.title,
    required this.options,
    required this.correctAnswer,
    required this.explanations,
  });
}

class QuizRepository {
  static Map<String, List<QuizData>> getQuizMap() {
    return {
      '1': [
        QuizData(
          title: "‘묘골마을’의 유래가 아닌 것은 무엇일까요?",
          options: [
            '묘(妙)골: 용이 누워있는 듯한 마을의 풍수지리가 묘하다',
            '묘(妙)골: 박비(박일산) 이야기 등 놀라운 이야기가 많다',
            '묘(卯)골: 예로부터 마을의 집집마다 토끼를 길렀다',
            '묘(廟)골: 사육신의 제를 올리는 사당이 있다',
          ],
          correctAnswer: 3,
          explanations: [
            '묘골 마을의 형태는 \n 용이 또아리를 튼 형상입니다.',
            '묘골 마을은 그 유래에 \n 얽힌 이야기가 신비합니다.',
            '', // 정답 번호이므로 비워둠
            '묘골 마을에는 사육신의 제를 \n 올리는 육신사가 있습니다.',
          ],
        ),
      ],
      '2': [
        QuizData(
          title: '조선시대 문관의 관복에 그려진 동물은?',
          options: ['호랑이', '봉황', '흰꿩', '거북이'],
          correctAnswer: 3,
          explanations: [
            '박팽년의 영정 속 \n 흉배를 다시 살펴보세요',
            '이 동물은 밤이면 \n 나무 위에 앉기도 하고, \n 날개 소리와 울음 소리가 \n 대단히 크답니다.',
            '',
            '예로부터 흰 꿩은 \n 선비의 의로운 기개를 \n 상징하는 동물입니다.',
          ],
        ),
      ],
      '3': [
        QuizData(
          title: '박팽년 선생의 마음을 의미하지 않는 것은?',
          options: ['일편단심(한 조각 붉은 마음)', '변함없는 검은 까마귀', '밤에도 밝게 빛나는 야광명월', '눈비 맞아 하얗게 보이는 까마귀'],
          correctAnswer: 3,
          explanations: [
            '박팽년 선생은 \n 아무리 어려운 상황에서라도 \n 지조를 지키려고 했습니다.',
            '눈비 맞은 까마귀는 \n 본래 검은색을 바꾸어 \n 하얗게 보이고 있네요.',
            '',
            '박팽년 선생은 \n 충절을 지키기 위해 \n 목숨까지도 바쳤습니다.',
          ],
        ),
      ],
      '4': [
        QuizData(
          title: "다음 중 ‘태고정’과 관련이 없는 사람은?",
          options: [
            '박팽년 선생의 절친, 안평대군',
            '당나라 시인, 두보',
            '조선 최고의 명필가, 한석봉',
            '임진왜란 때의 도끼 자국과 방화 흔적을 시에 담은 윤두수',
          ],
          correctAnswer: 2,
          explanations: [
            '일시루 편액은 세조의 동생, \n 안평대군이 썼다고 전합니다.',
            '',
            '태고정 편액은 \n 조선 최고의 명필가, \n 석봉이 썼다고 전합니다.',
            '태고정은 왜란 때 기적적으로 \n 화를 피했다는 \n 전설이 전해집니다.',
          ],
        ),
      ],
      '5': [
        QuizData(
          title: '560년, 박팽년 선생의 가문을 이은 \n 박일산(壹珊/一珊) 선생. 이름의 뜻은?',
          options: ['변함없는 하나의 큰산', '오래도록 밝게 빛나는 태양', '유일하게 살아남은 귀한 혈육', '하나씩 피어나는 야생화'],
          correctAnswer: 3,
          explanations: [
            '壹(오직, 하나 일) 오직 \n 하나뿐인 것을 뜻합니다.',
            '珊(산호 산)은 매우 \n 귀한 겂을 뜻합니다.',
            '',
            '박일산 선생은 박팽년 선생의 \n 유일한 손자입니다.',
          ],
        ),
      ],
      '6': [
        QuizData(
          title: '박계창의 꿈에 나타난 다섯 선비가 아닌 인물은?',
          options: ['성삼문', '하위지', '김시습', '유응부'],
          correctAnswer: 3,
          explanations: [
            '성삼문은 사육신 중 \n 한 명입니다.',
            '하위지는 사육신 중 \n 한 명입니다.',
            '',
            '유응부는 사육신 중 \n 한 명입니다.',
          ],
        ),
      ],
    };
  }
}
