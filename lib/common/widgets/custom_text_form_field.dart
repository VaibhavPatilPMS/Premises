import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:premises/common/base/base.dart';
import 'package:premises/common/utils/utils.dart';
import 'package:premises/main_imports.dart';
import 'package:premises/common/resources/resources.dart';

class CustomTextFormField extends StatefulWidget {
  final String hinttext;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;
  final TextInputType textInputType;
  final Color? prefixIconColor;
  final Color? suffixIconColor;
  final Color? fillColor;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final Function? onIconPressed;
  final Function? onSaved;
  final Function? onChanged;
  final bool? enabled;
  final String? initialValue;
  final Function? validator;
  final bool? readonly;
  final bool? autofocus;
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final TextAlign? textAlign;
  final bool? obscureText;
  final String? errorText;
  final Function? onTap;
  final TextCapitalization? textCapitalization;
  final bool isCounterText;
  final double? height;
  final AutovalidateMode? autovalidateMode;
  final bool enableSpeechToText;

  const CustomTextFormField({
    super.key,
    required this.hinttext,
    this.maxLength,
    this.maxLines,
    this.minLines,
    required this.textInputType,
    this.prefixIconColor,
    this.suffixIconColor,
    this.fillColor,
    this.suffixIcon,
    this.prefixIcon,
    this.onIconPressed,
    this.onSaved,
    this.onChanged,
    this.enabled,
    this.initialValue,
    this.validator,
    this.readonly,
    this.autofocus,
    this.focusNode,
    this.controller,
    this.inputFormatters,
    this.textAlign,
    this.obscureText,
    this.errorText,
    this.onTap,
    this.textCapitalization,
    this.isCounterText = false,
    this.height,
    this.autovalidateMode,
    this.enableSpeechToText = false,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final _outLineInputBorderStyle = OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.text_grey_g2,
      width: AppSizes().textFormFieldBorderWidth,
    ),
    borderRadius: BorderRadius.circular(
      AppSizes().defaultTextFormFieldRoundedCorners,
    ),
  );

  final _outLineErrorBorderStyle = OutlineInputBorder(
    borderSide: BorderSide(
      color: AppColors.text_asteriskColor_color,
      width: AppSizes().textFormFieldBorderWidth,
    ),
    borderRadius: BorderRadius.circular(
      AppSizes().defaultTextFormFieldRoundedCorners,
    ),
  );

  late final String _speechFieldId;
  late TextEditingController _effectiveController;
  bool _ownsController = false;
  BaseProvider? _baseProvider;

  @override
  void initState() {
    super.initState();
    _speechFieldId = 'custom_text_form_field_${identityHashCode(this)}';
    _effectiveController = widget.controller ??
        TextEditingController(text: widget.initialValue ?? '');
    _ownsController = widget.controller == null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _baseProvider ??= Provider.of<BaseProvider>(context, listen: false);
  }

  @override
  void didUpdateWidget(covariant CustomTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      if (_ownsController) {
        _effectiveController.dispose();
      }
      _effectiveController = widget.controller ??
          TextEditingController(text: widget.initialValue ?? '');
      _ownsController = widget.controller == null;
    }
  }

  @override
  void dispose() {
    _baseProvider?.clearSpeechField(_speechFieldId);
    if (_ownsController) {
      _effectiveController.dispose();
    }
    super.dispose();
  }

  Future<void> _toggleListening() async {
    // await PermissionUtils().requestMicrophonePermission();

    if (AppData().microphonePermission!) {
      await _baseProvider?.toggleSpeechToText(
        fieldId: _speechFieldId,
        controller: _effectiveController,
        onChanged: widget.onChanged as void Function(String)?,
        enabled: widget.enabled ?? true,
        readOnly: widget.readonly ?? false,
      );
    }
  }

  Widget? _buildSuffixIcon(BuildContext context, BaseProvider baseProvider) {
    final suffixWidgets = <Widget>[];

    if (widget.suffixIcon != null) {
      suffixWidgets.add(
        IconButton(
          icon: Icon(widget.suffixIcon),
          onPressed: widget.onIconPressed as void Function()?,
          color: widget.suffixIconColor ?? Theme.of(context).primaryColor,
        ),
      );
    }

    if (widget.enableSpeechToText) {
      final isListening = baseProvider.isSpeechListening(_speechFieldId);
      final micColor = isListening
          ? AppColors.color_primary
          : (widget.suffixIconColor ?? AppColors.text_grey_g1);
      suffixWidgets.add(
        IconButton(
          icon: Icon(isListening ? Icons.mic : Icons.mic_off_rounded),
          onPressed: _toggleListening,
          color: micColor,
        ),
      );
    }

    if (suffixWidgets.isEmpty) {
      return null;
    }
    if (suffixWidgets.length == 1) {
      return suffixWidgets.first;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: suffixWidgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BaseProvider>(
      builder: (context, baseProvider, _) => TextFormField(
        keyboardType: widget.textInputType,
        expands: false,
        autovalidateMode: widget.autovalidateMode ?? AutovalidateMode.disabled,
        autofocus: widget.autofocus ?? false,
        cursorColor: AppColors.text_grey,
        focusNode: widget.focusNode,
        cursorWidth: 1.0,
        textAlign: widget.textAlign ?? TextAlign.start,
        inputFormatters: widget.inputFormatters,
        obscureText: widget.obscureText ?? false,
        maxLength: widget.maxLength,
        onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
        validator: widget.validator as String? Function(String?)?,
        onChanged: widget.onChanged as void Function(String)?,
        enabled: widget.enabled ?? true,
        readOnly: widget.readonly ?? false,
        textAlignVertical: TextAlignVertical.top,
        onSaved: widget.onSaved as String? Function(String?)?,
        maxLines: widget.maxLines ?? 1,
        minLines: widget.minLines ?? 1,
        controller: _effectiveController,
        onTap: widget.onTap as void Function()?,
        textCapitalization:
            widget.textCapitalization ?? TextCapitalization.sentences,
        style: FormTextStyles.textFormFieldInputTextStyle,
        decoration: InputDecoration(
          counter: widget.isCounterText ? null : const SizedBox(height: 1),
          filled: true,
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  size: 24,
                  color: widget.prefixIconColor,
                )
              : null,
          suffixIcon: _buildSuffixIcon(context, baseProvider),
          fillColor: widget.enabled != null && !widget.enabled!
              ? AppColors.greyBackgroundColor
              : widget.fillColor ?? AppColors.white,
          contentPadding: const EdgeInsets.all(12.0),
          hintStyle: FormTextStyles.textFormFieldHintStyle,
          hintText: widget.hinttext,
          focusedBorder: _outLineInputBorderStyle,
          focusedErrorBorder: _outLineErrorBorderStyle,
          errorBorder: _outLineErrorBorderStyle,
          enabledBorder: _outLineInputBorderStyle,
          disabledBorder: _outLineInputBorderStyle,
          labelStyle: FormTextStyles.textFormFieldInputTextStyle,
          errorStyle: FormTextStyles.textFormFieldErrorStyle,
          errorText: widget.errorText,
          errorMaxLines: 2,
        ),
      ),
    );
  }
}
