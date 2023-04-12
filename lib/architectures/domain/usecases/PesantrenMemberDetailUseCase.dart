import 'dart:async';

import 'package:santriku/architectures/domain/entities/PesantrenMember.dart';
import 'package:santriku/architectures/domain/repositories/PesantrenRepository.dart';
import 'package:santriku/architectures/usecase/usecase.dart';

class PesantrenMemberDetailUseCase extends UseCase<PesantrenMember, int> {
  PesantrenMemberDetailUseCase(this.repository);

  final PesantrenRepository repository;

  @override
  Future<Stream<PesantrenMember>> call(
    int id,
  ) async {
    final StreamController<PesantrenMember> controller = StreamController();

    repository.memberDetail(id).then((the_respon) {
      controller.add((the_respon));

      controller.close();
    }).catchError((e) {
      print("add error ${e}");
      // yield (balikanError.balikan(e.toString()));

      controller.addError(e);
    });

    return controller.stream;
  }
}
