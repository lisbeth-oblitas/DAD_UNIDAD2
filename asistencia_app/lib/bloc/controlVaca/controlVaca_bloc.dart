import 'dart:async';

import 'package:asistencia_app/modelo/ControlVacaModelo.dart';
import 'package:asistencia_app/repository/ControlVacaRepository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'controlVaca_event.dart';
part 'controlVaca_state.dart';

class ControlVacaBloc extends Bloc<ControlVacaEvent, ControlVacaState> {
  late final ControlVacaRepository _controlVacaRepository;
  ControlVacaBloc(this._controlVacaRepository) : super(ControlVacaInitialState()) {
    on<ControlVacaEvent>((event, emit) async{
      // TODO: implement event handler
      print("Bloc x");
      if(event is ListarControlVacaEvent){
        emit(ControlVacaLoadingState());
        try{
          print("pasox!!");
          List<ControlVacaModelo> PersonaList= await _controlVacaRepository.getControlVaca();
          emit(ControlVacaLoadedState(PersonaList));
        } catch(e){
          emit(ControlVacaError(e as Error)) ;
        }
      }else if(event is DeleteControlVacaEvent){
        try{
          await _controlVacaRepository.deleteControlVaca(event.controlVaca!.id);
          emit(ControlVacaLoadingState());
          List<ControlVacaModelo> PersonaList= await _controlVacaRepository.getControlVaca();
          emit(ControlVacaLoadedState(PersonaList));
        }catch(e){
          emit(ControlVacaError(e as Error));
        }
      }else if(event is CreateControlVacaEvent){
        try{
          await _controlVacaRepository.createControlVaca(event.controlVaca!);
          emit(ControlVacaLoadingState());
          List<ControlVacaModelo> PersonaList= await _controlVacaRepository.getControlVaca();
          emit(ControlVacaLoadedState(PersonaList));
        }catch(e){
          emit(ControlVacaError(e as Error));
        }
      }else if(event is UpdateControlVacaEvent){
        try{
          await _controlVacaRepository.updateControlVaca(event.controlVaca!.id, event.controlVaca!);
          emit(ControlVacaLoadingState());
          List<ControlVacaModelo> PersonaList= await _controlVacaRepository.getControlVaca();
          emit(ControlVacaLoadedState(PersonaList));
        }catch(e){
          emit(ControlVacaError(e as Error));
        }
      }
    });
  }
}