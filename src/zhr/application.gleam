import gleam/list
import gleam/otp/process
import gleam/otp/supervisor
import gleam/result
import zhr
import utils/otp.{Worker, init_tagged}

fn init(children) {
  [Worker(zhr.start)]
  |> init_tagged(children)
}

pub fn start(_, _) {
  supervisor.start(init)
  |> result.map(process.pid)
}

pub fn stop(_) {
  supervisor.application_stopped()
}
