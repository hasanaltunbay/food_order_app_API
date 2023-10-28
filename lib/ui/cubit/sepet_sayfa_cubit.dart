import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis_uygulamasi/data/entity/sepet_yemekler.dart';
import 'package:yemek_siparis_uygulamasi/data/entity/yemekler.dart';
import 'package:yemek_siparis_uygulamasi/data/repo/yemeklerdao_repository.dart';


class SepetSayfaCubit extends Cubit<List<SepetYemekler>>{
  SepetSayfaCubit():super(<SepetYemekler>[]);

  var yrepo=YemeklerDaoRepository();

  Future<void> sepetYemekler(String kullanici_adi) async{
   var liste=await yrepo.sepetYemekleriGetir(kullanici_adi);
   emit(liste);
  }

  Future<void> sil(int sepet_yemek_id, String kullanici_adi) async {
    await yrepo.sil(sepet_yemek_id, kullanici_adi);
    await sepetYemekler(kullanici_adi);
  }

}