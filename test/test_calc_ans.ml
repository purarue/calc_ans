open OUnit2
open Calc_ans

let tokenize_result_to_tokens res =
  match res with
  | Ok tokens -> tokens |> List.map (fun (tk, _) -> tk)
  | Error _ -> []

let test1 _ =
  let res =
    Calc_ans.tokenize "ans + (1 + 2.0) / 2" |> tokenize_result_to_tokens
  in
  let expected =
    [
      Calc_ans.Ans;
      Op Calc_ans.Plus;
      Calc_ans.LParen;
      Calc_ans.Number (Int 1);
      Op Calc_ans.Plus;
      Calc_ans.Number (Float 2.0);
      Calc_ans.RParen;
      Op Calc_ans.Div;
      Calc_ans.Number (Int 2);
    ]
  in
  assert_equal expected res

let test_eval _ =
  let expr =
    BinOp (Div, BinOp (Plus, Val (Int 1), Val (Float 2.5)), Val (Int 3))
  in
  let res = Calc_ans.eval expr in
  let expected = Ok (Float 1.1666666666666667) in
  assert_equal expected res

let () =
  run_test_tt_main ("test" >::: [ "test1" >:: test1; "test_eval" >:: test_eval ])
