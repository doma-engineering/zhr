import gleam/list
import gleam/otp/process
import gleam/otp/supervisor
import gleam/result
import zhr
import gleam/otp/supervisor.{add, supervisor, worker}
import utils/sup_demo

fn init(children) {
  let children1 =
    [zhr.start]
    |> list.fold(
      children,
      fn(acc, x) {
        acc
        |> add(worker(x))
      },
    )
  [sup_demo.start1]
  |> list.fold(
    children1,
    fn(acc, x) {
      acc
      |> add(supervisor(x))
    },
  )
}

pub fn start(_, _) {
  supervisor.start(init)
  |> result.map(process.pid)
}

pub fn stop(_) {
  supervisor.application_stopped()
}
