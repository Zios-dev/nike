class Size {
  final String size;
  final bool isSelected;

  Size({required this.size, this.isSelected = false});

  Size copyWith({String? size, bool? isSelected}) {
    return Size(
        size: size ?? this.size, isSelected: isSelected ?? this.isSelected);
  }

  @override
  String toString() {
    return 'SizeData{size: $size, isSelected: $isSelected}';
  }
}
