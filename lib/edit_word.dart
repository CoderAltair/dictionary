import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:randomic/bloc/get_word_bloc.dart';
import 'package:randomic/models/words_model/word.dart';
import 'package:randomic/services/isar_service.dart';

class EditWordScreen extends StatefulWidget {
  final Words word;
  const EditWordScreen({super.key, required this.word});

  @override
  State<EditWordScreen> createState() => _EditWordScreenState();
}

class _EditWordScreenState extends State<EditWordScreen> {
  TextEditingController enController = TextEditingController();
  TextEditingController uzController = TextEditingController();
  @override
  void initState() {
    super.initState();
    enController.text = widget.word.nameEn ?? "";
    uzController.text = widget.word.nameUz ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 7, 67, 116),
        title: Center(
          child: Text("Translator",
              style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20)),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 7, 67, 116),
          onPressed: () async {
            await IsarService().remove(widget.word.id).then((value) {
              BlocProvider.of<GetWordBloc>(context).add(GetAllEvent());
              Navigator.pop(context);
            });
          },
          child: Image.asset(
            "assets/images/delete.png",
            color: Colors.white,
            scale: 2.5,
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Edit word",
              style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 25)),
          const SizedBox(
            height: 50,
          ),
          addWordField(),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 7, 67, 116),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5), // <-- Radius
                      ),
                    ),
                    onPressed: () async {
                      await IsarService().remove(widget.word.id).then((value) {
                        Words newWord = Words()
                          ..id = widget.word.id
                          ..nameEn = enController.text
                          ..nameUz = uzController.text;

                        IsarService().save(newWord).then((value) {
                          BlocProvider.of<GetWordBloc>(context)
                              .add(GetAllEvent());
                          Navigator.pop(context);
                        });
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: Text(
                        "Save",
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 18),
                      ),
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget addWordField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              cursorColor: Colors.teal,
              controller: enController,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                labelStyle: TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                      width: 1, color: Color.fromARGB(255, 7, 67, 116)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 7, 67, 116), width: 1.0),
                ),
                hintText: 'Enter text',
                labelText: 'En',
                hintStyle: TextStyle(fontSize: 12),
                prefixText: '',
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: TextField(
              cursorColor: Colors.teal,
              controller: uzController,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                labelStyle: TextStyle(color: Colors.black),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(
                      width: 1, color: Color.fromARGB(255, 7, 67, 116)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color.fromARGB(255, 7, 67, 116), width: 1.0),
                ),
                hintText: 'Matn kiriting',
                labelText: 'Uz',
                hintStyle: TextStyle(fontSize: 12),
                prefixText: '',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
