use std::fs;
use std::fs::File;
use std::io::{self, BufRead};
use std::path::Path;

struct LineResult {
    first_num: i32,
    last_num: i32,
}

fn process_num(res: &mut LineResult, num: i32) {
    if res.first_num == -1 {
        res.first_num = num;
        res.last_num = num;
    } else {
        res.last_num = num;
    }
}

/***
 * find first and last digit in a string, concat them together to form a two digit number
 * if only one digit is present then the first and last digit are the same
 */
fn find_line_number(line: &str) -> i32 {
    let mut chars = line.chars();
    let mut results: LineResult = LineResult {
        first_num: -1,
        last_num: -1,
    };
    //let mut first_num: i32 = -1;
    //let mut last_num: i32 = -1;
    while let Some(c) = chars.next() {
        if c.is_numeric() {
            process_num(&mut results, c.to_digit(10).unwrap() as i32);
        }
    }
    if results.first_num == -1 {
        panic!("no numbers found {}", line);
    } else {
        return results.first_num * 10 + results.last_num;
    }
}

fn main() {
    println!("Hello, world!");
    let mut sum = 0;

    //parse and replace string numbers
    let file_as_string = fs::read_to_string("./input_small.txt").expect("Unable to read file");
    let result = file_as_string.to_lowercase().replace("zero", "0");
    let result = result.replace("one", "1");
    let result = result.replace("two", "2");
    let result = result.replace("three", "3");
    let result = result.replace("four", "4");
    let result = result.replace("five", "5");
    let result = result.replace("six", "6");
    let result = result.replace("seven", "7");
    let result = result.replace("eight", "8");
    let result = result.replace("nine", "9");
    println!("{}", result);

    for line in result.lines() {
        sum += find_line_number(line);
    }
    println!("{}", sum);
}
