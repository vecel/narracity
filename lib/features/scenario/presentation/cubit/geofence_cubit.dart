import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:logging/logging.dart';
import 'package:narracity/features/map/presentation/cubit/map_cubit.dart';
import 'package:narracity/features/map/presentation/cubit/map_state.dart';
import 'package:narracity/features/scenario/domain/dsl_elements.dart';
import 'package:narracity/features/scenario/presentation/cubit/scenario_cubit.dart';
import 'package:narracity/utils/geometry_helper.dart';

class GeofenceState {
  GeofenceState(this.insidePolygons);
  final Set<PolygonElement> insidePolygons;
}

class GeofenceCubit extends Cubit<GeofenceState> {
  
  GeofenceCubit({
    required ScenarioCubit scenarioCubit,
    required MapCubit mapCubit
  }) : 
    _scenarioCubit = scenarioCubit,
    _mapCubit = mapCubit,
    super(GeofenceState({})) {
      _subscribeToScenarioCubitStream();
      _subscribeToMapCubitStream();
    }

  static final Logger _log = Logger('GeofenceCubit');
  
  final ScenarioCubit _scenarioCubit;
  final MapCubit _mapCubit;

  StreamSubscription? _scenarioSubsription;
  StreamSubscription? _mapSubscription;

  void _subscribeToScenarioCubitStream() {
    _scenarioSubsription = _scenarioCubit.stream.listen((state) {
      final mapState = _mapCubit.state;
      if (mapState is! MapReady) return;
      final position = mapState.position.latLng;
      final polygons = state.polygonElements;
      _update(position, polygons);
    });
  }

  void _subscribeToMapCubitStream() {
    _mapSubscription = _mapCubit.stream.listen((state) {
      if (state is! MapReady) return;
      final position = state.position.latLng;
      final polygons = _scenarioCubit.state.polygonElements;
      _update(position, polygons);
    });
  }

  void _update(LatLng position, List<PolygonElement> polygons) {
    final Set<PolygonElement> currentlyInside = {};
    for (final polygon in polygons) {
      final isInside = GeometryHelper.isPointInPolygon(position, polygon.polygon);
      final wasInside = state.insidePolygons.contains(polygon);

      if (isInside) {
        currentlyInside.add(polygon);
      }

      if (isInside && !wasInside) {
        _log.info('User entered polygon $polygon');
        _onPolygonEnter(polygon);
      }

      if (!isInside && wasInside) {
        _log.info('User left polygon $polygon');
        _onPolygonLeave(polygon);
      }
    }

    emit(GeofenceState(currentlyInside));
  }

  void _onPolygonEnter(PolygonElement polygon) {
    if (polygon.enterTrigger != null) {
      _scenarioCubit.handleTrigger(polygon.enterTrigger!);
    }

    if (polygon.removeOnEnter) {
      _scenarioCubit.removeElement(polygon);
    }
  }

  void _onPolygonLeave(PolygonElement polygon) {
    if (polygon.leaveTrigger != null) {
      _scenarioCubit.handleTrigger(polygon.leaveTrigger!);
    }
  }

  @override
  Future<void> close() {
    _scenarioSubsription?.cancel();
    _mapSubscription?.cancel();
    return super.close();
  }
}