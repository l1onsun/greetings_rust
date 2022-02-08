#[derive(serde::Deserialize, Debug)]
pub struct Env {
    pub host: String,
    pub port: u16,
    pub log_filter: String,
}
