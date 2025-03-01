use anyhow::{Context, Result};
use clap::{Parser, ValueEnum};
use hex::encode;
use md5::{Digest as MD5Digest, Md5};
use sha1::{Digest as SHA1Digest, Sha1};
use sha2::{Digest as SHA2Digest, Sha256, Sha512};
use std::fs::File;
use std::io::{BufReader, Read};
use std::path::PathBuf;

#[derive(Debug, Copy, Clone, ValueEnum)]
enum HashAlgorithm {
    Md5,
    Sha1,
    Sha256,
    Sha512,
}

#[derive(Parser)]
#[command(author, version, about = "Calculate file checksum using various hash algorithms")]
struct Cli {
    /// Path to the file to checksum
    #[arg(required = true)]
    file: PathBuf,

    /// Hash algorithm to use
    #[arg(short, long, value_enum, default_value = "sha256")]
    algorithm: HashAlgorithm,

    /// Compare with a known hash (optional)
    #[arg(short, long)]
    compare: Option<String>,
}

fn calculate_hash(path: &PathBuf, algorithm: HashAlgorithm) -> Result<String> {
    let file = File::open(path).context("Failed to open file")?;
    let mut reader = BufReader::new(file);
    
    match algorithm {
        HashAlgorithm::Md5 => {
            let mut hasher = Md5::new();
            let mut buffer = [0; 1024];
            
            while let Ok(count) = reader.read(&mut buffer) {
                if count == 0 {
                    break;
                }
                hasher.update(&buffer[..count]);
            }
            
            let result = hasher.finalize();
            Ok(encode(result))
        }
        HashAlgorithm::Sha1 => {
            let mut hasher = Sha1::new();
            let mut buffer = [0; 1024];
            
            while let Ok(count) = reader.read(&mut buffer) {
                if count == 0 {
                    break;
                }
                hasher.update(&buffer[..count]);
            }
            
            let result = hasher.finalize();
            Ok(encode(result))
        }
        HashAlgorithm::Sha256 => {
            let mut hasher = Sha256::new();
            let mut buffer = [0; 1024];
            
            while let Ok(count) = reader.read(&mut buffer) {
                if count == 0 {
                    break;
                }
                hasher.update(&buffer[..count]);
            }
            
            let result = hasher.finalize();
            Ok(encode(result))
        }
        HashAlgorithm::Sha512 => {
            let mut hasher = Sha512::new();
            let mut buffer = [0; 1024];
            
            while let Ok(count) = reader.read(&mut buffer) {
                if count == 0 {
                    break;
                }
                hasher.update(&buffer[..count]);
            }
            
            let result = hasher.finalize();
            Ok(encode(result))
        }
    }
}

fn main() -> Result<()> {
    let args = Cli::parse();
    
    let hash = calculate_hash(&args.file, args.algorithm)?;
    
    println!("{} ({:?}) = {}", args.file.display(), args.algorithm, hash);
    
    if let Some(expected) = args.compare {
        if expected.eq_ignore_ascii_case(&hash) {
            println!("✅ Hash matches!");
        } else {
            println!("❌ Hash does NOT match!");
            println!("Expected: {}", expected);
            println!("Actual:   {}", hash);
        }
    }
    
    Ok(())
}
