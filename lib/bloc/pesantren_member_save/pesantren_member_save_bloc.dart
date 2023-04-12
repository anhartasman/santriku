import 'package:bloc/bloc.dart';
import 'package:santriku/architectures/domain/usecases/PesantrenMemberSaveUseCase.dart';
import 'package:santriku/architectures/usecase/usecase.dart';

import './bloc.dart';

class PesantrenMemberSaveBloc
    extends Bloc<PesantrenMemberSaveBlocEvent, PesantrenMemberSaveBlocState> {
  final PesantrenMemberSaveUseCase pesantrenMemberSaveUseCase;

  PesantrenMemberSaveBloc({
    required this.pesantrenMemberSaveUseCase,
  }) : super(PesantrenMemberSaveOnIdle()) {
    on<PesantrenMemberSaveBlocEvent>((event, emit) async {
      if (event is PesantrenMemberSaveBlocStart) {
        emit(PesantrenMemberSaveOnStarted());
        final failureOrTrivia =
            await pesantrenMemberSaveUseCase(event.theMember);

        try {
          var memberList = await failureOrTrivia.first;

          emit(PesantrenMemberSaveOnSuccess());
        } catch (e) {
          emit(PesantrenMemberSaveOnError(e.toString()));
        }
      }
    });
  }
}
