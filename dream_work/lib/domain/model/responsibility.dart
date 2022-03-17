import 'package:dream_work/domain/model/individual.dart';
import 'team.dart';
import 'package:equatable/equatable.dart';

class Responsibility extends Equatable {
  final Individual _assignee;
  final String _title;
  final String? _description;
  final Team _team;
  final DateTime? _dueDate;

  const Responsibility(this._title, this._team, this._assignee,
      [this._dueDate, this._description]);

  String getTitle() => _title;
  Team getTeam() => _team;
  Individual getAssignee() => _assignee;
  DateTime? getDueDate() => _dueDate;
  String? getDescription() => _description;

  @override
  List<Object?> get props => [_title, _team];

  //Equatable library convert this object to a string
  @override
  bool get stringify => true;
}
