import gleam/otp/process
import gleam/otp/supervisor
import gleam/result
import gleam/io
import utils/otp.{Worker, init_tagged}
import utils/wrk_demo

fn init(children) {
  io.println(
    "Initialising a demo supervisor, the only child of which shall quit immediately",
  )
  [Worker(wrk_demo.start)]
  |> init_tagged(children)
}

pub fn start1(_) {
  start([], [])
}

pub fn start(_, _) {
  supervisor.start(init)
  //|> result.map(process.pid)
}

pub fn stop(_) {
  supervisor.application_stopped()
}
