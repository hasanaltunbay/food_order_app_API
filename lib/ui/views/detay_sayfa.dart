import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis_uygulamasi/ui/cubit/detay_sayfa_cubit.dart';
import 'package:yemek_siparis_uygulamasi/ui/cubit/sepet_sayfa_cubit.dart';
import 'package:yemek_siparis_uygulamasi/ui/views/sepet_sayfa.dart';
import '../../data/entity/yemekler.dart';

class DetaySayfa extends StatefulWidget{

  Yemekler yemek;


  DetaySayfa({required this.yemek});

  @override
  State<DetaySayfa> createState() => _DetaySayfaState();
}

class _DetaySayfaState extends State<DetaySayfa> {var adet=0;var ucret=0;bool isVisible=false;
  @override Widget build(BuildContext context) {return Scaffold(
      appBar: AppBar(title: Text("Ürün Detayı",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),centerTitle: true,
        backgroundColor: Colors.blue,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: Icon(Icons.clear)),),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 50,right: 50),
          child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.network("http://kasimadalan.pe.hu/yemekler/resimler/${widget.yemek.yemek_resim_adi}"),

              Text("${widget.yemek.yemek_adi} ",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
              Text("${widget.yemek.yemek_fiyat} ₺",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(onPressed: (){
                    setState(() {
                      if(adet<1){
                        adet=0;
                        }
                      else{
                        adet=adet-1;
                        if(adet==0){
                          isVisible=false;
                        }else{
                          isVisible=true;
                        }

                      }

                      var fiyat=int.parse(widget.yemek.yemek_fiyat);
                      ucret=fiyat*adet;

                    });
                  }, icon: Icon(Icons.indeterminate_check_box_rounded,size: 40,),color: Colors.blue,),
                  Text(adet.toString(),style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold),),
                  IconButton(onPressed: (){
                      setState(() {
                        adet=adet+1;
                          isVisible=true;
                        var fiyat=int.parse(widget.yemek.yemek_fiyat);
                        ucret=fiyat*adet;

                      });
                  }, icon: Icon(Icons.add_box,size: 40,),color: Colors.blue),

                ],
              ),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("30-35 dk",style: TextStyle(fontSize: 17,backgroundColor: Colors.grey),),
                  Text("Ücretsiz Teslimat",style: TextStyle(fontSize: 17,backgroundColor: Colors.grey),),
                  Text("İndirim %15",style: TextStyle(fontSize: 17,backgroundColor: Colors.grey),),
                ],
              ),

              //Text("Ücret:",style: TextStyle(fontSize: 25),),
              Text("Toplam Ücret: $ucret ₺",style: TextStyle(fontSize: 25),),
              Visibility(visible: isVisible,
                child: ElevatedButton(onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>SepetSayfa(yemek: widget.yemek,adet: adet, kullanici_adi: "Hasann",)));

                    context.read<DetaySayfaCubit>().kaydet(widget.yemek.yemek_adi,
                        widget.yemek.yemek_resim_adi,
                        int.parse(widget.yemek.yemek_fiyat),
                        adet, "Hasann");

                },child: Text("Sepete Ekle",style: TextStyle(fontSize: 20,color: Colors.white),),
                  style: ElevatedButton.styleFrom(minimumSize: Size(250, 50),
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5)))),),
              )

            ],
          ),
        ),
      ),
    );
  }
}
