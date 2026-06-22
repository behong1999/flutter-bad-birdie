enum ShotType {
  clear,
  drop,
  smash,
  lift,
  block,
  kill,
  drive;

  static const Set<ShotType> _frontCourt = {ShotType.lift, ShotType.block, ShotType.kill};
  static const Set<ShotType> _midCourt = {ShotType.block, ShotType.kill, ShotType.drive};
  static const Set<ShotType> _backCourt = {ShotType.clear, ShotType.drop, ShotType.smash};

  static Set<ShotType> zoneAllowed(int corner) => switch (corner) {
    1 || 2 || 3 => _frontCourt,
    4 || 5 || 6 => _midCourt,
    7 || 8 || 9 => _backCourt,
    _ => _frontCourt,
  };

  static Set<ShotType> availableForCorners(Set<int> corners) =>
      corners.expand(zoneAllowed).toSet();
}
