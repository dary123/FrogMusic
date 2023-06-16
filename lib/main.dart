import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'notifiers/play_button_notifier.dart';
import 'notifiers/progress_notifier.dart';
import 'notifiers/repeat_button_notifier.dart';
import 'page_manager.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

// use GetIt or Provider rather than a global variable in a real project
late final PageManager _pageManager;

class _MyAppState extends State<MyApp> {
  String songId = "";
  final shareUrlControllerFocusNode = FocusNode();
  TextEditingController shareUrlEditingController = TextEditingController();
  String? errorTip = "";
  String successTip = "";

  @override
  void initState() {
    super.initState();
    _pageManager = PageManager();
    Future.delayed(const Duration(seconds: 3), () {
      shareUrlControllerFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _pageManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              CurrentSongTitle(),
              songId != ""
                  ? Playlist()
                  : Expanded(child: NoBindTitle()),
              // AddRemoveSongButtons(),
              AudioProgressBar(),
              AudioControlButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget NoBindTitle() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 28.0,
          ),
          TextFormField(
            autofocus: false,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16.0,
            ),
            controller: shareUrlEditingController,
            textInputAction: TextInputAction.next,
            cursorColor: const Color(0xFF1DA1F3),
            focusNode: shareUrlControllerFocusNode,
            validator: (value) {
              return errorTip;
            },
            decoration: InputDecoration(
                labelText: successTip,
                labelStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
                hintText: "输入歌单链接(分享到QQ再复制)",
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16.0,
                ),
                prefixIcon: const Padding(
                  padding: EdgeInsets.all(16),
                  child: Icon(Icons.link, color: Colors.grey),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 2.0, color: Color(0xFF000000)),
                    borderRadius: BorderRadius.circular(12.0)),
                border: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 12.0, color: Color(0xFF000000)),
                    borderRadius: BorderRadius.circular(12.0)),
                fillColor: const Color(0xFFF0F0F0),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 2.0, color: Color(0xFF1DA1F3)),
                    borderRadius: BorderRadius.circular(12.0)),
                filled: true),
            keyboardType: TextInputType.text,
          ),
          SizedBox(
            height: 16.0,
          ),
          TextButton(
            style: TextButton.styleFrom(
              minimumSize: const Size(94, 48),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4.0),
              backgroundColor: const Color(0xFF5ABD6C),
              foregroundColor: const Color(0xFF5ABD6C),
            ),
            onPressed: () async {
              if (shareUrlEditingController.text.isNotEmpty) {
                if ((shareUrlEditingController.text.contains("id=")) &&
                    (shareUrlEditingController.text.contains("&ADTAG")) &&
                    (shareUrlEditingController.text.indexOf("&ADTAG") >
                        (shareUrlEditingController.text.indexOf("id=") + 3))) {
                  String songid = shareUrlEditingController.text.substring(
                      shareUrlEditingController.text.indexOf("id=") + 3,
                      shareUrlEditingController.text.indexOf("&ADTAG"));
                  if (songid.isNotEmpty) {
                    setState(() {
                      errorTip = "";
                      songId = songid;
                      successTip = "正在导入,请稍后";
                    });
                    _pageManager.loadSongList(songId);
                  } else {
                    setState(() {
                      successTip = "输入的歌单链接格式错误";
                    });
                  }
                } else if (shareUrlEditingController.text.contains("id=")) {
                  String songid = shareUrlEditingController.text.substring(
                      shareUrlEditingController.text.indexOf("id=") + 3,
                      shareUrlEditingController.text.length);
                  if (songid.isNotEmpty) {
                    setState(() {
                      errorTip = "";
                      songId = songid;
                      successTip = "正在导入,请稍后";
                    });
                    _pageManager.loadSongList(songId);
                  } else {
                    setState(() {
                      successTip = "输入的歌单链接格式错误";
                    });
                  }
                }
              } else {
                setState(() {
                  successTip = "输入内容不能为空";
                });
              }
            },
            child: const Text("导入QQ音乐歌单",
                style: TextStyle(fontSize: 13.0, color: Color(0xFFFFFFFF))),
          )
        ],
      ),
    );
  }
}

class CurrentSongTitle extends StatelessWidget {
  const CurrentSongTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String>(
      valueListenable: _pageManager.currentSongTitleNotifier,
      builder: (_, title, __) {
        return Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(title!=""?title:"仅供学习交流", style: TextStyle(fontSize: 40)),
        );
      },
    );
  }
}

class Playlist extends StatelessWidget {
  const Playlist({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<List<String>>(
        valueListenable: _pageManager.playlistNotifier,
        builder: (context, playlistTitles, _) {
          return ListView.builder(
            itemCount: playlistTitles.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text('${playlistTitles[index]}'),
              );
            },
          );
        },
      ),
    );
  }
}

class AddRemoveSongButtons extends StatelessWidget {
  const AddRemoveSongButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: _pageManager.addSong,
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: _pageManager.removeSong,
            child: Icon(Icons.remove),
          ),
        ],
      ),
    );
  }
}

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: _pageManager.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: _pageManager.seek,
        );
      },
    );
  }
}

class AudioControlButtons extends StatelessWidget {
  const AudioControlButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RepeatButton(),
          PreviousSongButton(),
          PlayButton(),
          NextSongButton(),
          ShuffleButton(),
        ],
      ),
    );
  }
}

class RepeatButton extends StatelessWidget {
  const RepeatButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<RepeatState>(
      valueListenable: _pageManager.repeatButtonNotifier,
      builder: (context, value, child) {
        Icon icon;
        switch (value) {
          case RepeatState.off:
            icon = Icon(Icons.repeat, color: Colors.grey);
            break;
          case RepeatState.repeatSong:
            icon = Icon(Icons.repeat_one);
            break;
          case RepeatState.repeatPlaylist:
            icon = Icon(Icons.repeat);
            break;
        }
        return IconButton(
          icon: icon,
          onPressed: _pageManager.onRepeatButtonPressed,
        );
      },
    );
  }
}

class PreviousSongButton extends StatelessWidget {
  const PreviousSongButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _pageManager.isFirstSongNotifier,
      builder: (_, isFirst, __) {
        return IconButton(
          icon: Icon(Icons.skip_previous),
          onPressed:
              (isFirst) ? null : _pageManager.onPreviousSongButtonPressed,
        );
      },
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ButtonState>(
      valueListenable: _pageManager.playButtonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: EdgeInsets.all(8.0),
              width: 32.0,
              height: 32.0,
              child: CircularProgressIndicator(),
            );
          case ButtonState.paused:
            return IconButton(
              icon: Icon(Icons.play_arrow),
              iconSize: 32.0,
              onPressed: _pageManager.play,
            );
          case ButtonState.playing:
            return IconButton(
              icon: Icon(Icons.pause),
              iconSize: 32.0,
              onPressed: _pageManager.pause,
            );
        }
      },
    );
  }
}

class NextSongButton extends StatelessWidget {
  const NextSongButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _pageManager.isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconButton(
          icon: Icon(Icons.skip_next),
          onPressed: (isLast) ? null : _pageManager.onNextSongButtonPressed,
        );
      },
    );
  }
}

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: _pageManager.isShuffleModeEnabledNotifier,
      builder: (context, isEnabled, child) {
        return IconButton(
          icon: (isEnabled)
              ? Icon(Icons.shuffle)
              : Icon(Icons.shuffle, color: Colors.grey),
          onPressed: _pageManager.onShuffleButtonPressed,
        );
      },
    );
  }
}
