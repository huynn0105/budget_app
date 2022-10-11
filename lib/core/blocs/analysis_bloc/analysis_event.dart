part of 'analysis_bloc.dart';

abstract class AnalysisEvent extends Equatable {
  const AnalysisEvent();

  @override
  List<Object> get props => [];
}

class AnalysisStarted extends AnalysisEvent {
  const AnalysisStarted();
  @override
  List<Object> get props => [];
}

class AnalysisSeleteViewType extends AnalysisEvent {
  final ViewType viewType;
  const AnalysisSeleteViewType({required this.viewType});
  @override
  List<Object> get props => [viewType];
}

class AnalysisChangeDate extends AnalysisEvent {
  final DateTime date;
  final ViewType viewType;

  const AnalysisChangeDate({
    required this.date,
    required this.viewType,
  });
  @override
  List<Object> get props => [date];
}

enum ViewType {
  week,
  month,
  year,
}
