import 'dart:core';
import 'package:equatable/equatable.dart';

class Individual extends Equatable{
  late final Map<Team, List<Responsibilities>> _responsibilities;
  late final List<Team> _teams = [];
  final String _name;
  final String _id;

  Individual(this._id, this._name){
    _responsibilities = {};
    _teams = List.empty(growable: true);
  }
  String getId() => _id;
  String getName() => _name;
  Map<Team, List<Responsibilities>> getAllResponsibilities() => _responsibilities;
  List<Responsibilities>? getResponsibilities(Team team) => _responsibilities[team];
  List<Teams> getTeams() => _teams;

  void joinTeam(Team team){
    _teams.add(team);
    _responsibilities.putIfAbsent(team, () => List.empty(growable: true));
  }
  void leaveTeam(Team team) {
    if(_teams.contains(team)){
      _teams.remove(team);
      _responsibilities.remove(team);
    }
  }
  void acceptResponsibility(Team team, Responsibility res){
    if(_teams.contains(team)){
      _responsibilities[team]?.add(res);
    }
  }

  @override
  List<Object?> get props => [_id, _name];

  //Equatable library convert this object to a string
  @override
  bool get stringify => true;
}

