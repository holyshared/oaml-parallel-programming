let num_domains = int_of_string Sys.argv.(1)
let n = int_of_string Sys.argv.(2)

let rec fib n = if n < 2 then 1 else fib (n - 1) + fib (n - 2)

module Task = Domainslib.Task

let rec fib_par pool n =
  if n > 20 then begin
    let a = Task.async pool (fun _ -> fib_par pool (n-1)) in
    let b = Task.async pool (fun _ -> fib_par pool (n-2)) in
    Task.await pool a + Task.await pool b
  end else fib n

let main () =
  let pool = Task.setup_pool ~num_domains:(num_domains - 1) () in
  let res = Task.run pool (fun _ -> fib_par pool n) in
  Task.teardown_pool pool;
  Printf.printf "fib(%d) = %d\n" n res

let _ = main ()
