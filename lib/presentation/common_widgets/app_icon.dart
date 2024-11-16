import 'package:flutter/material.dart';

import '../../core/extensions/all.dart';
import '../resource/resource.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    required this.icon,
    super.key,
    this.color,
    this.backgroundColor,
    this.size = Sizes.s24,
    this.padding,
    this.onTap,
    this.isCircle = false,
  });

  final Object icon;
  final Color? color;
  final Color? backgroundColor;
  final double? size;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    Widget? iconWidget;

    final iconColor = color ?? Colors.black;
    if (icon is IconData) {
      iconWidget = Icon(
        icon as IconData,
        color: iconColor,
        size: size,
      );
    } else if (icon is SvgGenImage) {
      iconWidget = (icon as SvgGenImage).svg(
        width: size,
        height: size,
        colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      );
    } else if (icon is AssetGenImage) {
      iconWidget = (icon as AssetGenImage).image(
        width: size,
        height: size,
      );
    } else if (icon is Widget) {
      iconWidget = icon as Widget;
    }

    iconWidget = Padding(
      padding: padding ?? EdgeInsets.zero,
      child: iconWidget,
    );

    if (isCircle) {
      iconWidget = Container(
        padding: padding ?? const EdgeInsets.all(Sizes.s4),
        decoration: BoxDecoration(
          color: backgroundColor,
          shape: BoxShape.circle,
        ),
        child: Center(child: iconWidget),
      );
    } else if (backgroundColor != null) {
      iconWidget = DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
        ),
        child: Center(child: iconWidget),
      );
    }

    if (onTap != null) {
      return iconWidget.clickable(onTap!);
    }

    return iconWidget;
  }
}

class AppIcons {
  const AppIcons._();

  static SvgGenImage arrowLeft = Assets.icons.arrowLeft;
  static SvgGenImage arrowRight = Assets.icons.arrowRight;
  static SvgGenImage close = Assets.icons.close;
  static SvgGenImage homeRegular = Assets.icons.houseRegular;
  static SvgGenImage menuRegular = Assets.icons.barsRegular;
  static SvgGenImage send = Assets.icons.send;
  static SvgGenImage emoji = Assets.icons.faceSmile;
  static SvgGenImage eyeOpen = Assets.icons.eyeOpen;
  static SvgGenImage eyeClose = Assets.icons.eyeClose;
  // static SvgGenImage logout = Assets.icons.logout;
  static SvgGenImage user = Assets.icons.userDefault;
  static SvgGenImage success = Assets.icons.success;
  static SvgGenImage checkBlur = Assets.icons.checkBlur;
  // static SvgGenImage chat = Assets.icons.chat;
  static SvgGenImage search = Assets.icons.searchLine;
  static SvgGenImage edit = Assets.icons.edit;
  static SvgGenImage news = Assets.icons.newsfeed;
  // static SvgGenImage call = Assets.icons.endCallBroken;
  static SvgGenImage mintCoin = Assets.icons.mintCoin;
  static SvgGenImage promotion = Assets.icons.promotion;
  static SvgGenImage addTab = Assets.icons.addTab;
  static SvgGenImage setting = Assets.icons.setting;
  static SvgGenImage editLight = Assets.icons.editLight;
  static SvgGenImage avatarUserDefault = Assets.icons.userDefault;
  static SvgGenImage bell = Assets.icons.bell;
  static SvgGenImage assistant = Assets.icons.assistant;
  static SvgGenImage cameraChange = Assets.icons.camera;
  static SvgGenImage circleTick = Assets.icons.circleTick;
  static SvgGenImage networkPolicy = Assets.icons.networkPolicy;
  static SvgGenImage uiconsDocument = Assets.icons.uiconsDocument;
  static SvgGenImage personDelete = Assets.icons.personDelete;
  static SvgGenImage infoOutline = Assets.icons.infoOutline;

  static SvgGenImage camera = Assets.icons.solarCameraBroken;
  static SvgGenImage gallery = Assets.icons.galleryBroken;
  // static SvgGenImage microphone = Assets.icons.voice;
  static SvgGenImage document = Assets.icons.uiconsDocument;

  static SvgGenImage deleteAudio = Assets.icons.deleteAudio;
  static SvgGenImage pauseAudio = Assets.icons.pauseAudio;
  static SvgGenImage playAudio = Assets.icons.playAudio;

  static SvgGenImage history = Assets.icons.history;
  static SvgGenImage contacts = Assets.icons.contacts;
  static SvgGenImage keyboard = Assets.icons.keyboard;
  static SvgGenImage phoneOut = Assets.icons.phoneOut;
  static SvgGenImage phoneIn = Assets.icons.phoneIn;
  static SvgGenImage phoneMissed = Assets.icons.phoneMissed;
  static SvgGenImage callBroken = Assets.icons.endCallBroken;
  static SvgGenImage video = Assets.icons.video;
  static SvgGenImage phoneVoice = Assets.icons.phoneVoice;
  static SvgGenImage group = Assets.icons.group;
  static SvgGenImage asterisk = Assets.icons.asterisk;
  static SvgGenImage number = Assets.icons.number;
  static SvgGenImage callFill = Assets.icons.callFill;
  static SvgGenImage changeAccount = Assets.icons.changeAccount;
  static SvgGenImage info = Assets.icons.info;
  static SvgGenImage addContact = Assets.icons.addContact;

