use actix_web::{middleware, web, App, HttpRequest, HttpServer, Responder};

use crate::{env::Env, routes};

pub async fn run() -> Result<(), std::io::Error> {
    let env = env_or_panic();
    setup_logging(&env);

    HttpServer::new(|| {
        App::new()
            .wrap(middleware::Logger::default())
            .service(routes::index)
            .service(routes::greet)
            .service(actix_files::Files::new("/static", "./static"))
            .default_service(
                web::route().to(|_req: HttpRequest| "not found".respond_to(&_req)),
            )
    })
    .bind((env.host.as_str(), env.port))
    .expect(format!("can't bind app to {}:{}", env.host, env.port).as_str())
    .run()
    .await
}

fn env_or_panic() -> Env {
    envy::from_env().expect("can't read env")
}

fn setup_logging(env: &Env) {
    flexi_logger::Logger::try_with_str(env.log_filter.as_str())
        .expect(format!("can't filter with {}", env.log_filter).as_str())
        .start()
        .expect("can't start flexi_logger");
}
