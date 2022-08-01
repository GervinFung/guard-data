.PHONY: test build

test:
	dart test

build:
	dart build

run:
	dart run example/cast_data_example.dart

format:
	dart format .

analyze:
	dart analyze

fix:
	dart fix --apply
