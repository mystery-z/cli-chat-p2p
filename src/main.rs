use std::time::SystemTime;
use chrono::prelude::*;

fn main() {
    get_time();
}

fn get_time(){
    // let _time_now = SystemTime::now().duration_since(SystemTime::UNIX_EPOCH);

    // match SystemTime::now().duration_since(SystemTime::UNIX_EPOCH) {
    //     Ok(n) => println!("{}", n.as_secs()),
    //     Err(_) => panic!("SystemTime before UNIX EPOCH!"),
    // }
    let utc: DateTime<Utc> = Utc::now();

    println!("{}", utc)
}