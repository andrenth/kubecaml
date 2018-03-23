open Kubecaml
open Lwt.Infix

let namespace =
  let metadata =
    Kubernetes.Definitions.Apimachinery.Pkg.Apis.Meta.V1.Object_meta.create
      ~name:"ocaml"
      ~labels:[("name", "ocaml")] () in
  Kubernetes.Definitions.Api.Core.V1.Namespace.create
    ~metadata
    ~kind:"Namespace"
    ~api_version:"v1" ()

let create_namespace ~namespace uri =
  Kubernetes.Api.V1.Namespaces.post
    ~body:namespace
    uri
  >|= function
  | Ok ns ->
      ns
      |> Kubernetes.Definitions.Api.Core.V1.Namespace.to_yojson
      |> Yojson.Safe.to_string
  | Error e ->
      e

let () =
  let uri = Uri.of_string "http://localhost:8080" in
  Lwt_main.run (create_namespace ~namespace uri >>= Lwt_io.printlf "%s")
