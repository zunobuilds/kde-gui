use kde_gui::Counter;

fn main() {
    let mut counter = Counter::default();
    for _ in 0..3 {
        assert!(counter.increment());
    }
    assert_eq!(counter.value(), 3);
    assert_eq!(Counter::default().value(), 0);
    println!("Independent Rust consumer: count = {}", counter.value());
}
