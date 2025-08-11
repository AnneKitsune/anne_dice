# Zig simple dice library

A simple library to quickly do common dice rolls.

Usage (zig):
1. Add `anne_dice` to your module's imports.
2. `anne_dice.d2()`
3. Profit!

Usage (C):
1. Include `anne_dice.h`
2. Link against `anne_dice.a`
3. `d2()`
4. Profit!

### Available functions:
```
intRange(min: u32, max: u32) u32
d2() u32
d4() u32
d6() u32
/// Sums the value of `count` d6 rolls.
d6Count(count: u32) u32
d8() u32
d10() u32
d12() u32
d20() u32
d100() u32
/// See documentation in `src/root.zig`
challengeRoll(modifier: i32) ChallengeRollResult
```
