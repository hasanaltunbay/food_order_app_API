import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis_uygulamasi/data/entity/yemekler.dart';
import 'package:yemek_siparis_uygulamasi/ui/cubit/anasayfa_cubit.dart';
import 'package:yemek_siparis_uygulamasi/ui/views/detay_sayfa.dart';
import 'package:yemek_siparis_uygulamasi/ui/views/konum_sayfa.dart';


class Anasayfa extends StatefulWidget{
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  bool aramaYapiliyorMu=false;

  @override
  void initState() {
    super.initState();
    context.read<AnaSayfaCubit>().yemekleriYukle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.blue,
      appBar: AppBar(backgroundColor: Colors.blue,
        title: aramaYapiliyorMu ? TextField(decoration: InputDecoration(hintText: "Ara"),
        onChanged: (aramaSonucu){
          context.read<AnaSayfaCubit>().ara(aramaSonucu);
        },) :
        Text("Hoşgeldiniz"),
        actions: [
          aramaYapiliyorMu ?
          IconButton(onPressed: (){
            setState(() {
              aramaYapiliyorMu=false;
            });
            context.read<AnaSayfaCubit>().yemekleriYukle();
          }, icon: Icon(Icons.clear)) :
          IconButton(onPressed: (){
            setState(() {
              aramaYapiliyorMu=true;
            });
          }, icon: Icon(Icons.search)),
          IconButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>KonumSayfa()));
          }, icon: Icon(Icons.home_outlined))
        ],
      ),
      body:BlocBuilder<AnaSayfaCubit,List<Yemekler>>(
        builder: (context,yemeklerListesi){
          if(yemeklerListesi.isNotEmpty){
            return GridView.builder(
              itemCount: yemeklerListesi.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,childAspectRatio: 1 / 1.7
              ),
              itemBuilder: (context,indeks){
                var yemek=yemeklerListesi[indeks];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>DetaySayfa(yemek: yemek)));
                  },
                  child: Card(
                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
                        Text(yemek.yemek_adi,style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold,),),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Icon(Icons.directions_bike_outlined),
                            SizedBox(width: 10,),
                            Text("Hızlı Teslimat"),
                          ],),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text("${yemek.yemek_fiyat} ₺",style: TextStyle(fontSize: 26),),
                              IconButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>DetaySayfa(yemek: yemek)));
                              }, icon: Icon(Icons.add_box),iconSize: 29,color: Colors.blue,),
                            ]
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }else{
            return Center();
          }
        },
      ),

    );

  }
}
