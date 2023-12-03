import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_box/features/tetris/domain/bloc/audio/tetris_audio.bloc.dart';
import 'package:game_box/features/tetris/domain/bloc/audio/tetris_audio.events.dart';
import 'package:game_box/features/tetris/features/game_field/bloc/tetris_game_field/tetris_game_field.bloc.dart';
import 'package:game_box/features/tetris/features/game_field/bloc/tetris_game_field/tetris_game_field.events.dart';
import 'package:game_box/features/tetris/features/game_field/bloc/tetris_game_field/tetris_game_field.state.dart';
import 'package:game_box/features/tetris/features/game_field/features/game_controllers/presentation/game_controllers.widget.dart';
import 'package:game_box/features/tetris/features/game_field/presentation/game_field.widget.dart';

class Tetris extends StatefulWidget {
  const Tetris({super.key});

  @override
  State<Tetris> createState() => _TetrisState();
}

class _TetrisState extends State<Tetris> {
  late final TetrisGameFieldBloc gameFieldBloc;
  late final TetrisAudionBloc audioBloc;

  @override
  void initState() {
    super.initState();
    gameFieldBloc = TetrisGameFieldBloc();
    audioBloc = TetrisAudionBloc();
    gameFieldBloc.add(const TetrisAddNewShape());
    _addAudioCallback();
    _startGame();
  }

  @override
  void dispose() {
    audioBloc.add(const TetrisEndAudio());
    super.dispose();
  }

  void _startGame() {
    gameFieldBloc.add(const TetrisStartFrameUpdate());
  }

  Future<void> _runAudio() async {
    audioBloc.add(const TetrisStartAudio());
  }

  Future<void> _addAudioCallback() async {
    gameFieldBloc.add(TetrisAddAudioCallbackField(audioCallback: () => audioBloc.add(const TetrisRemoveLineAudio())));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: gameFieldBloc),
        BlocProvider.value(value: audioBloc),
      ],
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Column(
            children: [
              Expanded(
                child: Builder(builder: (context) {
                  return BlocBuilder<TetrisGameFieldBloc, TetrisGameFieldState>(builder: (context, state) {
                    return GameField(
                      width: state.width,
                      height: state.height,
                      occupiedCells: state.occupiedCells,
                      shape: state.currentShape,
                    );
                  });
                }),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GameControllers(
                  bloc: gameFieldBloc,
                ),
              ),
            ],
          )),
    );
  }
}
