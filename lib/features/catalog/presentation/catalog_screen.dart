import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:narracity/features/catalog/data/scenarios_repository.dart';
import 'package:narracity/features/catalog/presentation/cubit/catalog_cubit.dart';
import 'package:narracity/features/catalog/presentation/cubit/catalog_state.dart';
import 'package:narracity/features/scenario/domain/dsl_scenario.dart';
import 'package:narracity/shared_widgets/base_app_bar.dart';

import 'catalog_list_item.dart';
import 'package:flutter/material.dart';

// TODO: Display only after image is loaded

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) { 
    final repository = RepositoryProvider.of<ScenariosRepository>(context);

    return BlocProvider(
      create: (context) => CatalogCubit(repository)..load(),
      child: Scaffold(
        appBar: BaseAppBar(title: 'Catalog', backRoute: '/'),
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
    return BlocBuilder<CatalogCubit, CatalogState>(
      builder: (context, state) => switch (state) {
        CatalogLoading() => const _LodaingView(),
        CatalogLoaded(:final scenarios) when scenarios.isEmpty => _EmptyView(),
        CatalogLoaded(:final scenarios) => _SuccessView(scenarios),
        CatalogError(:final message, :final isConnectionError) => _ErrorView(message, isConnectionError),
      },
    );
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
    return _MessageView('Scenarios repository is empty.', Icons.sentiment_dissatisfied, 'No scenarios found');
  }
}

class _SuccessView extends StatelessWidget {
  const _SuccessView(this.scenarios);

  final List<Scenario> scenarios;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => context.read<CatalogCubit>().load(),
      child: Padding(
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
                return CatalogListItem(scenario: scenario);
              }
            ),
          ),
        ),
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView(this.message, this.isConnectionError);

  final String message;
  final bool isConnectionError;

  @override
  Widget build(BuildContext context) {
    return isConnectionError
      ? _MessageView(message, Icons.wifi_off_outlined, 'Connection lost')
      : _MessageView(message, Icons.error_outline, 'Error');
  }
}

class _MessageView extends StatelessWidget {
  const _MessageView(this.message, this.icon, this.iconLabel);

  final String message;
  final IconData icon;
  final String iconLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              iconLabel,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: () => context.read<CatalogCubit>().load(),
              icon: const Icon(Icons.refresh),
              label: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }
}