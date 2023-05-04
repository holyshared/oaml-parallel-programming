let n = try int_of_string Sys.argv.(1) with _ -> 1

let rec fib n =
  let open Domain in
  if n < 2 then 1 else begin
    let d1 = spawn (fun _ -> fib (n - 1)) in
    let d2 = spawn (fun _ -> fib (n - 2)) in
    join d1 + join d2
  end

let main () =
  let r = fib n in
  Printf.printf "fib(%d) = %d\n%!" n r

let _ = main ()
