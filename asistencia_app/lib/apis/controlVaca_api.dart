import 'package:asistencia_app/modelo/ControlVacaModelo.dart';
import 'package:asistencia_app/modelo/GenericModelo.dart';
import 'package:asistencia_app/util/UrlApi.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/http.dart';

part 'controlVaca_api.g.dart';
@RestApi(baseUrl: UrlApi.urlApix)
abstract class ControlVacaApi {
  factory ControlVacaApi(Dio dio, {String baseUrl}) = _ControlVacaApi;

  static ControlVacaApi create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return ControlVacaApi(dio);
  }

  @GET("/finca/cvaca/list")
  Future<List<ControlVacaModelo>> getControlVaca(@Header("Authorization") String token);

  @POST("/finca/cvaca/crear")
  Future<ControlVacaModelo> crearControlVaca(@Header("Authorization") String token, @Body() ControlVacaModelo controlVaca);

  @GET("/finca/cvaca/buscar/{id}")
  Future<ControlVacaModelo> findControlVaca(@Header("Authorization") String token, @Path("id") int id);

  @DELETE("/finca/cvaca/eliminar/{id}")
  Future<GenericModelo> deleteControlVaca(@Header("Authorization") String token, @Path("id") int id);

  @PUT("/finca/controlVaca/editar/{id}")
  Future<ControlVacaModelo> updateControlVaca(@Header("Authorization") String token, @Path("id") int id , @Body() ControlVacaModelo controlVaca);
}