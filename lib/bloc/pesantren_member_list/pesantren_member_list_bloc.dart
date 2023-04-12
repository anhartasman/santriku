import 'package:bloc/bloc.dart';
import 'package:santriku/architectures/domain/usecases/PesantrenMemberListUseCase.dart';
import 'package:santriku/architectures/usecase/usecase.dart';

import './bloc.dart';

class PesantrenMemberListBloc
    extends Bloc<PesantrenMemberListBlocEvent, PesantrenMemberListBlocState> {
  final PesantrenMemberListUseCase pesantrenMemberListUseCase;

  PesantrenMemberListBloc({
    required this.pesantrenMemberListUseCase,
  }) : super(PesantrenMemberListOnIdle()) {
    on<PesantrenMemberListBlocEvent>((event, emit) async {
      if (event is PesantrenMemberListBlocRetrieve) {
        emit(PesantrenMemberListOnStarted());
        final failureOrTrivia = await pesantrenMemberListUseCase(NoParams());

        try {
          var memberList = await failureOrTrivia.first;

          emit(PesantrenMemberListOnSuccess(
            memberList,
          ));
        } catch (e) {
          emit(PesantrenMemberListOnError(e.toString()));
        }
      }
    });
  }
}
