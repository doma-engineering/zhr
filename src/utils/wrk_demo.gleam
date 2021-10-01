import gleam/otp/actor.{Continue, StartError}
import gleam/otp/process.{Sender}
import gleam/io
import gleam/otp/actor

pub type Sound {
  Tick
}

type State {
  Sounds(Int)
}

pub fn start(_) -> Result(Sender(Sound), StartError) {
  io.println("Initialising a demo worker")
  actor.start(
    Sounds(0),
    fn(_, s: State) {
      let Sounds(count) = s
      io.println("Got a message")
      io.println("Now the counter is one bigger")
      Continue(Sounds(count + 1))
    },
  )
}

pub fn start_old(_) -> Result(Sender(Sound), StartError) {
  io.println("Initialising a demo worker")
  actor.start(
    Sounds(0),
    fn(_, s: State) {
      io.println("Got a message")
      case s {
        Sounds(x) -> {
          io.println("Now the counter is one bigger")
          Continue(Sounds(x + 1))
        }
      }
    },
  )
}
