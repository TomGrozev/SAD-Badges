use Distillery.Releases.Config,
    default_release: :default,
    default_environment: Mix.env()

environment :dev do
  set dev_mode: true
  set include_erts: false
end

environment :prod do
  set include_erts: true
  set include_src: false
end

release :badges do
  set version: current_version(:badges)
  set commands: [
    "migrate": "rel/commands/migrate.sh"
  ]
  set cookie: "badges-v0.5.0"
end
