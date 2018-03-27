open Kubecaml
open Lwt.Infix

let list_namespaces uri =
  Kubernetes.Api.V1.Namespaces.get uri >|= function
  | Ok ns ->
      ns
      |> Kubernetes.Definitions.Api.Core.V1.Namespace_list.to_yojson
      |> Yojson.Safe.to_string
  | Error e ->
      e

let () =
  let uri = Uri.of_string "http://localhost:8080" in
  Lwt_main.run (list_namespaces uri >>= Lwt_io.printlf "%s")
