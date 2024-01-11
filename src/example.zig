const std = @import("std");
const genAlg = @import("zigGenAlg.zig");

pub fn calcScore(context: anytype, ind: i32) f32 {
    _ = context;
    return @floatFromInt(ind);
}

pub fn mutate(rng: anytype, ind: i32) i32 {
    return ind + rng.intRangeAtMostBiased(i32, -10, 10);
}

pub fn regen(rng: anytype) i32 {
    return rng.intRangeAtMostBiased(i32, -10, 10);
}

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();
    const alloc = gpa.allocator();

    var pcg = std.rand.Pcg.init(0);
    const rng = pcg.random();

    var pop: genAlg.GeneticAlgorithm(i32) = try genAlg.GeneticAlgorithm(i32).init(alloc, 100, 0.05, 0.2);
    for (pop.population) |*ind| {
        ind.ind = regen(rng);
    }
    defer pop.deinit();

    for (0..100) |i| {
        _ = i;
        pop.evaluate(rng, calcScore, genAlg.ScoreOrder.HighestIsBest);
        pop.update(rng, mutate, regen);
        try stdout.print("Best score: {d:.2}\n", .{pop.population[0].score});
    }

    try bw.flush();
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
