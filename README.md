# zigGenAlg
A simple generic genetic algorithm library for zig

Uses zig 0.13.0 (~~see [this commit](https://github.com/StrandedSoftwareDeveloper/zigGenAlg/commit/4c365dca9e2f2fa2c478b6a55360b3463f91fd91) for a zig 0.11.0 version~~) Turns out that commit (and all other commits before [ce140637f47e21076246a19b0b65d9c7ffc527c4](https://github.com/StrandedSoftwareDeveloper/zigGenAlg/commit/ce140637f47e21076246a19b0b65d9c7ffc527c4)) had a bug that made them almost useless.
See [this commit](https://github.com/StrandedSoftwareDeveloper/zigGenAlg/commit/a13cfbaecbb41da9c158793560335a659964468a) for a zig 0.12.0 version.

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
exe.root_module.addImport("genAlg", gen_alg_mod);
```
- And import it with this:
```
const genAlg = @import("genAlg");
```
