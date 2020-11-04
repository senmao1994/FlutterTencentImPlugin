import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:tencent_im_plugin/entity/conversation_entity.dart';
import 'package:tencent_im_plugin/entity/error_entity.dart';
import 'package:tencent_im_plugin/entity/friend_application_entity.dart';
import 'package:tencent_im_plugin/entity/friend_info_entity.dart';
import 'package:tencent_im_plugin/entity/group_administrator_op_entity.dart';
import 'package:tencent_im_plugin/entity/group_application_processed_entity.dart';
import 'package:tencent_im_plugin/entity/group_attribute_changed_entity.dart';
import 'package:tencent_im_plugin/entity/group_changed_entity.dart';
import 'package:tencent_im_plugin/entity/group_dismissed_or_recycled_entity.dart';
import 'package:tencent_im_plugin/entity/group_member_changed_entity.dart';
import 'package:tencent_im_plugin/entity/group_member_enter_entity.dart';
import 'package:tencent_im_plugin/entity/group_member_invited_or_kicked_entity.dart';
import 'package:tencent_im_plugin/entity/group_member_leave_entity.dart';
import 'package:tencent_im_plugin/entity/group_receive_join_application_entity.dart';
import 'package:tencent_im_plugin/entity/group_receive_rest_entity.dart';
import 'package:tencent_im_plugin/entity/message_entity.dart';
import 'package:tencent_im_plugin/entity/message_receipt_entity.dart';
import 'package:tencent_im_plugin/entity/signaling_common_entity.dart';
import 'package:tencent_im_plugin/entity/user_entity.dart';
import 'package:tencent_im_plugin/enums/tencent_im_listener_type_enum.dart';
import 'package:tencent_im_plugin/list_util.dart';
import 'package:tencent_im_plugin/utils/enum_util.dart';

/// 监听器对象
class TencentImPluginListener {
  /// 监听器列表
  static Set<TencentImListenerValue> listeners = Set();

