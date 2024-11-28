// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class DashboardFetchDataEvent extends DashboardEvent {
  const DashboardFetchDataEvent({
    this.skipLoading = false,
  });
  final bool skipLoading;

  @override
  List<Object?> get props => [];
}
