import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis_uygulamasi/data/repo/yemeklerdao_repository.dart';


class DetaySayfaCubit extends Cubit<void>{
  DetaySayfaCubit():super(0);

  var yrepo=YemeklerDaoRepository();

  Future<void> kaydet(String yemek_adi, String  yemek_resim_adi, int yemek_fiyat, int yemek_siparis_adet,String kullanici_adi) async{
    await yrepo.kaydet(yemek_adi, yemek_resim_adi, yemek_fiyat, yemek_siparis_adet, kullanici_adi);
  }

}