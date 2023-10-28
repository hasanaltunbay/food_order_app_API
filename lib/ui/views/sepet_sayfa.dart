import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis_uygulamasi/data/entity/sepet_yemekler.dart';
import 'package:yemek_siparis_uygulamasi/data/entity/yemekler.dart';
import 'package:yemek_siparis_uygulamasi/ui/cubit/anasayfa_cubit.dart';
import 'package:yemek_siparis_uygulamasi/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:yemek_siparis_uygulamasi/ui/views/anasayfa.dart';



class SepetSayfa extends StatefulWidget{

  Yemekler yemek;
  int adet;
  String kullanici_adi;


  SepetSayfa({required this.yemek,required this.adet,required this.kullanici_adi});

  @override
  State<SepetSayfa> createState() => _SepetSayfaState();
}


class _SepetSayfaState extends State<SepetSayfa> {

  var tfKisiAdi=TextEditingController();
  var tfKisiTel=TextEditingController();
   num topla=0;


  @override
  void initState(){
    super.initState();
    context.read<SepetSayfaCubit>().sepetYemekler("Hasann");
    topla=topla+int.parse(widget.yemek.yemek_fiyat)*(widget.adet);

  }
  Future<bool> geriDonusTusu(BuildContext context) async{
    Navigator.of(context).popUntil((route) => route.isFirst);
    topla=0;
    return true;
  }

  void butonShowDiolog(){
    showDialog(context: context, builder: (context)=>AlertDialog(
      title: Text("Siparişiniz yola çıkmak üzere hazırlanıyor..."),
      actions: [
        TextButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Anasayfa()));
        },
            child: Text("Anasayfaya Dön")),
      ],

    ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop:()=> geriDonusTusu(context),
      child: Scaffold(
        appBar: AppBar(title: Text("Sepetim"),centerTitle: true,
          backgroundColor: Colors.blue,
          leading: IconButton(onPressed: (){
            topla=0;
            Navigator.of(context).popUntil((route) => route.isFirst);
          },icon: Icon(Icons.clear)),),
        body: BlocBuilder<SepetSayfaCubit,List<SepetYemekler>>(
          builder: (context,sepetYemekListesi){
            if(sepetYemekListesi.isNotEmpty){
              return Column(mainAxisAlignment: MainAxisAlignment.center,
                children: [
            Expanded(
              child: ListView.builder(
              itemCount: sepetYemekListesi.length,
              itemBuilder: (context,indeks){
              var yemek=sepetYemekListesi[indeks];
              topla=topla+(int.parse(sepetYemekListesi[indeks].yemek_fiyat)*int.parse(sepetYemekListesi[indeks].yemek_siparis_adet));
              return Card(
              child: SizedBox(height: 125,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${yemek.yemek_resim_adi}"),
              Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(yemek.yemek_adi,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              Text("Fiyat : ${yemek.yemek_fiyat} ₺",style: TextStyle(fontSize: 17),),
              Text("Adet : ${yemek.yemek_siparis_adet} "),
              //Text("Toplam : ${topla}"),
              ],
              ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: (){
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("${yemek.yemek_adi} silinsin mi?"),
                          action: SnackBarAction(
                            label: "Evet", onPressed: (){
                              context.read<SepetSayfaCubit>().sil(int.parse(yemek.sepet_yemek_id),yemek.kullanici_adi);
                              setState(()
                              {
                                var x=(int.parse(sepetYemekListesi[indeks].yemek_fiyat)*int.parse(sepetYemekListesi[indeks].yemek_siparis_adet));
                                topla=0;
                                topla=topla-x;


                              });
                              print(topla);
                              },
                          ),
                        )
                    );
                    },
              icon: Icon(Icons.delete,color: Colors.blue,size: 35,),
                  ),
                  Text("${(int.parse(yemek.yemek_fiyat)*int.parse(yemek.yemek_siparis_adet))} ₺".toString(),
                  ),
                ],
              ),
              ],
              ),
              ),
              );
              },
              ),
            ),
              Container(height: 120, child: Text("Toplam Ücret: $topla ₺",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
              )
              ),
                ],
              );

            } else
            {
              return Center();
            }
            },
        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat, floatingActionButton: Container(height: 50,
        margin: const EdgeInsets.all(10), child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        onPressed: butonShowDiolog,
            child: const Center(
              child: Text('SEPETİ ONAYLA',style: TextStyle(fontSize: 20,color: Colors.white),),
            ),
          ),
        ),

      ),
    );
  }
}
