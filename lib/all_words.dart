import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:randomic/bloc/get_word_bloc.dart';
import 'package:randomic/dialogs.dart';
import 'package:randomic/edit_word.dart';

class AllWordsScreen extends StatefulWidget {
  const AllWordsScreen({super.key});

  @override
  State<AllWordsScreen> createState() => _AllWordsScreenState();
}

class _AllWordsScreenState extends State<AllWordsScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetWordBloc>(context).add(GetAllEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("English",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 19)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("O`zbek",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 19)),
                ),
              ],
            ),
          ),
          BlocBuilder<GetWordBloc, GetWordState>(
            builder: (context, state) {
              if (state is GetAllState) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.allW.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return EditWordScreen(word: state.allW[index]);
                              },
                            ));
                          },
                          child: Container(
                            color: Colors.transparent,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: const BorderSide(),
                                        left: const BorderSide(),
                                        right: const BorderSide(),
                                        bottom: BorderSide(
                                          width: state.allW.length == index + 1
                                              ? 1
                                              : 0,
                                        ),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        state.allW[index].nameEn ?? "",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border(
                                        top: const BorderSide(),
                                        right: const BorderSide(),
                                        bottom: BorderSide(
                                          width: state.allW.length == index + 1
                                              ? 1
                                              : 0,
                                        ),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        state.allW[index].nameUz ?? "",
                                        style: GoogleFonts.poppins(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              } else {
                return const Text("");
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 7, 67, 116),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return const ClearDialog();
              },
            );
          },
          child: Image.asset(
            "assets/images/delete.png",
            color: Colors.white,
            scale: 2.5,
          )),
    );
  }
}
