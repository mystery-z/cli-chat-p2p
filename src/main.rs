use std::time::SystemTime;


fn main() {
    let _time_now = SystemTime::now().duration_since(SystemTime::UNIX_EPOCH);
    // println!("{}", _time_now.as_secs())

    match SystemTime::now().duration_since(SystemTime::UNIX_EPOCH) {
        Ok(n) => println!("{}", n.as_secs()),
        Err(_) => panic!("SystemTime before UNIX EPOCH!"),
    }
}