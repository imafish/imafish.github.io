# bazel

## query

[query guide](https://bazel.build/query/guide)

[query dependencies](https://bazel.build/tutorials/cpp-dependency)

### output path

``` shell
bazel cquery --output=files //your/package:target_name
```

### target dependencies

``` shell
bazel query --notool_deps --noimplicit_deps 'deps(//path/to:target)' --output graph > graph.dot
```

#### view the graph visually

``` shell
sudo apt update && sudo apt install graphviz xdot

# require a graphic interface
xdot graph.dot
```
