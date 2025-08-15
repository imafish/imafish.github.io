# profiling

- `__attribute__((noinline))`
- `benchmark::DoNotOptimize`

- Meyes singeleton


## transparent comparer

```c++
std::map<std::string, _value_type_, std::less<>> mp;
```


## finally

## std::expected<>.and_then()

## std::error_code, std::error_condition, std::error_category

## std::variant

## std::span

## std::range

## optimization

### PGO

1. compile with `--profile-generate`
2. run
3. re-compile with `--profiling-use`

### LTO

1. compile and link with same -glto and -On

### assembly

(gcc): `-S` `-masm=intel / att`

## fmt::print
