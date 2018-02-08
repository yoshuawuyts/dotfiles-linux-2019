#!/bin/sh

cargo install rustfmt-nightly
cargo install cargo-edit
cargo install clippy
cargo install racer

rustup component add rls-preview rust-analysis rust-src
