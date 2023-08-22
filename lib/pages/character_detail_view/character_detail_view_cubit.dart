import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'character_detail_view_state.dart';

class CharacterDetailViewCubit extends Cubit<CharacterDetailViewState> {
  CharacterDetailViewCubit() : super(CharacterDetailViewInitial());
}
