const std = @import("std");

pub const ScoreOrder = enum {
    HighestIsBest,
    LowestIsBest,
};

pub fn GeneticAlgorithm(comptime T: type) type {
    return struct {
        const Self = @This();

        pub const Individual = struct {
            ind: T,
            score: f32,
        };

        allocator: std.mem.Allocator,
        population: []Individual,
        keepFraction: f32,
        mutateFraction: f32,

        pub fn init(allocator: std.mem.Allocator, populationSize: usize, keepFraction: f32, mutateFraction: f32) !Self {
            var pop: Self = undefined;
            pop.allocator = allocator;
            pop.population = try pop.allocator.alloc(Individual, populationSize);
            pop.keepFraction = keepFraction;
            pop.mutateFraction = mutateFraction;
            for (pop.population) |*ind| {
                ind.score = 0.0;
            }
            return pop;
        }

        pub fn deinit(pop: *Self) void {
            pop.allocator.free(pop.population);
        }

        fn compare(context: ScoreOrder, l: Individual, r: Individual) bool {
            switch (context) {
                ScoreOrder.HighestIsBest => return l.score > r.score,
                ScoreOrder.LowestIsBest => return l.score < r.score,
            }
        }

        pub fn evaluate(pop: Self, context: anytype, comptime scoreFun: fn (context: anytype, individual: *T) f32, scoreOrder: ScoreOrder) void {
            for (pop.population) |*ind| {
                ind.score = scoreFun(context, &ind.ind);
            }
            //std.sort.sort(Individual, pop.population, true, compare);
            std.sort.heap(Individual, pop.population, scoreOrder, compare);
        }

        pub fn update(pop: *Self, context: anytype, comptime mutateFun: fn (context: anytype, individual: T, out: *T) void, comptime regenFun: fn (context: anytype, individual: *T) void) void {
            const keepNum: usize = @intFromFloat(pop.keepFraction * @as(f32, @floatFromInt(pop.population.len)));
            const mutateNum: usize = @intFromFloat(pop.mutateFraction * @as(f32, @floatFromInt(pop.population.len)));
            const regenNum: usize = (pop.population.len - keepNum) - mutateNum;
            for (keepNum..mutateNum) |i| {
                mutateFun(context, pop.population[i % keepNum].ind, &pop.population[i].ind);
            }
            for (mutateNum..regenNum) |i| {
                regenFun(context, &pop.population[i].ind);
            }
        }
    };
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
