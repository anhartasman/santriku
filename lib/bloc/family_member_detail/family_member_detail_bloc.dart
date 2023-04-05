import 'package:bloc/bloc.dart';
import 'package:saibupi/architectures/domain/usecases/FamilyMemberDetailUseCase.dart';
import 'package:saibupi/architectures/usecase/usecase.dart';

import './bloc.dart';

class FamilyMemberDetailBloc
    extends Bloc<FamilyMemberDetailBlocEvent, FamilyMemberDetailBlocState> {
  final FamilyMemberDetailUseCase familyMemberDetailUseCase;

  FamilyMemberDetailBloc({
    required this.familyMemberDetailUseCase,
  }) : super(FamilyMemberDetailOnIdle()) {
    on<FamilyMemberDetailBlocEvent>((event, emit) async {
      if (event is FamilyMemberDetailBlocRetrieve) {
        emit(FamilyMemberDetailOnStarted(event.id));
        final failureOrTrivia = await familyMemberDetailUseCase(event.id);

        try {
          var theMember = await failureOrTrivia.first;

          emit(FamilyMemberDetailOnSuccess(
            theMember,
          ));
        } catch (e) {
          emit(FamilyMemberDetailOnError(event.id, e.toString()));
        }
      }
    });
  }
}
