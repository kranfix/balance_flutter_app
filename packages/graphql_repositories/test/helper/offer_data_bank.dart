import 'dart:convert';

import 'package:graphql_repositories/utils/utils.dart';

final offerDataResponse = jsonDecode(
  '''
{
  "purchase": {
    "success": true,
    "errorMessage": null
  }
}''',
) as JMap;
