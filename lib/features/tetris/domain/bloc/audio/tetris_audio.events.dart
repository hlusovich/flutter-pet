abstract interface class TetrisAudioEvents {
  const TetrisAudioEvents();
}

final class TetrisStartAudio extends TetrisAudioEvents {
  const TetrisStartAudio();
}

final class TetrisEndAudio extends TetrisAudioEvents {
  const TetrisEndAudio();
}

final class TetrisRemoveLineAudio extends TetrisAudioEvents {
  const TetrisRemoveLineAudio();
}
