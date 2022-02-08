use std::{borrow::Cow, fs::File, io::BufReader};

use actix_web::{get, HttpRequest, Responder};

use crate::template::{HelloTemplate, ToHtmlResponse};

#[get("/")]
pub async fn index(_req: HttpRequest) -> impl Responder {
    serde_json::from_reader::<_, HelloTemplate>(BufReader::new(File::open(
        "default_survey_config.json",
    )?))?
    .to_html_response()
}

#[get("/{name}")]
pub async fn greet(req: HttpRequest) -> impl Responder {
    let name = match req.match_info().get("name") {
        Some(name) => Cow::Borrowed(name),
        None => Cow::Owned(generate_name()),
    };
    format!("Hello {}!", name)
}

fn generate_name() -> String {
    lipsum::lipsum_title().to_lowercase().replace(" ", "_")
}
