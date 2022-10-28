import 'question.dart';

class QuizeBrain {
  int _questionNumber = 0;
  List<Question> _questionBank = [
    Question(
        'In the animation film “Finding Nemo,” the main protagonist is a pufferfish.',
        false),
    Question('Is Mount Kilimanjaro the world’s tallest peak?', false),
    Question('Spaghetto is the singular form of the word spaghetti.', true),
    Question(
        'Pinocchio was Walt Disney’s first animated feature film in full color. ',
        false),
    Question('Venezuela is home to the world’s highest waterfall.', true),
    Question('Coffee is a berry-based beverage. ', true),
    Question('The capital of Australia is Sydney. ', false),
    Question('The longest river in the world is the Amazon River. ', false),
    Question(
        'Polar bears can only live in the Arctic region, not in the Antarctic. ',
        true),
    Question(
        'The mosquito has a record for killing more people than any other species in written history.',
        true),
    Question(
        'When the two numbers on opposite sides of the dice are added together, the result is always 7. ',
        true),
  ];

  void getNextNumber() {
    if (_questionNumber < _questionBank.length - 1) {
      _questionNumber++;
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNumber].questionText;
  }

  bool getCorrectAnswer() {
    return _questionBank[_questionNumber].questionAnswer;
  }
}
