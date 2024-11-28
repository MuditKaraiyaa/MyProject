part of 'chat_page_bloc.dart';

sealed class ChatPageState extends Equatable {
  const ChatPageState();
  
  @override
  List<Object> get props => [];
}

final class ChatPageInitial extends ChatPageState {}
