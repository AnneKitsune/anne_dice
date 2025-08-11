const std = @import("std");

threadlocal var prng: ?std.Random.DefaultPrng = null;
threadlocal var rng: std.Random = undefined;

/// Inclusive. Both min and max can be returned.
pub export fn intRange(min: u32, max: u32) u32 {
    if (prng == null) {
        const seed: u64 = @truncate(@as(u128, @bitCast(std.time.nanoTimestamp())));
        prng = std.Random.DefaultPrng.init(seed);
        rng = prng.?.random();
    }

    return rng.intRangeAtMost(u32, min, max);
}

pub export fn d2() u32 {
    return intRange(1, 2);
}

pub export fn d4() u32 {
    return intRange(1, 4);
}

pub export fn d6() u32 {
    return intRange(1, 6);
}

pub export fn d6Count(count: u32) u32 {
    var sum: u32 = 0;
    for (0..count) |i| {
        _ = i;
        sum += d6();
    }
    return sum;
}

pub export fn d8() u32 {
    return intRange(1, 8);
}

pub export fn d10() u32 {
    return intRange(1, 10);
}

pub export fn d12() u32 {
    return intRange(1, 12);
}

pub export fn d20() u32 {
    return intRange(1, 20);
}

pub export fn d100() u32 {
    return intRange(1, 100);
}

pub const ChallengeRollResult = enum(u8) {
    miss,
    weak,
    strong,
};

/// Does a challenge roll. This consists in rolling a d6 and adding a modifier value to it (usually the player's skill) and comparing it to two "challenge d10".
///
/// To win against a challenge d10, the d6 plus modifier must be higher than the d10's value.
/// There are three possible outcomes: Winning both (a `StrongHit`), winning only one (a `WeakHit`) and losing both (a `Miss`).
///
/// # Probabilities:
/// The probabilities of winning given a modifier are as follow:
/// | Modifier | Miss Chance | Weak Hit Chance | Strong Hit Chance |
/// |----------|-------------|-----------------|-------------------|
/// | -5       | 100.00%     | 0.00%           | 0.00%             |
/// | -4       | 96.80%      | 3.04%           | 0.16%             |
/// | -3       | 90.75%      | 8.44%           | 0.82%             |
/// | -2       | 82.48%      | 15.23%          | 2.29%             |
/// | -1       | 71.99%      | 23.01%          | 5.00%             |
/// | +0       | 59.18%      | 31.64%          | 9.18%             |
/// | +1       | 45.10%      | 39.56%          | 15.34%            |
/// | +2       | 33.13%      | 43.51%          | 23.36%            |
/// | +3       | 23.34%      | 43.38%          | 33.28%            |
/// | +4       | 15.15%      | 39.82%          | 45.03%            |
/// | +5       | 9.19%       | 31.37%          | 59.45%            |
/// | +6       | 5.05%       | 23.41%          | 71.54%            |
/// | +7       | 2.25%       | 15.19%          | 82.56%            |
/// | +8       | 0.85%       | 8.28%           | 90.87%            |
/// | +9       | 0.16%       | 2.97%           | 96.87%            |
/// | +10      | 0.00%       | 0.00%           | 100.00%           |
pub export fn challengeRoll(modifier: i32) ChallengeRollResult {
    const dice = @as(i32, @intCast(d6())) + modifier;
    const one = d10();
    const two = d10();
    if (dice <= one and dice <= two) {
        return .miss;
    } else if (dice > one and dice > two) {
        return .strong;
    } else {
        return .weak;
    }
}

const TEST_COUNT = 100;
fn testInRange(func: anytype, min: u32, max: u32) !void {
    for (0..TEST_COUNT) |i| {
        _ = i;
        const val = func();
        if (val < min or val > max) {
            return error.ExceededRange;
        }
    }
}

test "rng" {
    try testInRange(d2, 1, 2);
    try testInRange(d4, 1, 4);
    try testInRange(d6, 1, 6);
    try testInRange(d8, 1, 8);
    try testInRange(d10, 1, 10);
    try testInRange(d12, 1, 12);
    try testInRange(d20, 1, 20);
    try testInRange(d100, 1, 100);

    for (0..TEST_COUNT) |i| {
        _ = i;
        const val1 = d6Count(4);
        if (val1 < 4 or val1 > 4 * 6) {
            return error.ExceededRange;
        }
    }
    _ = challengeRoll(0);
}
