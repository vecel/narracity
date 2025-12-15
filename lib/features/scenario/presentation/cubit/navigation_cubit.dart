import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit(): super(0);

  void selectPage(int index) {
    emit(index);
  }
}