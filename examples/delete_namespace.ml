open Kubecaml
open Lwt.Infix

let delete_options =
  let open Kubernetes.Definitions.Apimachinery.Pkg.Apis.Meta.V1 in
  Delete_options.create ()

let delete_namespace ~name uri =
  Kubernetes.Api.V1.Namespaces.By_name.delete ~name ~body:delete_options uri
  >|= function
  | Ok ns ->
      ns
      |> Kubernetes.Definitions.Apimachinery.Pkg.Apis.Meta.V1.Status.to_yojson
      |> Yojson.Safe.to_string
  | Error e ->
      e

let () =
  let uri = Uri.of_string "http://localhost:8080" in
  Lwt_main.run (delete_namespace ~name:"ocaml" uri >>= Lwt_io.printlf "%s")
