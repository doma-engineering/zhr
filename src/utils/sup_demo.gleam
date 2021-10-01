import gleam/otp/process
import gleam/otp/actor
import gleam/otp/supervisor
import gleam/result
import gleam/io
import utils/wrk_demo
import utils/wrk_demo.{Tick}
import gleam/list
import gleam/otp/supervisor.{add, worker}

fn init(children) {
  io.println("Initialising a demo supervisor")
  [wrk_demo.start]
  |> list.fold(
    children,
    fn(acc, x) {
      acc
      |> add(worker(x))
    },
  )
}

pub fn start1(_) {
  start([], [])
}

pub fn start(_, _) {
  assert Ok(snd) = supervisor.start(init)
  snd
  |> actor.send(Tick)
  Ok(snd)
}

pub fn stop(_) {
  supervisor.application_stopped()
}
