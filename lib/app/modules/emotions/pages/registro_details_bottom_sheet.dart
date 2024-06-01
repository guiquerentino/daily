
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../core/domain/Registro.dart';
import '../../../core/utils/emoji_utils.dart';

class RegistroDetailsBottomSheet extends StatefulWidget {
  final Registro registro;

  const RegistroDetailsBottomSheet({super.key, required this.registro});

  @override
  State<RegistroDetailsBottomSheet> createState() =>
      _RegistroDetailsBottomSheetState();
}

class _RegistroDetailsBottomSheetState
    extends State<RegistroDetailsBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 0.9,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.arrow_back_outlined)),
                      const Text("Detalhes do Registro",
                          style:
                              TextStyle(fontFamily: 'Pangram', fontSize: 22)),
                      const Spacer(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.edit,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                  Container(
                    width: double.maxFinite,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 4.0),
                          blurRadius: 3.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              EmojisUtils().retornaEmojiEmocao(
                                  widget.registro.emotionType!, true),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        EmojisUtils()
                                            .retornaNomeFormatadoEmocao(
                                                widget.registro.emotionType!),
                                        style: const TextStyle(
                                            fontSize: 21,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: 'Pangram')),
                                    Text(
                                        DateFormat().add_Hm().format(
                                            widget.registro.dataHoraCriacao!),
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.deepPurpleAccent,
                                            fontFamily: 'Pangram',
                                            fontWeight: FontWeight.normal)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: SizedBox(
                              width: double.maxFinite,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 300.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(10),
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 5, 0, 0),
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  style: const TextStyle(
                    fontFamily: 'Pangram',
                    fontSize: 16,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                    const TextSpan(
                        text: 'Motivos: ',
                        style: TextStyle(fontFamily: 'Pangram')),
                    if (widget.registro.tags != null &&
                        widget.registro.tags!.isNotEmpty)
                      ...widget.registro.tags!
                          .map((tag) => TextSpan(
                                text:
                                    '$tag${widget.registro.tags!.last != tag ? ', ' : ''}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Pangram',
                                ),
                              ))
                          .toList(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Notas do registro',
                    style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'Pangram',
                        fontWeight: FontWeight.bold),
                  ),
                  EmojisUtils().retornaEmojiClima(WEATHER_TYPE.LIMPO)
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 0),
              child: Container(
                width: double.maxFinite,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(18)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 4.0),
                      blurRadius: 3.0,
                    ),
                  ],
                ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(widget.registro.text!, style: TextStyle(fontFamily: 'Pangram', fontWeight: FontWeight.w500),),
                  )),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: const Text("Comentários", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Pangram'),),
            )
          ],
        ),
      ),
    );
  }
}
