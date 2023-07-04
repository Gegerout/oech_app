import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:oech_app/core/theme/colors.dart';
import 'package:oech_app/home/presentation/pages/call_page.dart';
import 'package:oech_app/home/presentation/states/chat_state.dart';
import 'package:provider/provider.dart';
import '../../data/data_sources/remote_data.dart';
import '../../data/models/message_model.dart';
import '../widgets/chat_bubble_widget.dart';

class RiderChatPage extends ConsumerStatefulWidget {
  const RiderChatPage({Key? key, required this.regNum}) : super(key: key);

  final String regNum;

  @override
  ConsumerState<RiderChatPage> createState() => _RiderChatPageState();
}

class _RiderChatPageState extends ConsumerState<RiderChatPage> {
  final _formKey = GlobalKey<FormState>();
  final _msgController = TextEditingController();

  Future<void> _submit(RemoteData appService) async {
    final text = _msgController.text;

    if (text.isEmpty) {
      return;
    }

    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await appService.saveMessage(text, widget.regNum);

      _msgController.text = '';
    }
  }

  @override
  void didUpdateWidget(RiderChatPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _msgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appService = context.read<RemoteData>();
    ref.refresh(chatProvider(widget.regNum)).value;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 63,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Image.asset(
              "assets/images/arrow-square-right.png",
              width: 24,
              height: 24,
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: ref.watch(chatProvider(widget.regNum)).when(
            data: (value) {
              return Padding(
                padding: const EdgeInsets.only(left: 46),
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: value.avatar,
                      width: 43,
                      height: 43,
                      fit: BoxFit.fill,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          value.name,
                          style: TextStyle(
                              fontSize: 14, color: AppColors.textColor),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          value.status,
                          style: TextStyle(
                              fontSize: 12, color: AppColors.primaryColor),
                        )
                      ],
                    )
                  ],
                ),
              );
            },
            error: (error, stacktrace) {
              return Scaffold(
                body: AlertDialog(
                  title: Text(error.toString()),
                  actions: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Ok"))
                  ],
                )
              );
            },
            loading: () => Scaffold(body: Container())),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CallPage(regNum: widget.regNum)));
            },
            icon: Image.asset(
              "assets/images/phone_icon.png",
              width: 14.1,
              height: 18.4,
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
      body: StreamBuilder<List<Message>>(
        stream: appService.getMessages(widget.regNum),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final messages = snapshot.data!;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Expanded(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: ListView.builder(
                        reverse: true,
                        shrinkWrap: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];

                          return ChatBubble(message: message);
                        },
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/emoji_icon.png",
                        width: 27,
                        height: 27,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(
                        width: 7,
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          width: 307,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              color: ref.watch(chatDataProvider).isColor
                                  ? Colors.white
                                  : AppColors.grey1Color),
                          child: TextFormField(
                            onTap: () {
                              ref
                                  .read(chatDataProvider.notifier)
                                  .changeFocus(true);
                            },
                            controller: _msgController,
                            style: TextStyle(
                                fontSize: 12, color: AppColors.textColor),
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 32),
                              suffixIcon: SizedBox(
                                  width: 12,
                                  height: 17,
                                  child: Image.asset(
                                    "assets/images/micro_icon.png",
                                    fit: BoxFit.scaleDown,
                                    scale: 4,
                                  )),
                              hintText: "Enter message",
                              hintStyle: TextStyle(
                                  fontSize: 12, color: AppColors.grey2Color),
                              border: OutlineInputBorder(
                                borderSide: ref.watch(chatDataProvider).isColor
                                    ? BorderSide(
                                        width: 1, color: AppColors.grey2Color)
                                    : BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 1, color: AppColors.grey2Color),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 1,
                      ),
                      InkWell(
                        onTap: () {
                          _submit(appService);
                        },
                          child: Image.asset(
                        "assets/images/send_icon.png",
                        width: 42,
                        height: 42,
                        fit: BoxFit.fill,
                      )),
                    ],
                  ),
                  const SizedBox(height: 10.0)
                ],
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
