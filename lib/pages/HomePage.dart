import 'package:daily/components/DailyCalendarHomePage.dart';
import 'package:daily/entities/AccountRequest.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final params = ModalRoute.of(context)?.settings.arguments as AccountRequest;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(245, 245, 245, 1),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Builder(
              builder: (context) {
                return Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                      icon: const Icon(
                        Icons.menu,
                        size: 36,
                        color: Colors.black,
                      ),
                    ),
                    const Gap(3),
                    // const DailyCalendarHomePage(),
                  ],
                );
              },
            ),
            RichText(
              text: TextSpan(
                text: "Olá,",
                style: const TextStyle(color: Colors.black, fontSize: 30),
                children: <TextSpan>[
                  TextSpan(
                    text: " ${params.fullName ?? " usuário"}",
                    style: const TextStyle(color: Color.fromRGBO(0, 70, 195, 1)),
                  )
                ],
              ),
            ),
            const Text("abaixo estão os seus registros de emoções do dia."),
            const Gap(20),
            Container(
              width: double.maxFinite,
              height: 70,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
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
                child: Row(
                  children: [
                    SvgPicture.asset('assets/happy.svg'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).popAndPushNamed("/login");
        },
      ),
      drawer: Drawer(
        child: ListView(
          children:  [

            ListTile(
              title: Text('Item 1'),
              onTap: () {
                // Handle item tap
              },
            ),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Handle item tap
              },
            ),
            ListTile(
              title: Text('Item 3'),
              onTap: () {
                // Handle item tap
              },
            ),
          ],
        ),
      ),
    );
  }
}
