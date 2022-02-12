use std::{fs::File, io::BufReader};

use actix_web::{get, HttpRequest, Responder};

use crate::templates::askama::{SurveyTemplate, ToHtmlResponse, GreetingTemplate};

#[get("/")]
pub async fn index(_req: HttpRequest) -> impl Responder {
    serde_json::from_reader::<_, SurveyTemplate>(BufReader::new(File::open(
        "default_survey_config.json",
    )?))?
    .to_html_response()
}

#[get("/greet")]
pub async fn greet(_req: HttpRequest) -> impl Responder {
    let template: GreetingTemplate = serde_json::from_reader(BufReader::new(File::open(
        "default_greeting_config.json",
    )?))?;
    template.to_html_response()
}

#[allow(dead_code)]
fn generate_name() -> String {
    lipsum::lipsum_title().to_lowercase().replace(" ", "_")
}
