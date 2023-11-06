part of 'controlVaca_bloc.dart';



@immutable
abstract class ControlVacaState {}

class ControlVacaInitialState extends ControlVacaState {}
class ControlVacaLoadingState extends ControlVacaState{}
class ControlVacaLoadedState extends ControlVacaState{
  List<ControlVacaModelo> ControlVacaList;
  ControlVacaLoadedState(this.ControlVacaList);
}
class ControlVacaError extends ControlVacaState{
  Error e;
  ControlVacaError(this.e);
}