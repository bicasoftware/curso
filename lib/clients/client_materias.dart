import 'package:curso/dto/materias_dto.dart';
import 'package:curso/dto/update_dto.dart';
import 'package:curso/dto/delete_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:curso/stuff.dart';

part 'client_materias.g.dart';


@RestApi(baseUrl: '$host/materias')
abstract class ClientMaterias {

  factory ClientMaterias(Dio dio) = _ClientMaterias;

  @GET('/{id}')
  Future<List<MateriasDto>> fetch(@Path() int id);

  @PUT('/{id}')
  Future<UpdateDto> put(@Path() int id, @Body() MateriasDto model);

  @DELETE('/{id}')
  Future<DeleteDto> delete(@Path() int id);

  @POST('/')
  Future<MateriasDto> post(@Body() MateriasDto model);
}