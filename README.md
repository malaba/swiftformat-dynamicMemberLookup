### Swiftformat change compiling code to non-compiling.

The source code compile as it is. But if you run `swiftformat .` (latest versions 0.49.4) at the root it change the `other.swift` file to something that don't compile anymore.

The rule *redundantSelf* is not correctly doing its work here. The `self` is needed to access via `@dynamicMemberLookup` the properties.

In the main file `def.swift` another `private extension SomeType` is correctly treated. I suppose that because it is in the same file as the definition using `@dynamicMemberLookup` it can be infered, but not when in another file ?

There is an option `--selfrequired` for function with `@autoclosure` arguments. But nothing similar for those dynamic member lookup.

This is either a bug, for not viewing that dynamic member lookup need the `self`, or it is a missing option to enumerate some properties where the rule *redundantSelf* shouldn't apply.
