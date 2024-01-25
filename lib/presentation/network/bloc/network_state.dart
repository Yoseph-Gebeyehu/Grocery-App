part of 'network_bloc.dart';

class NetworkState extends Equatable {
  const NetworkState();

  @override
  List<Object> get props => [];
}

class NetworkInitial extends NetworkState {}

// ignore: must_be_immutable
class NetworkLoading extends NetworkState {
  bool isLoading = true;
  NetworkLoading(isLoading);
}

class NetworkSuccess extends NetworkState {}

class NetworkFailure extends NetworkState {}
