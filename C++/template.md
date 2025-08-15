# template

## hoisting

## -Wfatal-errors

## (C++20) requires

## type traits & decay

### type traits

is_reference
is_reference_t
is_const
has_virtual_destructor

### POD related traits

- is_standard_layout
- is_trivial
  - is_trivially_default_constructible
  - is_trivially_copyable
    - is_trivially_copy_constructible
    - is_trivially_copy_assignable
    - is_trivially_move_constructible
    - is_trivially_move_assignable
...

### decay

std::remove_const
std::remove_const_t

``` c++
std::is_same_v<std::remove_const_t<const char* const>, const char*>
```

## SFINAE

- find all possible templates
- try to match all the possible templates with given params
  - substitution failure is not an error.
- report error if none found or multiple (ambiguous) matches are found.

### enable_if

``` c++
template <typename C, typename = enable_if_t<has_reserve<C>::value>> ...

template <typename C>
enable_if_t<has_reserve<C>::value, [[return_type]]> ...

template <typename C>
enable_if_t<has_reserve<C>::value, int = 0> ...

```

### reload with true_type & false_type

## Variac template

### (C++17) folding expressions

## tuple

