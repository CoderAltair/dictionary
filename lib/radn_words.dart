import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:randomic/bloc/get_word_bloc.dart';
import 'package:randomic/models/words_model/word.dart';

class RandomWordsScreen extends StatefulWidget {
  const RandomWordsScreen({super.key});

  @override
  State<RandomWordsScreen> createState() => _RandomWordsScreenState();
}

class _RandomWordsScreenState extends State<RandomWordsScreen> {
  int counter = 0;
  String en = '';
  String uz = '';
  bool isShow = false;
  bool isShow2 = true;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<GetWordBloc>(context).add(GetAllEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GetWordBloc, GetWordState>(
        builder: (context, state) {
          if (state is GetAllState) {
            List<Words> randomWords = state.allW;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                Column(
                  children: [
                    isShow2 == true
                        ? Center(
                            child: Text(
                              en,
                              style: GoogleFonts.poppins(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30),
                            ),
                          )
                        : const Text(""),
                    isShow == true
                        ? Center(
                            child: Text(
                              uz,
                              style: GoogleFonts.poppins(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black
                                      : Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 30),
                            ),
                          )
                        : const Text(""),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 7, 67, 116),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () {
                              if (isShow == true) {
                                isShow = false;
                              } else {
                                isShow = true;
                              }
                              setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                "Show Text Uz",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                            )),
                        const SizedBox(
                          width: 15,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 7, 67, 116),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            onPressed: () {
                              if (isShow2 == true) {
                                isShow2 = false;
                              } else {
                                isShow2 = true;
                              }
                              setState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                "Show Text En",
                                style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18),
                              ),
                            )),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 7, 67, 116),
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(50),
                          onTap: () {
                            Words rand = randomWords[
                                Random().nextInt(randomWords.length)];
                            en = rand.nameEn ?? "";
                            uz = rand.nameUz ?? "";
                            counter++;
                            setState(() {});
                          },
                          child: Center(
                            child: Text(
                              counter.toString(),
                              style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 40),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          } else {
            return const Text("");
          }
        },
      ),
    );
  }
}
