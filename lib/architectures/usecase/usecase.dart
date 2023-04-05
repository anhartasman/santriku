import 'package:equatable/equatable.dart';

abstract class UseCase<Type, Params> {
  Future<Stream<Type>> call(Params params);
}

abstract class BalikanError<Type> {
  Type balikan(String pesan);
}

abstract class TungguBalikan<Type, TipeBalikan> {
  Type balikan(TipeBalikan param);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
