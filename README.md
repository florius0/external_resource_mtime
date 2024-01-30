# ExternalResourceMtime

This repo reproduces the [issue on external_resource mtime-based recompilation](https://github.com/elixir-lang/elixir/issues/13298)

There is two bash scripts, both of them reproduce the problem, but in slightly different way:

- `reproduce.sh` – purely modifies mtimes
- `reproduce_with_caching.sh` – simulates caching (as, i.e. [GitHub's actions/cache](https://github.com/actions/cache/tree/v4/) does  it) & fresh checkout in CI.

Note: reproduction is unstable and should be considered work in progress. However, I was able to get the following result:

With `reproduce.sh`:

```sh
$ ./reproduce.sh

Compiling 1 file (.ex)
Generated external_resource_mtime app
Before mtime modification; should be 42
[nofile:1: (file)]
ExternalResourceMtime.content() #=> "42\n"

Waiting 1 second & Modifying mtime of compile.elixir
After mtime modification; should be 43
[nofile:1: (file)]
ExternalResourceMtime.content() #=> "42\n"

$ cat lib/external_resource
43
```

With `reproduce_with_caching.sh`:

```sh
$ ./reproduce_with_caching.sh
Compiling 1 file (.ex)
Generated external_resource_mtime app
Before mtime modification; should be 42
[nofile:1: (file)]
ExternalResourceMtime.content() #=> "42\n"

Caching _build to _build.tar.gz
Waiting 1 second & Restoring _build from _build.tar.gz
After mtime modification; should be 43
[nofile:1: (file)]
ExternalResourceMtime.content() #=> "42\n"

$ cat lib/external_resource
43
```
