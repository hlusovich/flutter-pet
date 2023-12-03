import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_box/features/tetris/domain/bloc/difficulty/tetris_difficulty.state.dart';
import 'package:game_box/features/tetris/domain/bloc/difficulty/tetris_game.events.dart';

class TetrisDifficultiesBloc extends Bloc<TetrisDifficultyEvents, TetrisDifficultyStates> {
  TetrisDifficultiesBloc() : super(const TetrisInitialDifficultyState()) {
    on<UpdateTetrisDifficulty>(onUpdateTetrisDifficulty);
  }

  void onUpdateTetrisDifficulty(UpdateTetrisDifficulty event, Emitter<TetrisDifficultyStates> emit) async {
    emit(TetrisUpdateDifficultyState(event.difficulty));
  }
}
