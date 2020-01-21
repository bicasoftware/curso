import 'package:curso/dto/aulas_dto.dart';
import 'package:curso/dto/update_dto.dart';
import 'package:curso/dto/delete_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:curso/stuff.dart';

part 'client_aulas.g.dart';

@RestApi(baseUrl: '$host/aulas')
abstract class ClientAulas {

  factory ClientAulas(Dio dio) = _ClientAulas;

  @GET('/{id}')
  Future<List<AulasDto>> fetch(@Path() int id);

  @PUT('/{id}')
  Future<UpdateDto> put(@Path() int id, @Body() AulasDto model);

  @DELETE('/{id}')
  Future<DeleteDto> delete(@Path() int id);

  @POST('/')
  Future<AulasDto> post(@Body() AulasDto model);
}