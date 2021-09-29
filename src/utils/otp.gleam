import gleam/otp/supervisor.{add, supervisor, worker}
import gleam/otp/actor.{StartError}
import gleam/otp/process.{Sender}
import gleam/list

/// Tagged OTP starters
pub type Starter(a, msg) {
  // Gleam-OTP-compliant wrapper for supervisors' start/1
  Supervisor(fn(a) -> Result(Sender(msg), StartError))
  // Gleam-OTP-compliant wrapper for workers' start/1
  Worker(fn(a) -> Result(Sender(msg), StartError))
}

///
pub fn init_tagged(children0) {
  fn(children1) {
    children1
    |> list.fold(children0, fn(acc, x) { add(acc, add_tagged_child(x)) })
  }
}

fn add_tagged_child(x: Starter(a, msg)) {
  case x {
    Supervisor(f) -> supervisor(f)
    Worker(f) -> worker(f)
  }
}
