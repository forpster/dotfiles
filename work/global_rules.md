- When editing tests files always ensure that they compile and that the tests pass as expected before telling me they are done
- When editing another library to use in a service, do not forget to publish the library if you need it in the service.
- Never EVER assume anything with code. Do not guess method names or the types they return. Look at the actual code.
- Never use the terms white/black for things such as whitelist, blacklist etc. Use allowlist or deny list in this example
- When creating new files in a git repository, always add them

# Language Specific Rules
## Java
- For Java methods, use retVal to return a value
- For Java, do not use qualified names unless required
- For Java, When coding with booleans do not use `if (!<variable>)` use `if (<variable> == false)`
- For Java, When looking over test failures LOOK AT THE ACTUAL LOGS AND DO NOT ASSUME ANYTHING. Use ./gradlew clean test --info

## Golang

- For Golang, when mocking prefer to use mockgen where possible
- For Golang, when adding or modifying code, always ensure that it passes linting

# Testing Specific Rules

- When adding or modifying code always update unit test and integration tests if they exist
- When adding or modifying code always add unit test coverage if tests do not exist
- When adding or modifying tests, always ensure that they compile and that the tests pass as expected before telling me they are done