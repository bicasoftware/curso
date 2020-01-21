import 'package:curso/dto/horarios_dto.dart';
import 'package:curso/dto/update_dto.dart';
import 'package:curso/dto/delete_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:curso/stuff.dart';

part 'client_horarios.g.dart';

@RestApi(baseUrl: '$host/horarios')
abstract class ClientHorarios {
  factory ClientHorarios(Dio dio) = _ClientHorarios;

  @GET('/{id}')
  Future<List<HorariosDto>> fetch(@Path() int id);

  @DELETE('/{id}')
  Future<DeleteDto> delete(@Path() int id);

  @POST('/')
  Future<List<HorariosDto>> post(@Body() List<HorariosDto> horarios);
}
