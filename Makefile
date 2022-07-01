.PHONY: test build

test:
	dart test

build:
	dart build

run:
	dart run example/parse_data_example.dart

format:
	dart format .

analyze:
	dart analyze

fix:
	dart fix --apply
