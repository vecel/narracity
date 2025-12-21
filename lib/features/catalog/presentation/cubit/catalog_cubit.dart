import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/catalog/presentation/cubit/catalog_state.dart';

class CatalogCubit extends Cubit<CatalogState> {
  CatalogCubit(this.repository): super(CatalogLoading());
  
  final ScenariosRepository repository;

  void load() async {
    final data = repository.scenarios;
    await Future.delayed(Duration(seconds: 2));
    emit(CatalogLoaded(data));
  }

}