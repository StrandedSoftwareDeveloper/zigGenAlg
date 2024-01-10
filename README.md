# zigGenAlg
A simple generic genetic algorithm library for zig

Uses zig 0.12.0-dev.2100+8c9efc95a (see [this commit](https://github.com/StrandedSoftwareDeveloper/zigGenAlg/commit/4c365dca9e2f2fa2c478b6a55360b3463f91fd91) for a zig 0.11.0 version)

To run example:
```
git clone https://github.com/StrandedSoftwareDeveloper/zigGenAlg.git
cd zigGenAlg
zig build example
```

To use with the zig package manager:
- Run the following:
```
zig fetch --save https://github.com/StrandedSoftwareDeveloper/zigGenAlg/archive/<latest commit hash>.tar.gz
```
- Add this to your build.zig:
```
const gen_alg_mod = b.dependency("genAlg", .{ .target = target, .optimize = optimize }).module("genAlg");
exe.addModule("genAlg", gen_alg_mod);
```
- And import it with this:
```
const genAlg = @import("genAlg");
```
