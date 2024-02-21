import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:randomic/bloc/vocabluary/getvocabluary_bloc.dart';
import 'package:randomic/models/words_model/word.dart';
import 'package:randomic/services/isar_service.dart';

class EssetianalPage extends StatefulWidget {
  const EssetianalPage({super.key});
  @override
  State<EssetianalPage> createState() => _EssetianalPageState();
}

class _EssetianalPageState extends State<EssetianalPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetvocabluaryBloc>(context).add(FirebaseDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<GetvocabluaryBloc, GetvocabluaryState>(
          builder: (context, state) {
            if (state is SuccesFirebaseData) {
              return SingleChildScrollView(
                child: ExpansionTile(
                  title: const Text('Essetianal book'),
                  children: state.data.map((e) {
                    return ExpansionTile(
                      title: const Text('Unit1'),
                      children: [
                        ListView.builder(
                          itemCount: e.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 120,
                                      child: Text(
                                        e[index].eng,
                                        style: TextStyle(
                                            color: Colors.blue.shade700,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 120,
                                      child: Text(
                                        e[index].uz,
                                        style: TextStyle(
                                            color: Colors.red.shade700,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                        IconButton(
                            onPressed: () async {
                              e.forEach((element) {
                                Words wd = Words(
                                    nameEn: element.eng, nameUz: element.uz);

                                IsarService().save(wd);
                              });
                            },
                            icon: const Icon(Icons.save_alt_outlined))
                      ],
                    );
                  }).toList(),
                ),
              );
            } else {
              return const Text('error');
            }
          },
        ),
      ),
    );
  }
}
