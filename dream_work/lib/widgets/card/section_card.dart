import 'package:dream_work/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:dream_work/widgets/widgets.dart';

import '../../screens/screens.dart';

class SectionCard extends StatelessWidget {
  const SectionCard({
    Key? key,
    required this.title,
    this.onTap,
    this.child,
  }) : super(key: key);

  final String title;
  final Widget? child;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    /// Body of the tax
    return GeneralCard(
      height: 75,
      child: _infoBox(),
      onTap: onTap,
    );
  }

  ///---------------------------------------------------------------------------
  /// contains all the info of the tag
  ///---------------------------------------------------------------------------
  Widget _infoBox() {
    final String titleAdj =
        title.length < 13 ? title : title.substring(0, 13) + '...';
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              titleAdj,
              style: const TextStyle(
                color: Colors.white,
              ),
            )),
        child ?? Container(),
      ],
    );
  }
}

class EditableSectionCard extends StatefulWidget {
  const EditableSectionCard({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<EditableSectionCard> createState() => _EditableSectionCardState();
}

class _EditableSectionCardState extends State<EditableSectionCard> {
  final TextEditingController _text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _text.text = widget.title;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: TextField(
          controller: _text,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          style: const TextStyle(color: Colors.white, fontSize: 17),
          decoration: const InputDecoration(
            hintText: 'Enter Section Title',
            hintStyle: TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
          onSubmitted: (value) async {
            final newTitle =
                await editSectionTitle(newTitle: value, oldTitle: widget.title);
            Navigator.pop(context);
            Navigator.pushNamed(
              context,
              IndividualScreen.routeName,
              arguments: newTitle,
            );
          },
        ),
      ),
    );
  }
}
