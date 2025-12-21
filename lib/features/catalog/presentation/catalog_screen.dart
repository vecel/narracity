import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/catalog/presentation/cubit/catalog_cubit.dart';
import 'package:narracity/features/catalog/presentation/cubit/catalog_state.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:narracity/shared_widgets/base_app_bar.dart';

import 'details_screen.dart';
import 'catalog_list_item.dart';
import 'package:flutter/material.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key, required this.repository});

  final ScenariosRepository repository;

  @override
  Widget build(BuildContext context) { 
    return BlocProvider(
      create: (context) => CatalogCubit(repository)..load(),
      child: Scaffold(
        appBar: BaseAppBar(title: 'Choose Scenario'),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        body: const _CatalogView()
      ),
    );
  }
}

class _CatalogView extends StatelessWidget {
  const _CatalogView();

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CatalogCubit>().state;

    return switch (state) {
      CatalogLoading() => const _LodaingView(),
      CatalogLoaded(:final scenarios) when scenarios.isEmpty => _EmptyView(),
      CatalogLoaded(:final scenarios) => _SuccessView(scenarios)
    };
  }

  
}

class _LodaingView extends StatelessWidget {
  const _LodaingView();

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();

  @override
  Widget build(BuildContext context) {
    return Center(child: Text('No scenarios available :('));
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView(this.scenarios);

  final List<Scenario> scenarios;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(20.0)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: ListView.builder(
            itemCount: scenarios.length,
            itemBuilder: (context, index) {
              final scenario = scenarios[index];
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => DetailsScreen(scenario: scenario))
                  ),
                  child: CatalogListItem(scenario: scenario)
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
