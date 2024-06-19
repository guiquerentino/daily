import 'package:flutter/material.dart';

import '../domain/emotion.dart';


class EmojisUtils {

  static String retornaNomeFormatadoEmocao(EMOTION_TYPE emotionType) {
    switch (emotionType) {
      case EMOTION_TYPE.MUITO_FELIZ:
        return "Muito Feliz";
      case EMOTION_TYPE.FELIZ:
        return "Feliz";
      case EMOTION_TYPE.NORMAL:
        return "Normal";
      case EMOTION_TYPE.TRISTE:
        return "Triste";
      case EMOTION_TYPE.BRAVO:
        return "Bravo";
    }
  }

Image retornaEmojiEmocao(EMOTION_TYPE emotionType, bool big) {
  double size = big ? 90 : 60;

  switch (emotionType) {
    case EMOTION_TYPE.FELIZ:
      return Image.asset("assets/emoji_felicidade.png", height: size, width: size, fit: BoxFit.fill);
    case EMOTION_TYPE.BRAVO:
      return Image.asset("assets/emoji_bravo.png", height: size, width: size, fit: BoxFit.fill);
    case EMOTION_TYPE.TRISTE:
      return Image.asset("assets/emoji_triste.png", height: size, width: size, fit: BoxFit.fill);
    case EMOTION_TYPE.NORMAL:
      return Image.asset("assets/emoji_normal.png", height: size, width: size, fit: BoxFit.fill);
    case EMOTION_TYPE.MUITO_FELIZ:
      return Image.asset("assets/emoji_muito_feliz.png", height: size, width: size, fit: BoxFit.fill);
    default:
      return Image.asset("assets/emoji_default.png", height: size, width: size, fit: BoxFit.fill); // Uma imagem padrão caso emotionType não corresponda a nenhum caso
  }
  }
}

