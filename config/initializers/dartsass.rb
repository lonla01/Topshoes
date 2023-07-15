Rails.application.config.dartsass.builds = {
    "application.scss" => "application.css",
    "slick.scss"       => "slick.css"
}

Rails.application.config.dartsass.build_options << " --quiet-deps"
