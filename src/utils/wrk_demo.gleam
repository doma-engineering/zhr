import gleam/otp/actor.{InitTimeout}
import gleam/otp/process.{new_channel}
import gleam/io

pub fn start(_) {
  io.println("Initialising a demo worker (which shall quit immediately)")
  assert #(snd, _) = new_channel()
  Ok(snd)
  //Error(InitTimeout)
}
