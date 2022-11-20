import 'package:deriv_price_tracker/constants/app_text_styles.dart';
import 'package:deriv_price_tracker/constants/colors.dart';
import 'package:deriv_price_tracker/constants/strings.dart';
import 'package:deriv_price_tracker/utils/utils.dart';
import 'package:flutter/material.dart';

import '../../data/models/ticks_stream_response_model.dart';

class DynamicPriceWidget extends StatefulWidget {
  final Tick? tick;
  final Tick? previousTick;

  const DynamicPriceWidget({Key? key, this.tick, this.previousTick})
      : super(key: key);

  @override
  State<DynamicPriceWidget> createState() => _DynamicPriceWidgetState();
}

class _DynamicPriceWidgetState extends State<DynamicPriceWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: Utils.getScreenWidth(context) / 1.5,
        height: Utils.getScreenHeight(context) / 10,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              Strings.priceText,
              style: AppTextStyles.textStyleRegularImageBodySmallWhiteText,
            ),
            Text(
              '${_getPriceString(tick: widget.tick)}',
              style: TextStyle(
                  fontSize: 30,

                  ///color is changes based on the price difference
                  color: _getPriceString(tick: widget.tick) == Strings.zeroText
                      ? ColorPalette.colorHintGrey
                      : _checkPriceDifference(
                                  tick: widget.tick,
                                  previousTick: widget.previousTick)
                              .isNegative
                          ? ColorPalette.colorRedNegative
                          : ColorPalette.colorGreenPositive),
              textAlign: TextAlign.start,
            ),

            ///Corresponding arrows are shown based on the price difference
            _checkPriceDifference(
                        tick: widget.tick, previousTick: widget.previousTick)
                    .isNegative
                ? const Icon(
                    Icons.keyboard_arrow_down,
                    size: 30.0,
                    color: ColorPalette.colorRedNegative,
                  )
                : const Icon(
                    Icons.keyboard_arrow_up,
                    size: 30.0,
                    color: ColorPalette.colorGreenPositive,
                  ),
          ],
        ),
      ),
    );
  }

  _checkPriceDifference({Tick? tick, Tick? previousTick}) {
    try {
      if (tick != null && previousTick != null) {
        double difference = 0.0;
        difference = (tick.quote! - previousTick.quote!);
        return difference;
      }
      return 0.0;
    } catch (e) {
      return 0.0;
    }
  }

  _getPriceString({Tick? tick}) {
    if (tick != null) {
      return tick.quote.toString();
    }
    return Strings.zeroText;
  }
}
