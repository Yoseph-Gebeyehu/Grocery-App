part of 'transaction_history_bloc.dart';

class TransactionHistoryEvent extends Equatable {
  const TransactionHistoryEvent();

  @override
  List<Object> get props => [];
}

class FetchTransactionHistoryEvent extends TransactionHistoryEvent {}
