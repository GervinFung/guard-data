Welcome to [Parse Data](https://pub.dev/packages/parse_data), a data parsing tool to parse dynamic data from JSON as inteded type to avoid down-casting and take action if data failed to parse

### Motivation:

I have seen the Final Year Project of my friends, they implicitly down-cast a dynamic data received from JSON.

Which is somewhat ok to me as it's not a dynamic language like JavaScript, Dart will throw `TypeError` when type does not match

My only concern is dealing with unfamiliar or uncertain Third Party API, because run time errors can arise when developer(s) are unsure of the data type, or the data returned can be parsed into different type, for example `{x: 1}` or `{x: '1'}`. In this case, both `x` can be integer of 1 but only one need to be parsed
as int. That's not the main problem, the problem happens when developer expect integer or number, then inevitable run time exception will occur as data can be missing or is of different type

From what I have seen the hidden danger is **down-casting**, be it implicit or explicit

Thus, a tool was written to check the data type of a value and cast it as intended type, otherwise, an alternative value can be returned or an error can be thrown or an alternative action can be carried out. For more info, see [Usage](#usage)

In this case, implicit down-casting is removed and the shape of the data has been parsed accordingly. Hence one can be confident that proper validation has been carried out and it reduce the bugs that could possibly occur

## Features

Parse a dynamic data as boolean, string, number, double, integer and type-specific list

See [example.dart](example/parse_data_example.dart)

## Getting started

## Usage

```dart
late final dynamic json = // some JSON data
// parse
late final booleanParser = Parse(json.isHealthy).asBoolean();

// actions
// 1. Return null if it's truly nullable, I won't recommend to use it to represent emptiness
late final isHealthy = booleanParser.elseGetNull();

// 2. Return alternative value if it cannot be parsed
late final isHealthy = booleanParser.elseGet(false);

// 3. Lazily compute and return alternative value if it's too expenstive to be computed and if value cannot be parsed
late final isHealthy = booleanParser.elseLazyGet(() => false);

// 4. Throw error when you are really sure that the field is the type you want and will always be present in JSON
// Again, I would recommend to use it when you wanna throw an exception with custom message
// As Dart will by default throws `TypeError` if data type doesnt match
late final isHealthy = booleanParser.elseThrow('damn son');

// 5. Return Wrapper to check if it's parseable, if not, then you handle the alternative action
// The main purpose of this function is to provide developer a more flexible way of handling
// the situation themselves, if it cannot be parsed
// NOTE: If you use this, remember to call `isParseable` first
// Otherwise, you will get an exception, whenever `unwrap` is called and it's not parseable
late final booleanWrapper = booleanParser.elseGetWrapper();
if (booleanUnion.isParseable()) {
    late final isHealthy = booleanWrapper.unwrap()
} else {
    // do something else
}
```

## Additional information

You can find me at [Github](https://github.com/GervinFung)

You can also find the source code of this repo by clicking [here](https://github.com/P-YNPM/parse-data)

Also, you can contribute if you want to, just

1. Create and commit to a new branch
2. Write test code
3. Create a Pull Request

**OR**

You can raise issue(s) if you prefer that way
