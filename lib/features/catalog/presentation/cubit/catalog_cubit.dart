import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/catalog/presentation/cubit/catalog_state.dart';

// TODO: Add unit tests

class CatalogCubit extends Cubit<CatalogState> {
  CatalogCubit({required ScenariosRepository scenariosRepository}): 
    _repository = scenariosRepository, 
    super(CatalogLoading());
  
  final ScenariosRepository _repository;

  void load() async {
    try {
      final data = await _repository.getScenarios();
      emit(CatalogLoaded(data));

    } on FirebaseException catch (e) {
      if (e.code == 'unavailable' || e.code == 'network-request-failed') {
        emit(CatalogError('No internet connection. Please try again.', isConnectionError: true));
        return;
      }
      emit(CatalogError('Server error: ${e.message}'));
    } catch (e) {
      emit(CatalogError('Something went wrong. Please try again.'));
    }
  }

}