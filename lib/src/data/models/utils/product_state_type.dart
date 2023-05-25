class ProductStateType {
  static const perfect = "Perfecto estado";
  static const likeNew = "Como nuevo";
  static const good = "En buen estado";
  static const acceptable = "En condiciones aceptables";
  static const busted = "Lo ha dado todo";

  final String value;

  const ProductStateType._(this.value);
}
