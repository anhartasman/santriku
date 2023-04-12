import 'package:bloc/bloc.dart';
import 'package:santriku/architectures/domain/usecases/PesantrenMemberDetailUseCase.dart';
import 'package:santriku/architectures/usecase/usecase.dart';

import './bloc.dart';

class PesantrenMemberDetailBloc extends Bloc<PesantrenMemberDetailBlocEvent,
    PesantrenMemberDetailBlocState> {
  final PesantrenMemberDetailUseCase pesantrenMemberDetailUseCase;

  PesantrenMemberDetailBloc({
    required this.pesantrenMemberDetailUseCase,
  }) : super(PesantrenMemberDetailOnIdle()) {
    on<PesantrenMemberDetailBlocEvent>((event, emit) async {
      if (event is PesantrenMemberDetailBlocRetrieve) {
        emit(PesantrenMemberDetailOnStarted(event.id));
        final failureOrTrivia = await pesantrenMemberDetailUseCase(event.id);

        try {
          var theMember = await failureOrTrivia.first;

          emit(PesantrenMemberDetailOnSuccess(
            theMember,
          ));
        } catch (e) {
          emit(PesantrenMemberDetailOnError(event.id, e.toString()));
        }
      }
    });
  }
}
