import 'package:flutter/material.dart';
import 'package:dream_work/widgets/widgets.dart';

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

class EditableSectionCard extends StatelessWidget {
  const EditableSectionCard({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: TextField(
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.text,
          style: const TextStyle(color: Colors.white, fontSize: 17),
          onSubmitted: (value) {
            // todo : update the value to the database
            print(value);
          },
          decoration: InputDecoration(
            hintText: title,
            hintStyle: const TextStyle(color: Colors.grey),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
