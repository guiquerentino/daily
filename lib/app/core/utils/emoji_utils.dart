import 'package:flutter/material.dart';

import '../domain/Registro.dart';


class EmojisUtils {
  Image retornaEmojiClima(WEATHER_TYPE weatherType) {
    switch (weatherType) {
      case WEATHER_TYPE.ENSOLARADO:
        return Image.asset("assets/sun.png");
      case WEATHER_TYPE.CHUVOSO:
        return Image.asset("assets/rainy.png");
      case WEATHER_TYPE.FRIO:
        return Image.asset("assets/cold.png");
      case WEATHER_TYPE.TEMPESTUOSO:
        return Image.asset("assets/tesmpestade.png");
      case WEATHER_TYPE.NUBLADO:
        return Image.asset("assets/cloudy.png");
      case WEATHER_TYPE.LIMPO:
        return Image.asset("assets/clear.png");
    }
  }

  String retornaNomeFormatadoEmocao(EMOTION_TYPE emotionType){
    switch (emotionType) {
      case EMOTION_TYPE.FELICIDADE:
        return "Felicidade";
      case EMOTION_TYPE.ANSIEDADE:
        return "Ansiedade";
      case EMOTION_TYPE.TEDIO:
        return "Tédio";
      case EMOTION_TYPE.TRISTEZA:
        return "Tristeza";
      case EMOTION_TYPE.CONFUSAO:
        return "Confusão";
      case EMOTION_TYPE.ANIMACAO:
        return "Animação";
      case EMOTION_TYPE.DECEPCAO:
        return "Decepção";
      case EMOTION_TYPE.FOCO:
        return "Foco";
      case EMOTION_TYPE.APATICO:
        return "Apático";
      case EMOTION_TYPE.SURPRESA:
        return "Surpresa";
      case EMOTION_TYPE.CANSASO:
        return "Cansaço";
      case EMOTION_TYPE.MOTIVADO:
        return "Motivado";
    }
  }

  Image retornaEmojiEmocao(EMOTION_TYPE emotionType, bool big) {
    double size = big ? 90 : 60;

    switch (emotionType) {
      case EMOTION_TYPE.FELICIDADE:
        return Image.asset("assets/emoji_felicidade.png", height: size, width: size, fit: BoxFit.fill);
      case EMOTION_TYPE.ANSIEDADE:
        return Image.asset("assets/emoji_ansiedade.png", height: size, width: size, fit: BoxFit.fill);
      case EMOTION_TYPE.TEDIO:
        return Image.asset("assets/emoji_tedio.png", height: size, width: size, fit: BoxFit.fill);
      case EMOTION_TYPE.TRISTEZA:
        return Image.asset("assets/emoji_tristeza.png", height: size, width: size, fit: BoxFit.fill);
      case EMOTION_TYPE.CONFUSAO:
        return Image.asset("assets/emoji_confusao.png", height: size, width: size, fit: BoxFit.fill);
      case EMOTION_TYPE.ANIMACAO:
        return Image.asset("assets/emoji_animacao.png", height: size, width: size, fit: BoxFit.fill);
      case EMOTION_TYPE.DECEPCAO:
        return Image.asset("assets/emoji_decepcao.png", height: size, width: size, fit: BoxFit.fill);
      case EMOTION_TYPE.FOCO:
        return Image.asset("assets/emoji_foco.png", height: size, width: size, fit: BoxFit.fill);
      case EMOTION_TYPE.APATICO:
        return Image.asset("assets/emoji_apatico.png", height: size, width: size, fit: BoxFit.fill);
      case EMOTION_TYPE.SURPRESA:
        return Image.asset("assets/emoji_surpresa.png", height: size, width: size, fit: BoxFit.fill);
      case EMOTION_TYPE.CANSASO:
        return Image.asset("assets/emoji_cansaso.png", height: size, width: size, fit: BoxFit.fill);
      case EMOTION_TYPE.MOTIVADO:
        return Image.asset("assets/emoji_motivado.png", height: size, width: size, fit: BoxFit.fill);
      default:
        return Image.asset("assets/emoji_default.png", height: size, width: size, fit: BoxFit.fill); // Uma imagem padrão caso emotionType não corresponda a nenhum caso
    }
  }
}
