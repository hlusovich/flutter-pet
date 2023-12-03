import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_box/features/tetris/domain/bloc/audio/tetris_audio.events.dart';
import 'package:game_box/features/tetris/domain/bloc/audio/tetris_audio.state.dart';

class TetrisAudionBloc extends Bloc<TetrisAudioEvents, TetrisAudioStates> {
  TetrisAudionBloc() : super(const TetrisAudioInitialState()) {
    on<TetrisStartAudio>(onTetrisStartAudio);
    on<TetrisEndAudio>(onTetrisEndAudio);
    on<TetrisRemoveLineAudio>(onTetrisRemoveLineAudio);
  }

  late final AudioPlayer effectsPlayer = AudioPlayer();
  late final AudioPlayer themeAudioPlayer = AudioPlayer();

  void onTetrisStartAudio(TetrisStartAudio event, Emitter<TetrisAudioStates> emit) async {
    themeAudioPlayer.setReleaseMode(ReleaseMode.loop);
    themeAudioPlayer.play(AssetSource('audio/Tetris.mp3'));
  }

  void onTetrisEndAudio(TetrisEndAudio event, Emitter<TetrisAudioStates> emit) async {
    await effectsPlayer.dispose();
    await themeAudioPlayer.dispose();
  }

  void onTetrisRemoveLineAudio(TetrisRemoveLineAudio event, Emitter<TetrisAudioStates> emit) async {
    themeAudioPlayer.pause();
    effectsPlayer.play(AssetSource('audio/stage_clear.mp3')).then((value) => themeAudioPlayer.resume());
  }
}