  TencentImPluginListener(MethodChannel channel) {
    // 绑定监听器
    channel.setMethodCallHandler((methodCall) async {
      // 解析参数
      Map<String, dynamic> arguments = jsonDecode(methodCall.arguments);

      switch (methodCall.method) {
        case 'onListener':
          // 获得原始类型和参数
          TencentImListenerTypeEnum type = EnumUtil.nameOf(
              TencentImListenerTypeEnum.values, arguments['type']);
          var paramsStr = arguments['params'];

          // 封装回调类型和参数
          var params;

          switch (type) {
            case TencentImListenerTypeEnum.NewMessage:
              params = MessageEntity.fromJson(paramsStr);
              break;
            case TencentImListenerTypeEnum.C2CReadReceipt:
              params = MessageReceiptEntity.fromJson(paramsStr);
              break;
            case TencentImListenerTypeEnum.MessageRevoked:
              break;
            case TencentImListenerTypeEnum.SyncServerStart:
              break;
            case TencentImListenerTypeEnum.SyncServerFinish:
              break;
            case TencentImListenerTypeEnum.SyncServerFailed:
              break;
            case TencentImListenerTypeEnum.NewConversation:
              params = ListUtil.generateOBJList<ConversationEntity>(paramsStr);
              break;
            case TencentImListenerTypeEnum.ConversationChanged:
              params = ListUtil.generateOBJList<ConversationEntity>(paramsStr);
              break;
            case TencentImListenerTypeEnum.FriendApplicationListAdded:
              params =
                  ListUtil.generateOBJList<FriendApplicationEntity>(paramsStr);
              break;
            case TencentImListenerTypeEnum.FriendApplicationListDeleted:
              break;
            case TencentImListenerTypeEnum.FriendApplicationListRead:
              break;
            case TencentImListenerTypeEnum.FriendListAdded:
              params = ListUtil.generateOBJList<FriendInfoEntity>(paramsStr);
              break;
            case TencentImListenerTypeEnum.FriendListDeleted:
              break;
            case TencentImListenerTypeEnum.BlackListAdd:
              params = ListUtil.generateOBJList<FriendInfoEntity>(paramsStr);
              break;
            case TencentImListenerTypeEnum.BlackListDeleted:
              break;
            case TencentImListenerTypeEnum.FriendInfoChanged:
              params = ListUtil.generateOBJList<FriendInfoEntity>(paramsStr);
              break;
            case TencentImListenerTypeEnum.MemberEnter:
              params = GroupMemberEnterEntity.fromJson(paramsStr);
              break;
            case TencentImListenerTypeEnum.MemberLeave:
              params = GroupMemberLeaveEntity.fromJson(paramsStr);
              break;
            case TencentImListenerTypeEnum.MemberInvited:
              params = GroupMemberInvitedOrKickedEntity.fromJson(paramsStr);
              break;
            case TencentImListenerTypeEnum.MemberKicked:
              params = GroupMemberInvitedOrKickedEntity.fromJson(paramsStr);
              break;
            case TencentImListenerTypeEnum.MemberInfoChanged:
              params = GroupMemberChangedEntity.fromJson(paramsStr);
              break;
            case TencentImListenerTypeEnum.GroupCreated:
              break;
            case TencentImListenerTypeEnum.GroupDismissed:
              params = GroupDismissedOrRecycledEntity.fromJson(paramsStr);
              break;
            case TencentImListenerTypeEnum.GroupRecycled:
              params = GroupDismissedOrRecycledEntity.fromJson(paramsStr);
              break;
            case TencentImListenerTypeEnum.GroupInfoChanged:
              params = GroupChangedEntity.fromJson(paramsStr);
              break;
            case TencentImListenerTypeEnum.ReceiveJoinApplication:
              params = GroupReceiveJoinApplicationEntity.fromJson(paramsStr);
              break;
            case TencentImListenerTypeEnum.ApplicationProcessed:
              params = GroupApplicationProcessedEntity.fromJson(paramsStr);
              break;
            case TencentImListenerTypeEnum.GrantAdministrator:
              params = GroupAdministratorOpEntity.fromJson(paramsStr);
              break;
            case TencentImListenerTypeEnum.RevokeAdministrator:
              params = GroupAdministratorOpEntity.fromJson(paramsStr);
              break;
            case TencentImListenerTypeEnum.QuitFromGroup:
              break;
            case TencentImListenerTypeEnum.ReceiveRESTCustomData:
              params = GroupReceiveRESTEntity.fromJson(paramsStr);
              break;
            case TencentImListenerTypeEnum.GroupAttributeChanged:
              params = GroupAttributeChangedEntity.fromJson(paramsStr);
              break;
            case TencentImListenerTypeEnum.Connecting:
              break;
            case TencentImListenerTypeEnum.ConnectSuccess:
              break;
            case TencentImListenerTypeEnum.ConnectFailed:
              params = ErrorEntity.fromJson(paramsStr);
              break;
            case TencentImListenerTypeEnum.KickedOffline:
              break;
            case TencentImListenerTypeEnum.SelfInfoUpdated:
              params = UserEntity.fromJson(paramsStr);
              break;
            case TencentImListenerTypeEnum.UserSigExpired:
              break;
            case TencentImListenerTypeEnum.ReceiveNewInvitation:
              params = SignalingCommonEntity.fromJson(paramsStr);
              break;
            case TencentImListenerTypeEnum.InviteeAccepted:
              params = SignalingCommonEntity.fromJson(paramsStr);
              break;
            case TencentImListenerTypeEnum.InviteeRejected:
              params = SignalingCommonEntity.fromJson(paramsStr);
              break;
            case TencentImListenerTypeEnum.InvitationCancelled:
              params = SignalingCommonEntity.fromJson(paramsStr);
              break;
            case TencentImListenerTypeEnum.InvitationTimeout:
              params = SignalingCommonEntity.fromJson(paramsStr);
              break;
          }

          // 没有找到类型就返回
          if (type == null) {
            throw MissingPluginException();
          }

          // 回调触发
          for (var item in listeners) {
            item(type, params);
          }

          break;
        default:
          throw MissingPluginException();
      }
    });
  }

  /// 添加消息监听
  void addListener(TencentImListenerValue func) {
    listeners.add(func);
  }

  /// 移除消息监听
  void removeListener(TencentImListenerValue func) {
    listeners.remove(func);
  }
}

/// 监听器值模型
typedef TencentImListenerValue<P> = void Function(
    TencentImListenerTypeEnum type, P params);