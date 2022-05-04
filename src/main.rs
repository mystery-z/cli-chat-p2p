use std::time::SystemTime;
use chrono::prelude::*;
use std::io;


fn main() {
    start_chat();
}

fn get_UTC(){
    // let _time_now = SystemTime::now().duration_since(SystemTime::UNIX_EPOCH);

    // match SystemTime::now().duration_since(SystemTime::UNIX_EPOCH) {
    //     Ok(n) => println!("{}", n.as_secs()),
    //     Err(_) => panic!("SystemTime before UNIX EPOCH!"),
    // }
    let utc: DateTime<Utc> = Utc::now();
    println!("{}", utc);
}

fn get_local(){
	let localtime = chrono::offset::Local::now();
	println!("{:?}", localtime);	
}

fn start_chat(){
	println!("\n---Starting Chat--- \nThe current time in UTC is: ");
	get_UTC();
	
	println!("\nThe current Local time is: ");
	get_local();	
}
