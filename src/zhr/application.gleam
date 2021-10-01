import gleam/list
import gleam/otp/process
import gleam/otp/supervisor
import gleam/result
import zhr
import utils/otp.{Supervisor, Worker, init_tagged}
import utils/sup_demo

fn init(children) {
  [Worker(zhr.start), Supervisor(sup_demo.start1)]
  |> init_tagged(children)
}

pub fn start(_, _) {
  supervisor.start(init)
  |> result.map(process.pid)
}

pub fn stop(_) {
  supervisor.application_stopped()
}
