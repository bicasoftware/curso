import 'dart:async';

import 'package:rxdart/rxdart.dart';

/**
 * Classe para auxiliar na criação de Behaviour subject
 * Permitindo testar se o valor foi alterado e permitindo a extração do valor de maneira síncrona 
 */

///Implementa-se a partir de Sink para que ao instanciar, mostre um warning avisando para fechar a Sink
class Flux<T> implements Sink<T> {
  BehaviorSubject<T> _bhsHelper;
  Stream<T> _outHelper;
  Sink<T> _inHelper;

  ///Grava um valor de forma síncrona para leitura sem [StreamBuilder]
  ///Útil em telas onde é necessário validar alterações antes de retornar valores reais
  T _value;

  bool _hasChanged = false;

  Flux(T value) : assert(value != null) {    
    _bhsHelper = _bhsHelper = BehaviorSubject<T>.seeded(value);
    _outHelper = _bhsHelper.stream;
    _inHelper = _bhsHelper.sink;
    _value = value;
  }

  ///Retorna um [Stream<T>]
  Stream<T> get() => _outHelper;

  ///Seta o [_value], adicionar valor ao [Sink] e seta como [_hasChanged]
  void set(T value) {
    if (value != _value) {
      _inHelper.add(value);
      _value = value;
    }
    _hasChanged = true;
  }

  ///Retorna valor para leitura de forma Síncrona
  T get value => _value;

  ///Fecha a [Sink]
  void close() => _bhsHelper.close();

  ///Retorna se o valor foi alterado
  bool get hasChanged => _hasChanged;

  @override
  void add(T event) {}
}
