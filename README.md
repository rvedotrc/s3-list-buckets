s3-list-buckets
===============

List S3 bucket names and their location constraints.

Installation
------------

```
  gem build s3-list-buckets.gemspec
  gem install s3-list-buckets*.gem
```

Use
---

Examples:

```
  # Show all your buckets (just bucket names):
  s3-list-buckets

  # Show buckets, prefixed by the location constraint
  s3-list-buckets --location

  # Show names and location constraints of buckets whose names start with "a"
  # or "b", as json:
  s3-list-buckets --location --json a b
```

See `s3-list-buckets --help` for full help text.

s3-list-buckets can also be used as a Ruby library.  See `bin/s3-list-buckets` for a
guide for how to do this.

