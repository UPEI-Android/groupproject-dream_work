import 'package:equatable/equatable.dart';
import '../responsibility/responsibility.dart';
import '../team/team.dart';

class Individual extends Equatable{
  late final Map<Team, List<Responsibility>> _acceptedResponsibilities;
  late final Map<Team, List<Responsibility>> _notAcceptedResponsibilities;
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
  Map<Team, List<Responsibility>> getAllAcceptedResponsibilities() => _acceptedResponsibilities;
  List<Responsibility>? getAcceptedResponsibilities(Team team) => _acceptedResponsibilities[team];
  Map<Team, List<Responsibility>> getAllNotAcceptedResponsibilities() => _notAcceptedResponsibilities;
  List<Responsibility>? getNotAcceptedResponsibilities(Team team) => _notAcceptedResponsibilities[team];
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

