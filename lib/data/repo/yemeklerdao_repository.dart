import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:yemek_siparis_uygulamasi/data/entity/sepet_yemekler.dart';
import 'package:yemek_siparis_uygulamasi/data/entity/sepet_yemekler_cevap.dart';
import 'package:yemek_siparis_uygulamasi/data/entity/yemekler.dart';
import 'package:yemek_siparis_uygulamasi/data/entity/yemekler_cevap.dart';

class YemeklerDaoRepository{

  List<Yemekler> parseYemekler(String cevap){
    return YemeklerCevap.fromJson(json.decode(cevap)).yemekler;
  }

  List<SepetYemekler> parseSepetYemekler(String cevap){
    return SepetYemeklerCevap.fromJson(json.decode(cevap)).sepet_yemekler;
  }


  Future<void> kaydet(String yemek_adi, String  yemek_resim_adi,
      int yemek_fiyat, int yemek_siparis_adet,String kullanici_adi) async{

    var url="http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var veri = {"yemek_adi":yemek_adi,
      "yemek_resim_adi":yemek_resim_adi,
      "yemek_fiyat":yemek_fiyat,
      "yemek_siparis_adet":yemek_siparis_adet,
      "kullanici_adi":kullanici_adi};

    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    print("Yemek Kaydet : ${cevap.data.toString()}");

  }

  Future<List<SepetYemekler>> sepetYemekleriGetir(String kullanici_adi) async{
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var veri = {"kullanici_adi":kullanici_adi};
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    return parseSepetYemekler(cevap.data.toString());
  }

  Future<void> sil(int sepet_yemek_id, String kullanici_adi) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
    var veri = {"sepet_yemek_id":sepet_yemek_id, "kullanici_adi":kullanici_adi};
    var cevap = await Dio().post(url,data: FormData.fromMap(veri));
    print("Yemek Sil : ${cevap.data.toString()}");
  }

  Future<List<Yemekler>> YemekleriYukle() async{
    var url="http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap= await Dio().get(url);
    return parseYemekler(cevap.data.toString());

  }

  Future<List<Yemekler>> Ara(String aramaKelimesi) async {
    var url="http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var cevap= await Dio().get(url);
    var yemekListe= parseYemekler(cevap.data.toString());
    Iterable<Yemekler> filtreleme =yemekListe.where((yemekNesnesi)=>yemekNesnesi.yemek_adi.contains(aramaKelimesi));
    var liste2=filtreleme.toList();

    return liste2;
    }

}