part of 'getvocabluary_bloc.dart';

sealed class GetvocabluaryState {}

final class GetvocabluaryInitial extends GetvocabluaryState {}

class SuccesFirebaseData extends GetvocabluaryState {
  final List<List<VocabluaryModel>> data;
  SuccesFirebaseData({required this.data});
}
