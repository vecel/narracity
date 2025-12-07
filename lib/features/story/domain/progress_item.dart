sealed class ProgressItem {}

class TextProgressItem extends ProgressItem {
  TextProgressItem({required this.text});

  final String text;
}

class LogProgressItem extends ProgressItem {
  LogProgressItem({required this.text});

  final String text;
}

class ActionProgressItem extends ProgressItem {
  ActionProgressItem({required this.onPressed});

  final void Function() onPressed;
}

class ChoiceProgressItem extends ProgressItem {
  ChoiceProgressItem({required this.labelA, required this.labelB, required this.onChoiceA, required this.onChoiceB});

  final String labelA;
  final String labelB;
  final void Function() onChoiceA;
  final void Function() onChoiceB;
}