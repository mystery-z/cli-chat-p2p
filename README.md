# cli-chat-p2p

#protocol
TCP-type handshake to initiate P2P packet exchange.
Once consented, packets are free to be exchanged
Per-packet acknowledgement will not occur
JSON will contain the following:
- Timestamp
- Message type (text, file, etc?)
- Message

#Planning


### How the packets will work:

So we have a library (smoltcp) that handles TCP packets etc.

But there is a default-included package [std::net](https://doc.rust-lang.org/std/net/index.html) including some seemingly useful structs “TcpListener” and “TcpStream” which allow to both send and receive data with the option to deny/allow connections from a certain IP address. This seems adequate enough to build around, and to add on, this package actually HANDLES TCP IN ITS ENTIRETY as in it handles packet loss etc.

If you ask me, no need to include smoltcp as a dependency. Just build around this standard included lib

Packets are sent by std::io::write.() to the created stream, like so:

```rust
fn main() -> std::io::Result<()> {
    let mut stream = TcpStream::connect("xxx.xxx.xxx.xxx:xxxxx")?; //init connection w ip address AND PORT. DO NOT FORGOR TO SPECIFY XD

    stream.write(&[1])?;
    stream.read(&mut [0; 128])?;
    Ok(()) //returns ok to error stream (std::io::Result) if all goes well
}
```

### Data Contained in the Packets

The data will be contained inside of an encrypted json file

```json
{
time: "1650980748",
data:{
			string: "message",
			file: "file.txt"
		}
}
```

`Time` will sent in Unix Time format

- Unix Time can be retrieved through `std::time::SystemTime`
- The Unix Time will need to be formatted client side due to timezones
- and also unix time is just better than other shit - notRamji

Usage for Chrono: [https://docs.rs/chrono/0.4.0/chrono/struct.DateTime.html](https://docs.rs/chrono/0.4.0/chrono/struct.DateTime.html)

### Prevention of Packet Loss

Handled by [std::net](https://doc.rust-lang.org/std/net/index.html) by default 

### Interface

For the interface we can just do a simple input from cmd / terminal kinda thing, like this:

```rust
use std::io;

fn main() {
    let mut msg_01 = String::new(); // makes a mutable variable with type string
    println!(">>");
    io::stdin().read_line(&mut msg_01); //to get input from the user
```

Just for simplicity, I made the string mutable just because then we can reuse the variable, and this is also appr more efficient for memory.

Also, std::io is a default in Rust, and is included so we probs don’t need to install anything for this

This is encoded it in UTF-08 format.

### From input to .json file


I found two options for this: we can either follow [this](https://www.educba.com/rust-json/) tutorial

Or we can use [JFS](https://www.reddit.com/r/rust/comments/9e793y/question_best_way_to_append_data_to_a_json_file/)

