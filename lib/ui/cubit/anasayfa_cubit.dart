import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemek_siparis_uygulamasi/data/entity/yemekler.dart';
import 'package:yemek_siparis_uygulamasi/data/repo/yemeklerdao_repository.dart';


class AnaSayfaCubit extends Cubit<List<Yemekler>>{
  AnaSayfaCubit():super(<Yemekler>[]);

  var yrepo=YemeklerDaoRepository();

  Future<void> yemekleriYukle() async{
    var liste=await yrepo.YemekleriYukle();
    emit(liste);
  }
  Future<void> ara(String aramaKelimesi) async{
    var liste=await yrepo.Ara(aramaKelimesi);
    emit(liste);
  }



}