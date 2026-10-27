//! Experimental state and components for KDE applications.
//!
//! ```
//! use kde_gui::Counter;
//!
//! let mut counter = Counter::default();
//! assert_eq!(counter.value(), 0);
//! assert!(counter.increment());
//! assert_eq!(counter.value(), 1);
//! ```

#![deny(missing_docs)]

#[cfg(feature = "qt")]
mod qt;

/// An independent counter starting at zero and saturating at [`i32::MAX`].
#[derive(Debug, Default, Clone, PartialEq, Eq)]
pub struct Counter {
    value: i32,
}

impl Counter {
    /// Returns the current value.
    pub fn value(&self) -> i32 {
        self.value
    }

    /// Increments the value, returning whether it changed.
    ///
    /// At [`i32::MAX`], the value remains unchanged and this returns `false`.
    pub fn increment(&mut self) -> bool {
        if self.value == i32::MAX {
            return false;
        }
        self.value += 1;
        true
    }
}

#[cfg(test)]
mod tests {
    use super::Counter;

    #[test]
    fn starts_at_zero() {
        assert_eq!(Counter::default().value(), 0);
    }

    #[test]
    fn repeated_increments_report_changes() {
        let mut counter = Counter::default();
        for expected in 1..=100 {
            assert!(counter.increment());
            assert_eq!(counter.value(), expected);
        }
    }

    #[test]
    fn saturates_without_reporting_another_change() {
        let mut counter = Counter {
            value: i32::MAX - 1,
        };
        assert!(counter.increment());
        assert_eq!(counter.value(), i32::MAX);
        assert!(!counter.increment());
        assert_eq!(counter.value(), i32::MAX);
    }

    #[test]
    fn instances_are_independent() {
        let mut first = Counter::default();
        let second = Counter::default();
        first.increment();
        assert_eq!(second.value(), 0);
    }
}
