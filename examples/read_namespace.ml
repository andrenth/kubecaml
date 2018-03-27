open Kubecaml
open Lwt.Infix

let read_namespace ~name uri =
  Kubernetes.Api.V1.Namespaces.By_name.get ~name uri
  >|= function
  | Ok ns ->
      ns
      |> Kubernetes.Definitions.Api.Core.V1.Namespace.to_yojson
      |> Yojson.Safe.to_string
  | Error e ->
      e

let () =
  let uri = Uri.of_string "http://localhost:8080" in
  Lwt_main.run (read_namespace ~name:"ocaml" uri >>= Lwt_io.printlf "%s")
