import 'package:bloc/bloc.dart';
import 'package:saibupi/architectures/domain/usecases/FamilyMemberSaveUseCase.dart';
import 'package:saibupi/architectures/usecase/usecase.dart';

import './bloc.dart';

class FamilyMemberSaveBloc
    extends Bloc<FamilyMemberSaveBlocEvent, FamilyMemberSaveBlocState> {
  final FamilyMemberSaveUseCase familyMemberSaveUseCase;

  FamilyMemberSaveBloc({
    required this.familyMemberSaveUseCase,
  }) : super(FamilyMemberSaveOnIdle()) {
    on<FamilyMemberSaveBlocEvent>((event, emit) async {
      if (event is FamilyMemberSaveBlocStart) {
        emit(FamilyMemberSaveOnStarted());
        final failureOrTrivia = await familyMemberSaveUseCase(event.theMember);

        try {
          var memberList = await failureOrTrivia.first;

          emit(FamilyMemberSaveOnSuccess());
        } catch (e) {
          emit(FamilyMemberSaveOnError(e.toString()));
        }
      }
    });
  }
}
