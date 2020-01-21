import 'package:curso/dto/faltas_dto.dart';
import 'package:curso/dto/update_dto.dart';
import 'package:curso/dto/delete_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:curso/stuff.dart';

part 'client_faltas.g.dart';

@RestApi(baseUrl: '$host/faltas')
abstract class ClientFaltas {

  factory ClientFaltas(Dio dio) = _ClientFaltas;

  @GET('/{id}')
  Future<List<FaltasDto>> fetch(@Path() int id);

  @PUT('/{id}')
  Future<UpdateDto> put(@Path() int id, @Body() FaltasDto model);

  @DELETE('/{id}')
  Future<DeleteDto> delete(@Path() int id);

  @POST('/')
  Future<FaltasDto> post(@Body() FaltasDto model);
}