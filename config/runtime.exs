import Config

config :d,
  message: System.get_env("D_MESSAGE", "default message"),
  server: !!System.get_env("D_SERVER")
