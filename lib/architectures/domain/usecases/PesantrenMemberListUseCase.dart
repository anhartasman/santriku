import 'dart:async';

import 'package:santriku/architectures/domain/entities/PesantrenMember.dart';
import 'package:santriku/architectures/domain/repositories/PesantrenRepository.dart';
import 'package:santriku/architectures/usecase/usecase.dart';

class PesantrenMemberListUseCase
    extends UseCase<List<PesantrenMember>, NoParams> {
  PesantrenMemberListUseCase(this.repository);

  final PesantrenRepository repository;

  @override
  Future<Stream<List<PesantrenMember>>> call(
    NoParams params,
  ) async {
    final StreamController<List<PesantrenMember>> controller =
        StreamController();

    repository.memberList().then((the_respon) {
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
