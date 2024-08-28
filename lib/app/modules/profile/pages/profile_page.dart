import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

import '../../../core/domain/emotion.dart';
import '../../../core/domain/providers/account_provider.dart';
import '../../../core/domain/providers/bottom_navigation_bar_provider.dart';
import '../../../core/utils/emoji_utils.dart';
import '../../emotions/pages/home_page.dart';
import '../../ui/daily_bottom_navigation_bar.dart';
import '../../ui/daily_text.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ImagePicker _picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  TextEditingController? _nameController;
  TextEditingController? _emailController;
  int? _selectedGender;
  bool showSaveButton = false;

  String? _originalName;
  String? _originalEmail;
  int? _originalGender;

  Future<void> _pickImage() async {
    AccountProvider accountProvider =
        Provider.of<AccountProvider>(context, listen: false);

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final Uint8List imageBytes = await image.readAsBytes();
      accountProvider.updateProfilePhoto(
          imageBytes, accountProvider.account!.id!);
    }
  }

  String? emailValidator(String? value) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    if (value == null || value.isEmpty || !emailRegex.hasMatch(value)) {
      return 'Por favor, digite um e-mail válido.';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      final account =
          Provider.of<AccountProvider>(context, listen: false).account;
      if (account != null) {
        setState(() {
          _nameController = TextEditingController(text: account.fullName ?? '');
          _emailController = TextEditingController(text: account.email ?? '');
          _selectedGender = account.gender;

          _originalName = account.fullName;
          _originalEmail = account.email;
          _originalGender = account.gender;
        });
      }
    });
  }

  void _checkForChanges() {
    final currentName = _nameController?.text;
    final currentEmail = _emailController?.text;
    final currentGender = _selectedGender;

    setState(() {
      showSaveButton = currentName != _originalName ||
          currentEmail != _originalEmail ||
          currentGender != _originalGender;
    });
  }

  @override
  Widget build(BuildContext context) {
    final account = Provider.of<AccountProvider>(context, listen: true).account;

    if (_nameController == null || _emailController == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      bottomNavigationBar: const DailyBottomNavigationBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_outlined),
                    onPressed: () {
                      Provider.of<BottomNavigationBarProvider>(context,
                              listen: false)
                          .selectedIndex = 0;
                      Modular.to.navigate('/emotions${HomePage.ROUTE_NAME}');
                    },
                  ),
                  DailyText.text("Meu Perfil").header.medium.bold,
                  Container(),
                  Container(),
                ],
              ),
              const Gap(10),
              Stack(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: account?.profilePhoto == null
                            ? const Color.fromRGBO(158, 181, 103, 1)
                            : Colors.black,
                        shape: BoxShape.circle,
                      ),
                      child: account?.profilePhoto != null
                          ? ClipOval(
                              child: Image.memory(
                                account!.profilePhoto!,
                                fit: BoxFit.cover,
                                width: 100,
                                height: 100,
                              ),
                            )
                          : const Center(
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                    ),
                  ),
                  Positioned(
                    left: 75,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        alignment: Alignment.center,
                        height: 25,
                        width: 25,
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.edit,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(30),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Nome",
                      style: TextStyle(
                          fontFamily: 'Pangram',
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                  const Gap(5),
                  SizedBox(
                    width: double.maxFinite,
                    height: 50,
                    child: TextFormField(
                      controller: _nameController,
                      onChanged: (_) => _checkForChanges(),
                      decoration: const InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Color.fromRGBO(196, 196, 196, 0.20),
                      ),
                    ),
                  ),
                  const Gap(20),
                  const Text("E-mail",
                      style: TextStyle(
                          fontFamily: 'Pangram',
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                  const Gap(5),
                  SizedBox(
                    width: double.maxFinite,
                    height: 50,
                    child: TextFormField(
                      validator: emailValidator, // Add validator here
                      controller: _emailController,
                      onChanged: (_) {
                        _checkForChanges();
                        _formKey.currentState?.validate(); // Trigger validation
                      },
                      decoration: const InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Color.fromRGBO(196, 196, 196, 0.20),
                      ),
                    ),
                  ),
                  const Gap(20),
                  const Text("Gênero",
                      style: TextStyle(
                          fontFamily: 'Pangram',
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                  const Gap(5),
                  SizedBox(
                    width: double.maxFinite,
                    height: 70,
                    child: DropdownButtonFormField<int>(
                      value: _selectedGender,
                      items: const [
                        DropdownMenuItem<int>(
                          value: 0,
                          child: Text("Feminino"),
                        ),
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Text("Masculino"),
                        ),
                        DropdownMenuItem<int>(
                          value: 2,
                          child: Text("Prefiro não informar"),
                        ),
                      ],
                      onChanged: (int? newValue) {
                        setState(() {
                          _selectedGender = newValue;
                          _checkForChanges();
                        });
                      },
                      decoration: const InputDecoration(
                        filled: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide.none,
                        ),
                        fillColor: Color.fromRGBO(196, 196, 196, 0.20),
                      ),
                    ),
                  ),
                  const Gap(230),
                  if (showSaveButton)
                    Center(
                      child: FilledButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            final accountProvider =
                                Provider.of<AccountProvider>(context,
                                    listen: false);
                            accountProvider.updateAccount(
                                account!.id!,
                                _nameController!.text,
                                _emailController!.text,
                                _selectedGender!);

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 80,
                                        height: 80,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.orange.shade200,
                                              Colors.pink.shade100
                                            ],
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                          ),
                                        ),
                                        child: Center(
                                            child: EmojisUtils()
                                                .retornaEmojiEmocao(
                                                    EMOTION_TYPE.MUITO_FELIZ,
                                                    false)),
                                      ),
                                      const SizedBox(height: 20),
                                      const Text(
                                        'Suas informações foram atualizadas com sucesso!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: 'Pangram',
                                            fontSize: 18),
                                      ),
                                      const SizedBox(height: 10),
                                    ],
                                  ),
                                  actions: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Container(
                                          alignment: Alignment.center,
                                          width: double.maxFinite,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            color: const Color.fromRGBO(
                                                158, 181, 103, 1),
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          child: const Text("Continuar",
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontFamily: 'Pangram',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                              textAlign: TextAlign.center)),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        style: const ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(Size(200, 40)),
                          backgroundColor: MaterialStatePropertyAll(
                              Color.fromRGBO(158, 181, 103, 1)),
                        ),
                        child: const Text(
                          "Salvar",
                          style: TextStyle(fontSize: 18, fontFamily: 'Pangram'),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
