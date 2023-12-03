import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_box/features/tetris/domain/bloc/game/tetris_game.events.dart';
import 'package:game_box/features/tetris/domain/bloc/game/tetris_game.state.dart';

class TetrisGameBloc extends Bloc<TetrisGameEvents, TetrisGameStates> {
  TetrisGameBloc() : super(const TetrisGameInitialState()) {
    on<StartTetrisGame>(onStartTetrisGame);
    on<EndTetrisGame>(onEndTetrisGame);
  }

  void onStartTetrisGame(StartTetrisGame event, Emitter<TetrisGameStates> emit) async {}

  void onEndTetrisGame(EndTetrisGame event, Emitter<TetrisGameStates> emit) async {}
}
