import 'package:bloc/bloc.dart';
import 'package:saibupi/architectures/domain/usecases/FamilyMemberListUseCase.dart';
import 'package:saibupi/architectures/usecase/usecase.dart';

import './bloc.dart';

class FamilyMemberListBloc
    extends Bloc<FamilyMemberListBlocEvent, FamilyMemberListBlocState> {
  final FamilyMemberListUseCase familyMemberListUseCase;

  FamilyMemberListBloc({
    required this.familyMemberListUseCase,
  }) : super(FamilyMemberListOnIdle()) {
    on<FamilyMemberListBlocEvent>((event, emit) async {
      if (event is FamilyMemberListBlocRetrieve) {
        emit(FamilyMemberListOnStarted());
        final failureOrTrivia = await familyMemberListUseCase(NoParams());

        try {
          var memberList = await failureOrTrivia.first;

          emit(FamilyMemberListOnSuccess(
            memberList,
          ));
        } catch (e) {
          emit(FamilyMemberListOnError(e.toString()));
        }
      }
    });
  }
}
