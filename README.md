Welcome to [Guard Data](https://pub.dev/packages/guard_data), a data guarding tool to guard dynamic data from JSON as inteded type after validating the data type to avoid implicit down-guarding and take action if data type is not the intended type and thus cannot be guarded

### Motivation:

I have seen the Final Year Project of my friends, they implicitly down-guard a dynamic data received from JSON.

Which is somewhat ok to me as it's not a dynamic language like JavaScript, Dart will throw `TypeError` when type does not match

My only concern is dealing with unfamiliar or uncertain Third Party API, because run time errors can arise when developer(s) are unsure of the data type, or the data returned can be guarded into different type, for example `{x: 1}` or `{x: '1'}`. In this case, both `x` can be integer of 1 but only one need to be guarded
as int. That's not the main problem, the problem happens when developer expect integer or number, then inevitable run time exception will occur as data can be missing or is of different type

From what I have seen the hidden danger is down-guarding **without data validation**

Thus, a tool was written to check the data type of a value and guard it as intended type, otherwise, an alternative value can be returned or an error can be thrown or an alternative action can be carried out. For more info, see [Usage](#usage)

In this case, data validation has been carried out and the shape of the data has been guarded accordingly. Hence one can be confident that proper validation has been carried out and it reduce the bugs that could possibly occur

## Features

Guard a dynamic data as boolean, string, number, double, integer, type-specific list or group a property as an object

See [example.dart](example/guard_data_example.dart)

## Getting started

## Usage

```dart
final dynamic json = // some JSON data
// guard
final booleanGuarder = Guard(json.isHealthy).asBoolean();

// actions
// 1. Return null if it's truly nullable, I won't recommend to use it to represent emptiness
final isHealthy = booleanGuarder.elseGetNull();

// 2. Return alternative value if it cannot be guarded
final isHealthy = booleanGuarder.elseGet(false);

// 3. Lazily compute and return alternative value if it's too expenstive to be computed and if value cannot be guarded
final isHealthy = booleanGuarder.elseLazyGet(() => false);

// 4. Throw error when you are really sure that the field is the type you want and will always be present in JSON
// Again, I would recommend to use it when you wanna throw an exception with custom message
// As Dart will by default throws `TypeError` if data type doesnt match
final isHealthy = booleanGuarder.elseThrow('damn son');

// 5. Return Wrapper to check if it's guardable, if not, then you handle the alternative action
// The main purpose of this function is to provide developer a more flexible way of handling
// the situation themselves, if it cannot be guarded
// NOTE: If you use this, remember to call `isGuardable` first
// Otherwise, you will get an exception, whenever `unwrap` is called and it's not guardable
final booleanWrapper = booleanGuarder.elseGetWrapper();
if (booleanUnion.isGuardable()) {
    final isHealthy = booleanWrapper.unwrap()
} else {
    // do something else
}
```

## Additional information

You can find me at [Github](https://github.com/GervinFung)

You can also find the source code of this repo by clicking [here](https://github.com/P-YNPM/guard-data)

Also, you can contribute if you want to, just

1. Create and commit to a new branch
2. Write test code
3. Create a Pull Request

**OR**

You can raise issue(s) if you prefer that way
