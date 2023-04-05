import 'dart:async';

import 'package:saibupi/architectures/domain/entities/FamilyMember.dart';
import 'package:saibupi/architectures/domain/repositories/FamilyRepository.dart';
import 'package:saibupi/architectures/usecase/usecase.dart';

class FamilyMemberSaveUseCase extends UseCase<void, FamilyMember> {
  FamilyMemberSaveUseCase(this.repository);

  final FamilyRepository repository;

  @override
  Future<Stream<void>> call(
    FamilyMember theMember,
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
