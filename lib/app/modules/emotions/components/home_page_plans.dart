import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:gap/gap.dart';

import '../../ui/daily_text.dart';

class HomePagePlans extends StatefulWidget {
  const HomePagePlans({super.key});

  @override
  State<HomePagePlans> createState() => _HomePagePlansState();
}

class _HomePagePlansState extends State<HomePagePlans> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DailyText.text("Planos para hoje (1/3)").header.small.bold,
          const Gap(15),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Column(
               mainAxisAlignment: MainAxisAlignment.start,
               children: [
                 const Dash(
                     direction: Axis.vertical,
                     length: 52,
                     dashLength: 20,
                     dashColor:Color.fromRGBO(158, 181, 103, 1)),
                 Container(
                   margin: const EdgeInsets.only(top: 4,bottom: 4),
                   height: 16,
                   width: 16,
                   decoration: BoxDecoration(
                       color: Color.fromRGBO(158, 181, 103, 1),
                       shape: BoxShape.circle,
                       border:
                       Border.all(width: 1.5, color: const Color.fromRGBO(158, 181, 103, 1))),
                 ),
                 const Dash(
                     direction: Axis.vertical,
                     length: 100,
                     dashLength: 20,
                     dashColor:Color.fromRGBO(158, 181, 103, 1)),
                 Container(
                   margin: const EdgeInsets.only(top: 4,bottom: 4),
                   height: 16,
                   width: 16,
                   decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       border:
                       Border.all(width: 1.5, color: const Color.fromRGBO(158, 181, 103, 1))),
                 ),
                 const Dash(
                     direction: Axis.vertical,
                     length: 100,
                     dashLength: 20,
                     dashColor:Color.fromRGBO(158, 181, 103, 1)),
                 Container(
                   margin: const EdgeInsets.only(top: 4,bottom: 4),
                   height: 16,
                   width: 16,
                   decoration: BoxDecoration(
                       shape: BoxShape.circle,
                       border:
                       Border.all(width: 1.5, color: const Color.fromRGBO(158, 181, 103, 1))),
                 ),
               ],
             ),
             Column(
               children: [
                 Container(
                   width: 305,
                   height: 107,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(8),
                     color: Colors.white,
                   ),
                   child: Padding(
                     padding: const EdgeInsets.all(10.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Column(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             const Text("Meditação", style: TextStyle(fontFamily: 'Pangram' ,fontSize: 15, color: Color.fromRGBO(158, 181, 103, 1) ),),
                             const Text ("Hora de meditar!", style: TextStyle(fontFamily: 'Pangram' ,fontSize: 19, fontWeight: FontWeight.bold)),
                             const Text("5 min", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200))
                           ],
                         ),
                         Image.asset("assets/article_illustration3.png")
                       ],
                     ),
                   ),
                 ),
                 const Gap(25),
                 Container(
                   width: 305,
                   height: 107,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(8),
                     color: Colors.white,
                   ),
                   child: Padding(
                     padding: const EdgeInsets.all(10.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Column(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             const Text("Registro", style: TextStyle(fontFamily: 'Pangram' ,fontSize: 15, color: Color.fromRGBO(158, 181, 103, 1) ),),
                             const Text ("Faça um registro diário!", style: TextStyle(fontFamily: 'Pangram' ,fontSize: 17.2, fontWeight: FontWeight.bold)),
                             const Text("2 min", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200))
                           ],
                         ),
                         Image.asset("assets/registro_concluido.png")
                       ],
                     ),
                   ),
                 ),
                 const Gap(25),
                 Container(
                   width: 305,
                   height: 107,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(8),
                     color: Colors.white,
                   ),
                   child: Padding(
                     padding: const EdgeInsets.all(10.0),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Column(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             const Text("Metas", style: TextStyle(fontFamily: 'Pangram' ,fontSize: 15, color: Color.fromRGBO(158, 181, 103, 1) ),),
                             const Text ("Conclua uma meta", style: TextStyle(fontFamily: 'Pangram' ,fontSize: 19, fontWeight: FontWeight.bold)),
                             const Text("2-5 min", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w200))
                           ],
                         ),
                         Image.asset("assets/meta_concluida.png")
                       ],
                     ),
                   ),
                 ),
               ],
             )
           ],
         )
        ],
      ),
    );
  }
}
