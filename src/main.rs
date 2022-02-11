mod app;
mod env;
mod routes;
mod templates;

#[actix_web::main]
async fn main() {
    app::run_or_panic().await
}
