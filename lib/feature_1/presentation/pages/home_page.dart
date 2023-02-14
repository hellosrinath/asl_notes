import 'package:asl_notes/app_constant.dart';
import 'package:asl_notes/feature_1/presentation/cubit/auth/auth_cubit.dart';
import 'package:asl_notes/feature_1/presentation/cubit/note/note_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  final String uid;

  const HomePage({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    BlocProvider.of<NoteCubit>(context).getNotes(uid: widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Notes",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              BlocProvider.of<AuthCubit>(context).loggedOut();
            },
            icon:const Icon(Icons.exit_to_app),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, PageConst.addNotePage,
              arguments: widget.uid);
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<NoteCubit, NoteState>(
        builder: (context, noteState) {
          if (noteState is NoteLoaded) {
            return _bodyWidget(noteState);
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget _noNotesWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: SizedBox(
            height: 80,
            child: Image.asset("assets/notebook.png"),
          ),
        ),
        const SizedBox(height: 10),
        const Text("No notes here yet"),
      ],
    );
  }

  Widget _bodyWidget(NoteLoaded noteLoadedState) {
    return Column(
      children: [
        Expanded(
          child: noteLoadedState.notes.isEmpty
              ? _noNotesWidget()
              : GridView.builder(
                  itemCount: noteLoadedState.notes.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.2,
                  ),
                  itemBuilder: (_, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          PageConst.updateNotePage,
                          arguments: noteLoadedState.notes[index],
                        );
                      },
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Delete Note"),
                              content: const Text(
                                  "Are you sure you want to delete this"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    BlocProvider.of<NoteCubit>(context)
                                        .deleteNote(
                                      note: noteLoadedState.notes[index],
                                    );
                                    Navigator.pop(context);
                                  },
                                  child: const Text("Delete"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text("No"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 2,
                                spreadRadius: 2,
                                offset: const Offset(0, 1.5),
                              ),
                            ]),
                        padding: const EdgeInsets.all(10),
                        margin: const EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${noteLoadedState.notes[index].note}",
                              maxLines: 6,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(DateFormat("dd MMM yyy hh:mm a").format(
                                noteLoadedState.notes[index].time!.toDate())),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
