import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/app_theme.dart';
import '../../../models/repo_model.dart';
import '../cubit/home_cubit.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  TextEditingController textController = TextEditingController();
  final FocusNode _focus = FocusNode();
  bool _isFocused = false;
  bool _isEnabled = true;

  @override
  void initState() {
    super.initState();
    _focus.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    super.dispose();
    _focus.removeListener(_onFocusChange);
    _focus.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focus.hasFocus;
    });
    debugPrint("Focus: ${_focus.hasFocus.toString()}");
  }

  Future<void> _search(BuildContext context) async {
    if (textController.text.isNotEmpty) {
      setState(() {
        _isEnabled = false;
      });

      await context.read<HomeCubit>().search(
          RepoModel(name: textController.text, isFavorite: false),
          textController.text);

      setState(() {
        _isEnabled = true;
      });
    } else {
      context.read<HomeCubit>().loadSearchHistory();
    }
  }

  Widget getSuffixIcon(BuildContext context) {
    if (_isFocused || textController.text.isNotEmpty) {
      return InkWell(
        onTap: () {
          textController.clear();
          context.read<HomeCubit>().loadSearchHistory();
        },
        child: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
          child: SvgPicture.asset(
            _isEnabled
                ? 'assets/images/svgs/close.svg'
                : 'assets/images/svgs/ban.svg',
          ),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 55,
        child: TextField(
          focusNode: _focus,
          enabled: _isEnabled,
          style: TextStyle(
              color: _isEnabled
                  ? AppTheme.colors.primaryTextColor
                  : AppTheme.colors.primaryPlaceHolderTextColor),
          onSubmitted: (_) => _search(context),
          controller: textController,
          decoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  color: AppTheme.colors.primaryAccentColor, width: 2.0),
              borderRadius: BorderRadius.circular(30.0),
            ),
            filled: true,
            focusColor: AppTheme.colors.secondaryAccentColor,
            suffixIcon: getSuffixIcon(context),
            fillColor: _isFocused
                ? AppTheme.colors.secondaryAccentColor
                : AppTheme.colors.primaryLayerColor,
            hintText: 'search'.tr(),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(18),
              child: SvgPicture.asset(
                'assets/images/svgs/search.svg',
                width: 20,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }
}
