import 'package:demo_app/font_class.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // List<Offset?> position = [];
  // List<String> children = [];
  // List<TextEditingController> controllers = [];
  List<FontClass> texts = [];
  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          height: pageHeight * 0.908,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/wallpaper.jpg"),
              fit: BoxFit.cover
            )
          ),
          child: Stack(
            children: [
              ...texts.asMap().entries.map((e) {
                int index = e.key;
                String val = e.value.val;
                return Positioned(
                  left: e.value.position.dx,
                  top: e.value.position.dy,
                  child: Draggable(
                    data: index,
                    feedback: Text(
                      val,
                      style: Theme.of(context).textTheme.headlineMedium!.apply(
                        color: Colors.white
                      ),
                    ),
                    onDraggableCanceled: (Velocity velocity, Offset offset) {
                      setState(() {
                        e.value.position = offset;
                      });
                    },
                    child: GestureDetector(
                      onTap: () async {
                        FontClass? val1 = await _editText(
                            context, e.value.controller, e.value.position);
                        setState(() {
                          val = val1!.val;
                          e.value.val = val;
                          e.value.fsize = val1.fsize;
                          e.value.color = val1.color;
                          e.value.font = val1.font;
                        });
                      },
                      child: Text(
                        val,
                        style: GoogleFonts.getFont(e.value.font).copyWith(
                          color: e.value.color,
                          fontSize: e.value.fsize,
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: pageHeight*0.17,
                  width: MediaQuery.of(context).size.width * 0.6,
                  padding: const EdgeInsets.all(50.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        texts.add(
                          FontClass(
                              position: const Offset(50.0, 20.0),
                              controller: TextEditingController(
                                  text: "Text Here"),
                              val: "Text Here",
                              font: "Poppins",
                              fsize: 20,
                              color: Colors.white),
                        );
                      });
                    },
                    child: Text("Click to Add Text",
                    style: TextStyle(
                      fontFamily: GoogleFonts.merriweather().fontFamily,
                      fontSize: 17,
                      fontWeight: FontWeight.bold
                    ),),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<FontClass?> _editText(
    BuildContext context,
    TextEditingController ctlr,
    Offset pos,
  ) async {
    FontClass? edited = await showDialog<FontClass>(
      context: context,
      builder: (BuildContext ctx) {
        String font = "Poppins";
        Color col = Colors.white;
        double size = 15;
        return AlertDialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          title: const Text('Edit Text'),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            child: TextFormField(
              controller: ctlr,
              decoration: const InputDecoration(hintText: 'Enter new text'),
            ),
          ),
          actions: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownMenu(
                      hintText: "Select Font",
                      onSelected: (val) {
                        font = val!;
                      },
                      width: MediaQuery.of(context).size.width * 0.38,
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(value: "Roboto", label: "Roboto"),
                        DropdownMenuEntry(value: "Lato", label: "Lato"),
                        DropdownMenuEntry(value: "Inter", label: "Inter"),
                        DropdownMenuEntry(value: "Merriweather", label: "Merriweather"),
                        DropdownMenuEntry(value: "Lora", label: "Lora"),
                      ],
                    ),
                    DropdownMenu(
                      hintText: "Select Color",
                      onSelected: (val) {
                        col = val!;
                      },
                      width: MediaQuery.of(context).size.width * 0.38,
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(value: Colors.red, label: "Red"),
                        DropdownMenuEntry(value: Colors.blue, label: "Blue"),
                        DropdownMenuEntry(value: Colors.green, label: "Green"),
                        DropdownMenuEntry(value: Colors.black, label: "Black"),
                        DropdownMenuEntry(value: Colors.white, label: "White"),
                        DropdownMenuEntry(value: Colors.amber, label: "Amber"),
                        DropdownMenuEntry(value: Colors.indigo, label: "Indigo"),
                        DropdownMenuEntry(value: Colors.lightBlue, label: "Light Blue"),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  decoration: const InputDecoration(label: Text("Font Size")),
                  onChanged: (val) {
                    size = double.parse(val);
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Cancel',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(
                            context,
                            FontClass(
                                position: pos,
                                controller: ctlr,
                                val: ctlr.text,
                                font: font,
                                fsize: size,
                                color: col));
                      },
                      child: Text(
                        'Save',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        );
      },
    );

    if (edited != null) {
      return edited;
    }
    return null;
  }
}
