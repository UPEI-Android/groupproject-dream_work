import 'package:dream_work/individual/individual.dart';
import 'package:equatable/equatable.dart';

class Team extends Equatable{
  late final Map<Individual, List<Responsibilities>> _acceptedResponsibilities;
  late final Map<Individual, List<Responsibilities>> _notAcceptedResponsibilities;
  late final List<Individual> _members;
  final Individual _admin;
  final String _name;
  final String _id;

  Team(this._id, this._name, this._admin){
    _acceptedResponsibilities = {};
    _notAcceptedResponsibilities = {};
    _members = List.empty(growable: true);
  }
  String getId() => _id;
  String getName() => _name;
  Individual getAdmin() => _admin;
  Map<Individual, List<Responsibilities>> getAllAcceptedResponsibilities() => _acceptedResponsibilities;
  List<Responsibilities>? getAcceptedResponsibilities(Individual individual) => _acceptedResponsibilities[individual;
  Map<Individual, List<Responsibilities>> getAllNotAcceptedResponsibilities() => _notAcceptedResponsibilities;
  List<Responsibilities>? getNotAcceptedResponsibilities(Individual individual) => _notAcceptedResponsibilities[individual;
  List<Individual> getMembers() => _members;

  void addMember(Individual individual){
    _members.add(individual);
    _acceptedResponsibilities.putIfAbsent(individual, () => List.empty(growable: true));
    _notAcceptedResponsibilities.putIfAbsent(individual, () => List.empty(growable: true));
  }
  void removeMember(Individual individual) {
    if(_members.contains(individual)){
      _members.remove(individual);
      _acceptedResponsibilities.remove(individual);
      _notAcceptedResponsibilities.remove(individual);
    }
  }
  void addResponsibility(Individual individual, Responsibility res){
    if(_members.contains(individual)){
      _notAcceptedResponsibilities[individual]?.add(res);
      individual.addResponsibility(this, res);
    }
  }
  void responsibilityAccepted(Individual individual, Responsibility res){
    if(_notAcceptedResponsibilities[individual]!.contains(res)){
      _acceptedResponsibilities[individual]?.add(res);
      _notAcceptedResponsibilities[individual]?.remove(res);
    }
  }

  @override
  List<Object?> get props => [_id, _name, _admin];

  //Equatable library convert this object to a string
  @override
  bool get stringify => true;
}

