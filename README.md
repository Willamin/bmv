# backwards move

`bmv` is used to quickly and painlessly reverse the effects of a `mv` command.
Basic usage is simple:
```sh-session
$ mv source target

$ bmv target source
```

This allows you to simply prepend a previous command with the letter `b` and reverse the effects.

## history passing
Additionally there is the slightly advanced feature of history passing.
History passing allows you to pipe the output of `history` into `bmv`, parse it to discover the most recent usage of `mv`, and automatically run `bmv` with the appropriate arguments.
Currently the parsing of `history` requires a `HISTTIMEFORMAT` of `%F %T `. Future version should allow for taking the current `HISTTIMEFORMAT` into account.

For example
```sh-session
$ ls
source

$ mv source target
$ ls 
target

$ history | bmv
$ ls
source
```

## Contributing

1. Fork it ( https://github.com/willamin/bmv/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [willamin](https://github.com/willamin) Will Lewis - creator, maintainer
