# zigGenAlg
A simple generic genetic algorithm library for zig

Uses zig 0.11.0

To run example:
```
git clone https://github.com/StrandedSoftwareDeveloper/zigGenAlg.git
cd zigGenAlg
zig build example
```

To use with the zig package manager:
- Add this to your build.zig.zon:
```
.{
    .name = "yourProjectName",
    .version = "your.version.number",
    .dependencies = .{
        .genAlg = .{
            .url = "https://github.com/StrandedSoftwareDeveloper/zigGenAlg/archive/<latest commit hash>.tar.gz",
        }
    },
}
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
