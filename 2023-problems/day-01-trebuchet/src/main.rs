use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;

// The output is wrapped in a Result to allow matching on errors
// Returns an Iterator to the Reader of the lines of the file.
fn read_lines<P>(filename: P) -> io::Result<io::Lines<io::BufReader<File>>>
where
    P: AsRef<Path>,
{
    let file = File::open(filename)?;
    Ok(io::BufReader::new(file).lines())
}

/***
 * find first and last digit in a string, concat them together to form a two digit number
 * if only one digit is present then the first and last digit are the same
 */
fn find_line_number(line: &str) -> i32 {
    let mut chars = line.chars();
    let mut first_num: i32 = -1;
    let mut last_num: i32 = -1;
    while let Some(c) = chars.next() {
        if c.is_numeric() {
            if first_num == -1 {
                first_num = c.to_digit(10).unwrap() as i32;
                last_num = first_num;
            } else {
                last_num = c.to_digit(10).unwrap() as i32;
            }
        }
    }
    if first_num == -1 {
        panic!("no numbers found {}", line);
    } else {
        return first_num * 10 + last_num;
    }
}

fn main() {
    println!("Hello, world!");
    let mut sum = 0;

    if let Ok(lines) = read_lines("./input.txt") {
        // Consumes the iterator, returns an (Optional) String
        for line in lines {
            if let Ok(input) = line {
                sum += find_line_number(input.as_str());
            }
        }
    }
    println!("{}", sum);
}
