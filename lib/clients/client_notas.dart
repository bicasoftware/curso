import 'package:curso/dto/notas_dto.dart';
import 'package:curso/dto/update_dto.dart';
import 'package:curso/dto/delete_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:curso/stuff.dart';

part 'client_notas.g.dart';

@RestApi(baseUrl: '$host/notas')
abstract class ClientNotas {

  factory ClientNotas(Dio dio) = _ClientNotas;

  @GET('/{id}')
  Future<List<NotasDto>> fetch(@Path() int id);

  @PUT('/{id}')
  Future<UpdateDto> put(@Path() int id, @Body() NotasDto model);

  @DELETE('/{id}')
  Future<DeleteDto> delete(@Path() int id);

  @POST('/')
  Future<NotasDto> post(@Body() NotasDto model);
}