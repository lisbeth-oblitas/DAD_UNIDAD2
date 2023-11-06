import 'package:asistencia_app/apis/controlVaca_api.dart';
import 'package:asistencia_app/modelo/ControlVacaModelo.dart';
import 'package:asistencia_app/modelo/GenericModelo.dart';
import 'package:asistencia_app/util/TokenUtil.dart';
import 'package:dio/dio.dart';
class ControlVacaRepository {
  ControlVacaApi? controlVacaApi;

  ControlVacaRepository() {
    Dio _dio = Dio();
    _dio.options.headers["Content-Type"] = "application/json";
    controlVacaApi = ControlVacaApi(_dio);
  }

  Future<List<ControlVacaModelo>> getControlVaca() async {
    var dato = await controlVacaApi!.getControlVaca(TokenUtil.TOKEN).then((
        value) => value);
    return await dato;
  }

  Future<GenericModelo> deleteControlVaca(int id) async {
    return await controlVacaApi!.deleteControlVaca(TokenUtil.TOKEN, id);
  }

  Future<ControlVacaModelo> updateControlVaca(int id,
      ControlVacaModelo controlVaca) async {
    return await controlVacaApi!.updateControlVaca(TokenUtil.TOKEN, id, controlVaca);
  }

  Future<ControlVacaModelo> createControlVaca(ControlVacaModelo controlVaca) async {
    return await controlVacaApi!.crearControlVaca(TokenUtil.TOKEN, controlVaca);
  }
}