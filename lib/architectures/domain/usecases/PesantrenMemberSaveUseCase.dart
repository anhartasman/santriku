import 'dart:async';

import 'package:santriku/architectures/domain/entities/PesantrenMember.dart';
import 'package:santriku/architectures/domain/repositories/PesantrenRepository.dart';
import 'package:santriku/architectures/usecase/usecase.dart';

class PesantrenMemberSaveUseCase extends UseCase<void, PesantrenMember> {
  PesantrenMemberSaveUseCase(this.repository);

  final PesantrenRepository repository;

  @override
  Future<Stream<void>> call(
    PesantrenMember theMember,
  ) async {
    final StreamController<void> controller = StreamController();

    repository.saveMember(theMember).then((the_respon) {
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