  static SvgGenImage media = Assets.icons.mediaOutline;
  static SvgGenImage delete = Assets.icons.delete;
  static SvgGenImage internet = Assets.icons.internet;
  static SvgGenImage videoPost = Assets.icons.videoPost;
  static SvgGenImage react = Assets.icons.heartBroken;
  static SvgGenImage reacted = Assets.icons.reacted;
  static SvgGenImage comment = Assets.icons.comment;
  static SvgGenImage share = Assets.icons.share;
  static SvgGenImage image = Assets.icons.image;
  static SvgGenImage more = Assets.icons.more;
  static SvgGenImage report = Assets.icons.report;

  // static IconData link = Icons.link_rounded;
  static IconData copy = Icons.copy_rounded;
  static IconData block = Icons.block_rounded;

  static AssetGenImage like = Assets.images.like;
  static AssetGenImage love = Assets.images.love;
  static AssetGenImage haha = Assets.images.haha;
  static AssetGenImage wow = Assets.images.wow;
  static AssetGenImage sad = Assets.images.sad;
  static AssetGenImage angry = Assets.images.angry;
  static AssetGenImage ggLogo = Assets.icons.ggLogo;
  static AssetGenImage appleLogo = Assets.images.appleLogo;

  static SvgGenImage sticker = Assets.icons.sticker;
  static SvgGenImage alertIcon = Assets.icons.alertIcon;
  static SvgGenImage checkBroken = Assets.icons.checkBroken;
  static SvgGenImage checkDone = Assets.icons.checkDone;
  static SvgGenImage eyeOn = Assets.icons.eyeOn;
  static SvgGenImage eyeOff = Assets.icons.eyeOff;
  static SvgGenImage lock = Assets.icons.lock;
  static SvgGenImage searchLg = Assets.icons.searchLg;
  static SvgGenImage xClose = Assets.icons.xClose;
  static SvgGenImage refresh = Assets.icons.refresh;
  static SvgGenImage create = Assets.icons.create;
  static SvgGenImage addMember = Assets.icons.addMember;
  static SvgGenImage mute = Assets.icons.mute;
  static SvgGenImage settingIcon = Assets.icons.settingIcon;
  static SvgGenImage leave = Assets.icons.leave;
  static SvgGenImage phoneCall = Assets.icons.phoneCall;

  static SvgGenImage message = Assets.icons.message;
  static SvgGenImage blockCall = Assets.icons.block;

  static AssetGenImage avatarDefault = Assets.images.userDefault;
  static SvgGenImage arrowUp = Assets.icons.arrowUp;
  static SvgGenImage gameIcon = Assets.icons.gameIcon;
  static SvgGenImage miningIcon = Assets.icons.miningIcon;
  // static SvgGenImage policy = Assets.icons.policy;
  static SvgGenImage shopIcon = Assets.icons.shopIcon;
  static SvgGenImage support = Assets.icons.support;
  static SvgGenImage videoIcon = Assets.icons.videoIcon;
  static SvgGenImage walletIcon = Assets.icons.walletIcon;
  static SvgGenImage match = Assets.icons.match;
  static SvgGenImage live = Assets.icons.lives;
  static SvgGenImage hugeiconsMore = Assets.icons.hugeiconsMore;
  static SvgGenImage shareContact = Assets.icons.shareContact;
  // static SvgGenImage language = Assets.icons.language;
  static SvgGenImage clearMessage = Assets.icons.clearMessage;
  static SvgGenImage createPost = Assets.icons.createPost;
  static SvgGenImage plus = Assets.icons.plus;
  static SvgGenImage muteChatDashboard = Assets.icons.muteChatDashboard;
  static SvgGenImage removeChatDashboard = Assets.icons.removeChatDashboard;
  static SvgGenImage home = Assets.icons.home;
  static SvgGenImage zoom = Assets.icons.zoom;
  static SvgGenImage chat = Assets.icons.chat;
  static SvgGenImage call = Assets.icons.call;
  static SvgGenImage lms = Assets.icons.lms;
  static SvgGenImage microphone = Assets.icons.microphone;
  static SvgGenImage book = Assets.icons.book;
  static SvgGenImage blockchain = Assets.icons.blockchain;
  static SvgGenImage business = Assets.icons.business;
  static SvgGenImage language = Assets.icons.language;
  static SvgGenImage work = Assets.icons.work;
  static SvgGenImage student = Assets.icons.student;
  static AssetGenImage starFull = Assets.icons.starFull;
  static SvgGenImage idSolid = Assets.icons.idSolid;
  static SvgGenImage mail = Assets.icons.mail;
  static SvgGenImage link = Assets.icons.link;
  static SvgGenImage languageProfile = Assets.icons.languageProfile;
  static SvgGenImage notification = Assets.icons.notification;
  static SvgGenImage policy = Assets.icons.policy;
  static AssetGenImage metamaskPng = Assets.icons.metamaskPng;
  static SvgGenImage webpack = Assets.icons.webpack;
  static SvgGenImage trash = Assets.icons.trash;
  static SvgGenImage logout = Assets.icons.logout;
  static SvgGenImage profile = Assets.icons.profile;
  static SvgGenImage lessonTime = Assets.icons.lessonTime;
  static SvgGenImage notes = Assets.icons.notes;
  static SvgGenImage schedule = Assets.icons.schedule;
  static AssetGenImage addNote = Assets.icons.addNote;

  static SvgGenImage reply = Assets.icons.reply;
  static SvgGenImage forward = Assets.icons.forward;
  static SvgGenImage pin = Assets.icons.pin;
  static SvgGenImage unpin = Assets.icons.unpin;
  static SvgGenImage reportMessage = Assets.icons.reportMessage;
  static SvgGenImage trashMessage = Assets.icons.trashMessage;
  static SvgGenImage downloadMessage = Assets.icons.downloadMessage;
}
