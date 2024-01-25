part of 'network_bloc.dart';

class NetworkEvent extends Equatable {
  const NetworkEvent();

  @override
  List<Object> get props => [];
}

class NetworkConnected extends NetworkEvent {}

class NetworkNotConnected extends NetworkEvent {}
