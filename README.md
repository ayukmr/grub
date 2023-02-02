<img src="media/logo.png" alt="grub logo" width="150" align="right">

# `grub` - GitHub README Universal Browser
### `grub` is a command-line tool for viewing Markdown with GitHub's styles.

## Usage
`grub` is easy to use and has no configuration.

Serve a file to your browser with one command:
```sh
$ grub README.md
```

## Changing the port
If you want, you can change the port that `grub` uses to serve the webpage.

Add the port to the `grub` command after the file:
```sh
$ grub README.md 8080
```

With that command, `grub` will serve the file on localhost:8080 instead of the normal port.
