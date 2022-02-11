use actix_web::{Error, HttpResponse};
use serde::{Deserialize, Serialize};

#[derive(Serialize, Deserialize)]
pub struct SurveyTemplateSection {
    pub question: String,
    pub defaults: Vec<String>,
}

#[derive(Serialize, Deserialize, askama::Template)]
#[template(path = "index.html")]
pub struct SurveyTemplate {
    pub title: String,
    pub submit_text: String,
    pub sections: Vec<SurveyTemplateSection>,
}

pub trait ToHtmlResponse {
    fn to_html_response(&self) -> ::std::result::Result<HttpResponse, Error>;
}

impl<T: askama::Template> ToHtmlResponse for T {
    fn to_html_response(&self) -> ::std::result::Result<HttpResponse, Error> {
        Ok(HttpResponse::Ok()
            .content_type("text/html; charset=utf-8")
            .body(self.render().unwrap()))
    }
}
