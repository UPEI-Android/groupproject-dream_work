import 'package:equatable/equatable.dart';
import '../team/team.dart';

class Individual extends Equatable{
  late final Map<Team, List<Responsibilities>> _acceptedResponsibilities;
  late final Map<Team, List<Responsibilities>> _notAcceptedResponsibilities;
  late final List<Team> _teams;
  final String _name;
  final String _id;

  Individual(this._id, this._name){
    _acceptedResponsibilities = {};
    _notAcceptedResponsibilities = {};
    _teams = List.empty(growable: true);
  }
  String getId() => _id;
  String getName() => _name;
  Map<Team, List<Responsibilities>> getAllAcceptedResponsibilities() => _acceptedResponsibilities;
  List<Responsibilities>? getAcceptedResponsibilities(Team team) => _acceptedResponsibilities[team];
  Map<Team, List<Responsibilities>> getAllNotAcceptedResponsibilities() => _notAcceptedResponsibilities;
  List<Responsibilities>? getNotAcceptedResponsibilities(Team team) => _notAcceptedResponsibilities[team];
  List<Team> getTeams() => _teams;

  void joinTeam(Team team){
    _teams.add(team);
    _acceptedResponsibilities.putIfAbsent(team, () => List.empty(growable: true));
    _notAcceptedResponsibilities.putIfAbsent(team, () => List.empty(growable: true));
  }
  void leaveTeam(Team team) {
    if(_teams.contains(team)){
      _teams.remove(team);
      _acceptedResponsibilities.remove(team);
      _notAcceptedResponsibilities.remove(team);
    }
  }
  void acceptResponsibility(Team team, Responsibility res){
    if(_teams.contains(team) && _notAcceptedResponsibilities[team]!.contains(res)){
      _acceptedResponsibilities[team]?.add(res);
      _notAcceptedResponsibilities[team]?.remove(res);
      team.responsibilityAccepted(this, res);
    }
  }

  void addResponsibility(Team team, Responsibility responsibility){
    if(_teams.contains(team)){
      _notAcceptedResponsibilities[team]?.add(responsibility);
    }
  }

  @override
  List<Object?> get props => [_id, _name];

  //Equatable library convert this object to a string
  @override
  bool get stringify => true;
}

