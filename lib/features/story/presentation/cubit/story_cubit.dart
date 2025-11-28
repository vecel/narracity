import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narracity/features/story/presentation/cubit/story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  
  StoryCubit(): super(StoryInitial());

}