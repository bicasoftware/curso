import 'package:curso/dto/periodos_dto.dart';
import 'package:curso/dto/update_dto.dart';
import 'package:curso/dto/delete_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:curso/stuff.dart';

part 'client_periodos.g.dart';

@RestApi(baseUrl: '$host/periodos')
abstract class ClientPeriodos {
  factory ClientPeriodos(Dio dio) = _ClientPeriodos;

  @GET('/')
  Future<List<PeriodosDto>> fetchAll();

  @PUT('/{id}')
  Future<UpdateDto> put(@Path() int id, @Body() PeriodosDto model);

  @DELETE('/{id}')
  Future<DeleteDto> delete(@Path() int id);

  @POST('/')
  Future<PeriodosDto> post(@Body() PeriodosDto model);
}
