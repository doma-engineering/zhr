import gleam/otp/supervisor.{add, worker}
import gleam/list
import gleam/otp/process
import gleam/result
import zhr

fn init(children) {
  [zhr.start]
  |> list.fold(
    children,
    fn(acc, x) {
      acc
      |> add(worker(x))
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
