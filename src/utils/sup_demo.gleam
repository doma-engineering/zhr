import gleam/otp/process
import gleam/otp/supervisor
import gleam/result
import gleam/io
import utils/otp.{Worker, init_tagged}
import utils/wrk_demo
import utils/wrk_demo.{Tick}

fn init(children) {
  io.println("Initialising a demo supervisor")
  [Worker(wrk_demo.start)]
  |> init_tagged(children)
}

pub fn start1(_) {
  start([], [])
}

pub fn start(_, _) {
  assert Ok(snd) = supervisor.start(init)
  snd
  |> process.send(Tick)
  Ok(snd)
}

pub fn stop(_) {
  supervisor.application_stopped()
}
