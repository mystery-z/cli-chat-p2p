use std::time::SystemTime;
use chrono::prelude::*;


fn main() {
    get_real_time(get_unix_time());

    // println!("{}", time)
}

fn get_unix_time() -> i64{
    let _time_now = SystemTime::now().duration_since(SystemTime::UNIX_EPOCH);

    match SystemTime::now().duration_since(SystemTime::UNIX_EPOCH) {
        Ok(n) => n.as_secs().try_into().unwrap(),
        Err(_) => panic!("SystemTime before UNIX EPOCH!"),
    }
}

fn get_real_time(_unix_time: i64){
    let naive = NaiveDateTime::from_timestamp(_unix_time.into(), 0);
    
    let datetime: DateTime<Utc> = DateTime::from_utc(naive, Utc);
    
    let timeUnstructured = datetime.format("%Y %m %d %H %M %S");
    let timeFormatted = format!("{}", timeUnstructured);
    let time = timeFormatted.split(" ").collect::<Vec<_>>();


    println!("{:?}", time);
}
