### One issue or bug per Pull Request

Keep your Pull Requests small. Small PRs are easier to reason about which makes them significantly more likely to get merged.

### Issues before features

If you want to add a feature, please file an [Issue](../../issues) first. An Issue gives us the opportunity to discuss the requirements and implications of a feature with you before you start writing code.

### Backwards compatibility

Respect the minimum deployment target. If you are adding code that uses new APIs, make sure to prevent older clients from crashing or misbehaving. Our CI runs against our minimum deployment targets, so you will not get a green build unless your code is backwards compatible.

### Forwards compatibility

Please do not write new code using deprecated APIs.
