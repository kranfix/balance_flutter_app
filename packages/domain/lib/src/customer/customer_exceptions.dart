/// {@template graphql_repositories.UnauthorizedException}
/// Exception when the user is not authorized to perform the operation.
/// {@endtemplate}
class UnauthorizedException implements Exception {
  /// {@macro graphql_repositories.UnauthorizedException}
  const UnauthorizedException();

  @override
  String toString() => 'UnauthorizedException()';
}
