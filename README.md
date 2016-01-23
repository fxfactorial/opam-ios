
# opam-ios

This repository contains a compiler for OCaml on iOS.

# Usage

First create a fresh switch, it must be 4.02.0:

**NOTE** This is important, installation of `ocaml-xarm` is a
 destructive operation.

```shell
$ opam switch -A ios 4.02.0
```

Then add this repository with:

```shell
$ opam repository add ios git://github.com/fxfactorial/opam-ios
```

Now do:

**NOTE** This is a destructive install, hence I told you to make a
separate switch for this install.

```shell
$ opam install ocaml-xarm
```

Now you can compile OCaml that will run on the iPhone!

# Example

Here is a stupid server, mostly useful to show how one can use the
Unix module with no problem on the iPhone.

```ocaml
 1  open UnixLabels
 2  
 3  let () =
 4    let sock = socket ~domain:PF_INET ~kind:SOCK_STREAM ~protocol:0 in
 5    bind sock ~addr:(ADDR_INET (inet_addr_any, 3000));
 6    print_endline "About to listen";
 7    listen sock 5;
 8    let resp = "Thanks for the Test!\n" in
 9    while true do
10      let (listen_sock, listen_addr) = accept sock in
11      let buf = String.create 255 in
12      (ignore (read listen_sock ~buf ~pos:0 ~len:255));
13      print_endline buf;
14      (ignore @@ write listen_sock ~buf:resp ~pos:0 ~len:(String.length resp - 1));
15      Unix.close listen_sock
16    done
```

Compile with:

```shell
$ ocamloptrev -rev 8.3 unix.cmxa server.ml -o The_server
```

The -rev 8.3 refers to the iOS SDK. In this example I compiled for
8.3, note that this is just for paths, it will actually look for a
path like /Applications/Xcode.app&#x2026; Funny enough, even though this
was for 8.3, the code will work below that as well, I tested it on 8.3
and iOS 7.1.

And here's an example of it working:

![img](./working_server.gif)

# Acknowledgments

The real heroes are Gerd Stolpmann, awesome guys at
Psellos.com; special shout out to Jeffrey Scofield.