import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class ControlVacaModelo {
  ControlVacaModelo({
    required this.id,
    required this.etapaDetalle,
    required this.fechaProg,
    required this.fechaReal,
    required this.pesoVivo,
    required this.preno,
    required this.condicionCorporal,
    required this.tieneMastitis,
    required this.tratamiento,

  });

  ControlVacaModelo.unlaunched();

  late  int id=0;
  late final String etapaDetalle;
  late final String fechaProg;
  late final String fechaReal;
  late final String pesoVivo;
  late final String preno;
  late final String condicionCorporal;
  late final String tieneMastitis;
  late final String tratamiento;



  ControlVacaModelo.fromJson(Map<String, dynamic> json){
    id = json['id'];
    etapaDetalle = json['etapaDetalle'];
    fechaProg = json['fechaProg'];
    fechaReal = json['fechaReal'];
    pesoVivo = json['pesoVivo'];
    preno = json['preno'];
    condicionCorporal = json['condicionCorporal'];
    tieneMastitis = json['tieneMastitis'];
    tratamiento = json['tratamiento'];



  }

  factory ControlVacaModelo.fromJsonModelo(Map<String, dynamic> json){
    return ControlVacaModelo(
      id : json['id'],
      etapaDetalle : json['etapaDetalle'],
      fechaProg : json['fechaProg'],
      fechaReal : json['fechaReal'],
      pesoVivo : json['pesoVivo'],
      preno : json['preno'],
      condicionCorporal : json['condicionCorporal'],
      tieneMastitis : json['tieneMastitis'],
      tratamiento : json['tratamiento'],

    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['etapaDetalle'] = etapaDetalle;
    _data['fechaProg'] = fechaProg;
    _data['fechaReal'] = fechaReal;
    _data['pesoVivo'] = pesoVivo;
    _data['preno'] = preno;
    _data['condicionCorporal'] = condicionCorporal;
    _data['tieneMastitis'] = tieneMastitis;
    _data['tratamiento'] = tratamiento;
    return _data;
  }
}