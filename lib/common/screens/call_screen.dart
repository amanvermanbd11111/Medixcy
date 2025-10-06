import 'package:videocalling_medical/common/utils/app_imports.dart';
import 'package:videocalling_medical/common/utils/video_call_imports.dart';
import 'package:flutter/foundation.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'dart:developer' as dev;
import 'package:web_browser_detect/web_browser_detect.dart';

class ConversationCallScreen extends StatefulWidget {
  final P2PSession _callSession;
  final bool _isIncoming;

  @override
  State<StatefulWidget> createState() {
    return _ConversationCallScreenState(_callSession, _isIncoming);
  }

  ConversationCallScreen(this._callSession, this._isIncoming);
}

class _ConversationCallScreenState extends State<ConversationCallScreen>
    implements RTCSessionStateCallback<P2PSession> {
  static const String TAG = "_ConversationCallScreenState";
  final P2PSession _callSession;
  final bool _isIncoming;
  bool _isCameraEnabled = true;
  bool _isSpeakerEnabled = Platform.isIOS ? false : true;
  bool _isMicMute = false;
  bool _isFrontCameraUsed = true;
  bool isOpponentConnected = false;
  bool _isOpponentConnected1 = false;
  final int _currentUserId = CubeChatConnection.instance.currentUser!.id!;

  // Separate renderers for local and remote
  RTCVideoRenderer? localRenderer;
  RTCVideoRenderer? remoteRenderer;
  int? remoteUserId;

  // Track which video is currently displayed as primary (full screen)
  bool isLocalVideoPrimary = false;

  RTCVideoViewObjectFit primaryVideoFit =
      RTCVideoViewObjectFit.RTCVideoViewObjectFitCover;

  bool _isCalling = true;

  bool _enableScreenSharing;

  _ConversationCallScreenState(this._callSession, this._isIncoming)
      : _enableScreenSharing = !_callSession.startScreenSharing;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer();

  @override
  void initState() {
    super.initState();
    _initAlreadyReceivedStreams();
    _callSession.onLocalStreamReceived = _addLocalMediaStream;
    _callSession.onRemoteStreamReceived = _addRemoteMediaStream;
    _callSession.onSessionClosed = _onSessionClosed;
    _callSession.setSessionCallbacksListener(this);

    if (_isIncoming) {
      if (_callSession.state == RTCSessionState.RTC_SESSION_NEW) {
        _callSession.acceptCall();
      }
    } else {
      _callSession.startCall();
    }

    CallManager.instance.onMicMuted = (muted, sessionId) {
      setState(() {
        _isMicMute = muted;
        _callSession.setMicrophoneMute(_isMicMute);
      });
    };
  }

  @override
  Future<void> dispose() async {
    super.dispose();
    stopBackgroundExecution();

    localRenderer?.srcObject = null;
    localRenderer?.dispose();

    remoteRenderer?.srcObject = null;
    remoteRenderer?.dispose();

    await _stopWatchTimer.dispose();
  }

  Future<void> _addLocalMediaStream(MediaStream stream) async {
    if (localRenderer == null) {
      localRenderer = RTCVideoRenderer();
      await localRenderer!.initialize();
    }

    setState(() {
      localRenderer!.srcObject = stream;
    });
  }

  void _addRemoteMediaStream(session, int userId, MediaStream stream) {
    if (_isCalling) {
      setState(() {
        _isOpponentConnected1 = true;
        _isCalling = false;
      });
    }

    _addRemoteStream(userId, stream);
  }

  Future<void> _addRemoteStream(int userId, MediaStream stream) async {
    if (remoteRenderer == null) {
      remoteRenderer = RTCVideoRenderer();
      await remoteRenderer!.initialize();
    }

    setState(() {
      remoteUserId = userId;
      remoteRenderer!.srcObject = stream;
    });
  }

  Future<void> _removeMediaStream(callSession, int userId) async {
    if (userId == remoteUserId) {
      setState(() {
        remoteRenderer?.srcObject = null;
        remoteUserId = null;
      });
    }
  }

  _onSessionClosed(session) {
    _callSession.removeSessionCallbacksListener();
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        backgroundColor: AppColors.grey,
        body: Stack(
          fit: StackFit.loose,
          clipBehavior: Clip.none,
          children: [
            _isVideoCall()
                ? OrientationBuilder(
              builder: (context, orientation) {
                return _buildVideoCallLayout();
              },
            )
                : Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Text(
                      "audio_call".tr,
                      style: const TextStyle(
                        fontSize: 28,
                        fontFamily: AppFontStyleTextStrings.regular,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      "members".tr,
                      style: const TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        fontFamily: AppFontStyleTextStrings.regular,
                      ),
                    ),
                  ),
                  Text(
                    _callSession.opponentsIds.join(", "),
                    style: const TextStyle(
                      fontSize: 20,
                      fontFamily: AppFontStyleTextStrings.regular,
                    ),
                  ),
                ],
              ),
            ),
            !_isVideoCall()
                ? const SizedBox()
                : AnimatedSwitcher(
              duration: const Duration(milliseconds: 850),
              child: _isCalling
                  ? _isIncoming
                  ? const SizedBox()
                  : Container(
                padding: const EdgeInsets.only(top: 90),
                height: Get.height,
                color: AppColors.BLACK,
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    (StorageService.readData(
                        key: LocalStorageKeys
                            .callReceiverImage) ==
                        AppImages.defaultDoctor ||
                        StorageService.readData(
                            key: LocalStorageKeys
                                .callReceiverImage) ==
                            AppImages.defaultUser)
                        ? (StorageService.readData(
                        key: LocalStorageKeys
                            .callReceiverImage) ??
                        "")
                        .contains("png") ??
                        true
                        ? Image.asset(
                      AppImages.defaultUser,
                      height: 100,
                      width: 100,
                    )
                        : SvgPicture.asset(
                      AppImages.defaultDoctor,
                      height: 100,
                      width: 100,
                    )
                        : Container(
                      height: 100,
                      width: 100,
                      child: ClipOval(
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: StorageService.readData(
                              key: LocalStorageKeys
                                  .callReceiverImage) ??
                              "",
                          placeholder: (context, url) {
                            return (StorageService.readData(
                                key: LocalStorageKeys
                                    .callReceiverImage) ??
                                "")
                                .contains("png") ??
                                true
                                ? Image.asset(
                              AppImages.defaultUser,
                              height: 100,
                              width: 100,
                            )
                                : SvgPicture.asset(
                              AppImages.defaultDoctor,
                              height: 100,
                              width: 100,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    AppTextWidgets.regularText(
                      text:
                      '${StorageService.readData(key: LocalStorageKeys.callReceiverName)}',
                      color: AppColors.WHITE,
                      size: 25,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    AppTextWidgets.regularText(
                      text: 'ringing'.tr,
                      color: AppColors.WHITE,
                      size: 22,
                    ),
                  ],
                ),
              )
                  : Align(
                alignment: Alignment.topCenter,
                child: StreamBuilder<int>(
                  stream: _stopWatchTimer.rawTime,
                  initialData: 0,
                  builder: (context, snap) {
                    final value = snap.data;
                    var houre =
                    StopWatchTimer.getDisplayTimeHours(value!);
                    bool isHouShow = false;
                    if (houre != '00') {
                      isHouShow = true;
                    }
                    final displayTime = StopWatchTimer.getDisplayTime(
                        value,
                        milliSecond: false,
                        hours: isHouShow);
                    return Container(
                      margin: EdgeInsets.only(
                          top: MediaQuery.of(context).padding.top +
                              20),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.BLACK,
                        ),
                        child: AppTextWidgets.mediumText(
                          text: "$displayTime",
                          color: AppColors.WHITE,
                          size: 18,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _getActionsPanel(),
            ),
          ],),
      ),
    );
  }

  Widget _buildVideoCallLayout() {
    return Container(
      child: Stack(children: [
        if (isLocalVideoPrimary ? localRenderer != null : remoteRenderer != null)
          Positioned.fill(
            child: RTCVideoView(
              isLocalVideoPrimary ? localRenderer! : remoteRenderer!,
              objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
              mirror: isLocalVideoPrimary ? (_isFrontCameraUsed && _enableScreenSharing) : false,
            ),
          ),

        if (isLocalVideoPrimary ? remoteRenderer != null : localRenderer != null)
          Positioned(
            bottom: 86, // Above the action buttons
            right: 16,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isLocalVideoPrimary = !isLocalVideoPrimary;
                });
              },
              child: Container(
                width: 100,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: RTCVideoView(
                    isLocalVideoPrimary ? remoteRenderer! : localRenderer!,
                    objectFit: RTCVideoViewObjectFit.RTCVideoViewObjectFitCover,
                    mirror: isLocalVideoPrimary ? false : (_isFrontCameraUsed && _enableScreenSharing),
                  ),
                ),
              ),
            ),
          ),
      ]),
    );
  }

  Widget _getActionsPanel() {
    return Container(
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 8,
          left: MediaQuery.of(context).padding.left + 8,
          right: MediaQuery.of(context).padding.right + 8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(32),
        child: Container(
          padding: const EdgeInsets.all(4),
          color: AppColors.BLACK26,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: FloatingActionButton(
                  elevation: 0,
                  heroTag: "Mute",
                  child: Icon(
                    _isMicMute ? Icons.mic_off : Icons.mic,
                    color: _isMicMute ? AppColors.grey : AppColors.WHITE,
                  ),
                  onPressed: () => _muteMic(),
                  backgroundColor: AppColors.BLACK38,
                ),
              ),
              Visibility(
                visible: _enableScreenSharing,
                child: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: FloatingActionButton(
                    elevation: 0,
                    heroTag: "ToggleCamera",
                    child: Icon(
                      _isVideoEnabled() ? Icons.videocam : Icons.videocam_off,
                      color:
                      _isVideoEnabled() ? AppColors.WHITE : AppColors.grey,
                    ),
                    onPressed: () => _toggleCamera(),
                    backgroundColor: AppColors.BLACK38,
                  ),
                ),
              ),
              Visibility(
                visible: _enableScreenSharing,
                child: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: FloatingActionButton(
                    elevation: 0,
                    heroTag: 'Switch Camera',
                    child: Icon(
                      Icons.cameraswitch,
                      color:
                      _isVideoEnabled() ? AppColors.WHITE : AppColors.grey,
                    ),
                    onPressed: () => _switchCamera(),
                    backgroundColor: AppColors.BLACK38,
                  ),
                ),
              ),
              Visibility(
                visible: !(kIsWeb &&
                    (Browser().browserAgent == BrowserAgent.Safari ||
                        Browser().browserAgent == BrowserAgent.Firefox)),
                child: Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: FloatingActionButton(
                    elevation: 0,
                    heroTag:
                    'Switch ${kIsWeb || WebRTC.platformIsDesktop ? 'Audio output' : 'Speakerphone'}',
                    child: Icon(
                      kIsWeb || WebRTC.platformIsDesktop
                          ? Icons.surround_sound
                          : _isSpeakerEnabled
                          ? Icons.volume_up
                          : Icons.volume_off,
                      color:
                      _isSpeakerEnabled ? AppColors.WHITE : AppColors.grey,
                    ),
                    onPressed: () => _switchSpeaker(),
                    backgroundColor: AppColors.BLACK38,
                  ),
                ),
              ),
              const Expanded(
                child: SizedBox(),
                flex: 1,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: FloatingActionButton(
                  child: const Icon(
                    Icons.call_end,
                    color: AppColors.WHITE,
                  ),
                  backgroundColor: AppColors.RED,
                  onPressed: () => _endCall(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _endCall() async {
    await _stopWatchTimer.dispose();
    CallManager.instance.hungUp();
  }

  Future<bool> _onBackPressed(BuildContext context) {
    return Future.value(false);
  }

  _muteMic() {
    setState(() {
      _isMicMute = !_isMicMute;
      _callSession.setMicrophoneMute(_isMicMute);
      CallManager.instance.muteCall(_callSession.sessionId, _isMicMute);
    });
  }

  _switchCamera() {
    if (!_isVideoEnabled()) return;

    if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
      _callSession.switchCamera().then((isFrontCameraUsed) {
        setState(() {
          _isFrontCameraUsed = isFrontCameraUsed;
        });
      });
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return FutureBuilder<List<MediaDeviceInfo>>(
            future: _callSession.getCameras(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return AlertDialog(
                  content: const Text('No cameras found'),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              } else {
                return SimpleDialog(
                  title: const Text('Select camera'),
                  children: snapshot.data?.map(
                        (mediaDeviceInfo) {
                      return SimpleDialogOption(
                        onPressed: () {
                          Get.back(result: mediaDeviceInfo.deviceId);
                        },
                        child: Text(mediaDeviceInfo.label),
                      );
                    },
                  ).toList(),
                );
              }
            },
          );
        },
      ).then((deviceId) {
        if (deviceId != null) _callSession.switchCamera(deviceId: deviceId);
      });
    }
  }

  _toggleCamera() {
    if (!_isVideoCall()) return;

    setState(() {
      _isCameraEnabled = !_isCameraEnabled;
      _callSession.setVideoEnabled(_isCameraEnabled);
    });
  }

  bool _isVideoEnabled() {
    return _isVideoCall() && _isCameraEnabled;
  }

  bool _isVideoCall() {
    return CallType.VIDEO_CALL == _callSession.callType;
  }

  _switchSpeaker() {
    if (kIsWeb || WebRTC.platformIsDesktop) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return FutureBuilder<List<MediaDeviceInfo>>(
            future: _callSession.getAudioOutputs(),
            builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return AlertDialog(
                  content: const Text('No Audio output devices found'),
                  actions: <Widget>[
                    TextButton(
                      style: TextButton.styleFrom(
                        textStyle: Theme.of(context).textTheme.labelLarge,
                      ),
                      child: const Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              } else {
                return SimpleDialog(
                  title: const Text('Select Audio output device'),
                  children: snapshot.data?.map(
                        (mediaDeviceInfo) {
                      return SimpleDialogOption(
                        onPressed: () {
                          Get.back(result: mediaDeviceInfo.deviceId);
                        },
                        child: Text(mediaDeviceInfo.label),
                      );
                    },
                  ).toList(),
                );
              }
            },
          );
        },
      ).then((deviceId) {
        if (deviceId != null) {
          setState(() {
            if (kIsWeb) {
              remoteRenderer?.audioOutput(deviceId);
              localRenderer?.audioOutput(deviceId);
            } else {}
          });
        }
      });
    } else {
      setState(() {
        _isSpeakerEnabled = !_isSpeakerEnabled;
        _callSession.enableSpeakerphone(_isSpeakerEnabled);
      });
    }
  }

  @override
  void onConnectedToUser(P2PSession session, int userId) {
    _stopWatchTimer.onExecute.add(StopWatchExecute.start);
  }

  @override
  void onConnectionClosedForUser(P2PSession session, int userId) {
    _removeMediaStream(session, userId);
  }

  @override
  void onDisconnectedFromUser(P2PSession session, int userId) {}

  void _initAlreadyReceivedStreams() {
    // Initialize remote streams if any exist
    if (CallManager.instance.remoteStreams.isNotEmpty) {
      var remoteEntry = CallManager.instance.remoteStreams.entries.first;
      remoteUserId = remoteEntry.key;
      remoteRenderer = RTCVideoRenderer();
      remoteRenderer!.initialize().then((value) {
        remoteRenderer!.srcObject = remoteEntry.value;
      });
      CallManager.instance.remoteStreams.clear();
    }

    // Initialize local stream if it exists
    if (CallManager.instance.localMediaStream != null) {
      localRenderer = RTCVideoRenderer();
      localRenderer!.initialize().then((value) {
        localRenderer!.srcObject = CallManager.instance.localMediaStream;
      });
    }
  }

  @override
  void onConnectingToUser(P2PSession session, int userId) {
    // TODO: implement onConnectingToUser
  }

  @override
  void onConnectionFailedWithUser(P2PSession session, int userId) {
    // TODO: implement onConnectionFailedWithUser
  }
}