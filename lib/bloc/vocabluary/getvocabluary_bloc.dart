// ignore_for_file: unused_local_variable, avoid_print, curly_braces_in_flow_control_structures
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomic/models/words_model/vocabluary_model.dart';
part 'getvocabluary_event.dart';
part 'getvocabluary_state.dart';

class GetvocabluaryBloc extends Bloc<GetvocabluaryEvent, GetvocabluaryState> {
  GetvocabluaryBloc() : super(GetvocabluaryInitial()) {
    on<FirebaseDataEvent>(firebaseGet);
  }
  Future<void> firebaseGet(
    FirebaseDataEvent event,
    Emitter<GetvocabluaryState> emit,
  ) async {
    List<VocabluaryModel> vocabluary = [];
    QuerySnapshot<Map<String, dynamic>> data =
        await FirebaseFirestore.instance.collection('users').get();
    int newcounter = 0;
    int oldCounter = 20;
    List<List<VocabluaryModel>> baseUnits = [];
    List<VocabluaryModel> j = [];
    for (var element in data.docs) {
      vocabluary
          .addAll(List<VocabluaryModel>.from(element.data()['data'].map((a) {
        return VocabluaryModel.fromJson(a);
      }).toList()));
    }
    for (int i = 0; i < vocabluary.length; i++) {
      if (i < oldCounter && i >= newcounter) {
        j.add(vocabluary[i]);
      } else {
        baseUnits.add(j);

        j = [];
        newcounter += 20;
        oldCounter += 20;
        j.add(vocabluary[i]);
      }
    }
    emit(SuccesFirebaseData(data: baseUnits));
  }
}
