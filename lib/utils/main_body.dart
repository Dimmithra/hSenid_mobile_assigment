import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainBody extends StatefulWidget {
  const MainBody({
    super.key,
    required this.body,
    this.actions,
    this.backgroundColor,
    this.drawer,
    this.title,
    this.bottomNavigationBar,
    this.automaticallyImplyLeading = true,
    this.centerTitle = true,
    this.appBarBacgroundColor,
    this.leading,
    this.enableCopywriteLable = true,
  });

  final Widget body;
  final List<Widget>? actions;
  final Color? backgroundColor;
  final Widget? drawer;
  final Widget? bottomNavigationBar;
  final Widget? title;
  final bool automaticallyImplyLeading;
  final bool centerTitle;
  final Color? appBarBacgroundColor;
  final Widget? leading;
  final bool enableCopywriteLable;
  @override
  State<MainBody> createState() => _MainBodyState();
}

class _MainBodyState extends State<MainBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.appBarBacgroundColor,
        actions: widget.actions,
        title: widget.title,
        leading: widget.leading,
        automaticallyImplyLeading: widget.automaticallyImplyLeading,
        centerTitle: widget.centerTitle,
      ),
      backgroundColor: widget.backgroundColor,
      body: widget.body,
      drawer: widget.drawer,
      bottomNavigationBar: widget.bottomNavigationBar,
    );
  }
}
