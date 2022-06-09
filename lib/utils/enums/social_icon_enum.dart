import 'package:salesforce_spo/design_system/primitives/social_icon_system.dart';

enum SocialIconEnum {
  phone,
  mail,
  message,
  chat,
  unknown,
}

abstract class SocialIcon {
  static SocialIconEnum getSocialIconFromString(String iconName) {
    switch (iconName) {
      case 'Social Icon':
      case 'Phone':
        return SocialIconEnum.phone;
      case 'Mail':
        return SocialIconEnum.mail;
      case 'Message':
        return SocialIconEnum.message;
      case 'Chat':
        return SocialIconEnum.chat;
      default:
        return SocialIconEnum.unknown;
    }
  }

  static String getSocialIcon(SocialIconEnum socialIconEnum) {
    switch (socialIconEnum) {
      case SocialIconEnum.phone:
        return SocialIconSystem.icPhone;
      case SocialIconEnum.mail:
        return SocialIconSystem.icMail;
      case SocialIconEnum.message:
        return SocialIconSystem.icMessage;
      case SocialIconEnum.chat:
        return SocialIconSystem.icChat;
      case SocialIconEnum.unknown:
        return SocialIconSystem.icPhone;

    }
  }
}
