# Red, green refactor loop

1. Read the issue. Each issue should describe one observable behaviour.
2. Write exactly one test for the next behaviour, asserting on observable results through a supported external interface.
3. Run the test. Confirm it fails on the assertion, not on an error like a missing import or syntax mistake. If it errors, fix the error and rerun until it fails correctly. If it passes, stop: the behaviour already exists or the test is wrong. Fix the test or remove it before continuing.
4. Write the minimum production code to make the new test pass.
5. Run the new test. If it still fails, fix the production code and rerun.
6. Run the relevant test suite. If an existing test broke, fix the regression without breaking the new test.
7. Commit.
8. If the code would be cleaner, refactor in small steps. Rerun the suite after each step. Stop as soon as tests are green and the code is cleaner.
9. If the behaviour needs further tests to fully specify, return to step 2. Otherwise the issue is complete.

## Rules

1. Never write production code unless a failing test requires it.
2. Never add more than one new failing test at a time.
3. Test through supported external interfaces only.
4. Do not test helpers, intermediate state or internal call structure unless they are part of the supported interface.
5. In green, do not generalise early.
6. Do not add code for future slices.
7. Refactor only while tests are passing.
8. Refactoring changes structure, not behavior.
9. If you want new behavior, write a new failing test first.
10. If setup is huge, the boundary is probably wrong. Find a smaller one.

## Red checklist

1. One behavior.
2. One test.
3. Stable external boundary.
4. Specific assertion.
5. Confirmed failure for the expected reason.
6. If the test passes immediately, stop and investigate.

## Green checklist

1. Minimum code only.
2. New test passes.
3. Relevant suite passes.
4. No speculative code added.

## Refactor checklist

1. Suite was green before refactoring.
2. Refactor was done in small steps.
3. Tests were run after each step.
4. No behavior changed.
5. No new module or abstraction adds more interface than it hides.

## Stop signs

1. More than one failing test at once.
2. Writing extra code "while I'm here".
3. Refactoring while red.
4. Calling new behavior a refactor.
5. Testing internals instead of observable behavior.
6. New test passes immediately: the behaviour already exists or the test is wrong.
7. Skipping a test because the behavior appears hard to test. Instead:
   - Test what your code **produces** (return values, output, state changes visible through the public API) rather than what an external system does with it.
   - Test through a **higher-level caller** that consumes this behavior and produces observable results.
   - Test through the system's **supported external interface** (API endpoint, CLI invocation, public method) when the behavior is only observable at that level.
   - If none of these work, the behavior genuinely cannot be tested (but that is rare). State why in a code comment in a `TODO:`
8. An issue has multiple acceptance criteria but you wrote one test and implemented everything at once.