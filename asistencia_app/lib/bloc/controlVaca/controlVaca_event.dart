part of 'controlVaca_bloc.dart';

@immutable
abstract class ControlVacaEvent {}
class ListarControlVacaEvent extends ControlVacaEvent{
  ListarControlVacaEvent(){print("Evento si");}
//ListarControlVacaEvent({required ControlVacaModelo controlVaca}):super(controlVaca:controlVaca);
}
class DeleteControlVacaEvent extends ControlVacaEvent{
  ControlVacaModelo controlVaca;
  DeleteControlVacaEvent(this.controlVaca);
//DeleteControlVacaEvent({required ControlVacaModelo controlVaca}):super(controlVaca:controlVaca);
}
class UpdateControlVacaEvent extends ControlVacaEvent{
  ControlVacaModelo controlVaca;
  UpdateControlVacaEvent(this.controlVaca);
//UpdateControlVacaEvent({required ControlVacaModelo controlVaca}):super(controlVaca:controlVaca);
}
class CreateControlVacaEvent extends ControlVacaEvent{
  ControlVacaModelo controlVaca;
  CreateControlVacaEvent(this.controlVaca);
//CreateControlVacaEvent({required ControlVacaModelo controlVaca}):super(controlVaca:controlVaca);
}