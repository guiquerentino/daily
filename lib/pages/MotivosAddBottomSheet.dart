import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

import '../entities/Registro.dart';

class MotivosAddBottomSheet extends StatefulWidget {
  final PageController pageController;
  final Registro registro;

  const MotivosAddBottomSheet(
      {Key? key, required this.pageController, required this.registro})
      : super(key: key);

  @override
  State<MotivosAddBottomSheet> createState() => _MotivosAddBottomSheetState();
}

class _MotivosAddBottomSheetState extends State<MotivosAddBottomSheet> {
  final ScrollController _scrollController = ScrollController();
  final _searchController = TextEditingController();
  List<String> _selectedMotivos = [];
  List<String> _filteredMotivos = [];

  List<String> motivos = [
    "Outros",
    "Relacionamento",
    "Familia",
    "Clima",
    "Festa",
    "Hobby",
    "Faculdade",
    "Escola",
    "Dinheiro",
    "Aparência",
    "Amigos",
    "Comida",
    "Sono",
    "Amizades",
    "Medo",
    "Solidão",
    "Arte",
    "Natureza",
    "Responsabilidades",
    "Provas",
    "Doença",
    "Auto-estima",
    "Cônjuge",
    "Filhos",
    "Estudos",
    "Conquista Pessoal",
    "Trabalho",
    "Brigas",
    "Viagem",
    "Música",
    "Exercicio Físico",
    "Realização de Sonho",
    "Voluntariado",
    "Falta de Tempo",
    "Mudanças",
    "Investimentos",
    "Expectativas",
    "Descoberta",
    "Paz de Espírito",
    "Esportes",
    "Barulho",
    "Carreira"
  ];

  @override
  void initState() {
    super.initState();
    _filteredMotivos = motivos;
    _searchController.addListener(_filterMotivos);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterMotivos);
    _searchController.dispose();
    super.dispose();
  }

  void _filterMotivos() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredMotivos = motivos.where((motivo) {
        return motivo.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      heightFactor: 0.9,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.maxFinite,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back_outlined),
                        onPressed: () {
                          widget.pageController.previousPage(
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeOut);
                        },
                      ),
                      const Text(
                        "2/3",
                        style: TextStyle(fontSize: 26, fontFamily: 'Pangram'),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: Colors.black,
                          ),
                        ),
                      )
                    ],
                  ),
                  const Gap(30),
                  const Center(
                    child: Column(
                      children: [
                        Text(
                          "O que te deixou assim?",
                          style: TextStyle(
                              fontFamily: 'Pangram',
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Selecione pelo menos um motivo.",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 3.0,
                          )
                        ],
                      ),
                      child: Row(
                        children: [
                          const Gap(10),
                          const Icon(
                            Iconsax.search_normal_14,
                            size: 20,
                            color: Colors.black,
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              textAlign: TextAlign.left,
                              decoration: const InputDecoration(
                                hintText: "Procurar motivos",
                                hintStyle: TextStyle(color: Colors.grey),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(15),
                  Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10,
                      runSpacing: 10,
                      children: _filteredMotivos.map(
                        (motivo) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedMotivos.contains(motivo)
                                    ? _selectedMotivos.remove(motivo)
                                    : _selectedMotivos.add(motivo);

                                if (_selectedMotivos.length == 1) {
                                  _scrollController.animateTo(
                                      _scrollController.position.extentTotal,
                                      duration: Duration(milliseconds: 600),
                                      curve: Curves.easeIn);
                                }
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: _selectedMotivos.contains(motivo)
                                    ? Colors.black87
                                    : Colors.transparent,
                                border: Border.all(
                                    color: _selectedMotivos.contains(motivo)
                                        ? Colors.white
                                        : Colors.black87),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(25)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  motivo,
                                  style: TextStyle(
                                      color: _selectedMotivos.contains(motivo)
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'Pangram'),
                                ),
                              ),
                            ),
                          );
                        },
                      ).toList()),
                  const Gap(20),
                  if (_selectedMotivos.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FilledButton(
                        autofocus: true,
                        style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.black),
                          fixedSize: MaterialStatePropertyAll(Size(220, 40)),
                        ),
                        onPressed: () {
                          widget.registro.tags = _selectedMotivos;

                          widget.pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                        },
                        child: const Text(
                          "Continuar",
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
