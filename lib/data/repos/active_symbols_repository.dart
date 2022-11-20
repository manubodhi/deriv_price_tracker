import 'package:deriv_price_tracker/data/models/active_symbols_request_model.dart';
import 'package:deriv_price_tracker/data/models/active_symbols_response_model.dart';

abstract class ActiveSymbolsRepository {
  Stream<ActiveSymbolsResponseModel> fetchActiveSymbols(
      {required ActiveSymbolsRequestModel? activeSymbolsRequest});
}
