import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narracity/features/catalog/data/scenarios_storage.dart';
import 'package:narracity/features/catalog/subfeatures/details/presentation/cubit/details_state.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';

class DetailsCubit extends Cubit<DetailsState>{

  DetailsCubit({required this.scenario}): super(DetailsState());

  final Scenario scenario;
  final ScenariosStorage storage = ScenariosStorage();

  Future<void> save() async {
    await storage.save(scenario);
    emit(DetailsScenarioDownloaded());
    emit(DetailsState());
  }
}