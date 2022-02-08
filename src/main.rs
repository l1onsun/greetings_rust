mod app;
mod env;
mod routes;
mod template;

#[actix_web::main]
async fn main() -> std::io::Result<()> {
    app::run().await
}
