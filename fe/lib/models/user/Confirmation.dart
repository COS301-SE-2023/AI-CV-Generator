
import 'package:json_annotation/json_annotation.dart';

part 'Confirmation.g.dart';

@JsonSerializable()
class ConfirmationMsg {
  String msg;

  ConfirmationMsg({
    required this.msg
  });

  factory ConfirmationMsg.fromJSON(Map<String,dynamic> json) => _$ConfirmationMsgFromJson(json);

    Map<String,dynamic> toJson() => _$ConfirmationMsgToJson(this);
}