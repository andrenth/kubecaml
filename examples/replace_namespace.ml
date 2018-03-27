open Kubecaml
open Lwt.Infix

let replacement =
  let metadata =
    Kubernetes.Definitions.Apimachinery.Pkg.Apis.Meta.V1.Object_meta.create
      ~name:"ocaml"
      ~labels:[("name", "ocaml"); ("replacement", "true")] () in
  Kubernetes.Definitions.Api.Core.V1.Namespace.create
    ~metadata
    ~kind:"Namespace"
    ~api_version:"v1" ()

let replace_namespace ~name ~replacement uri =
  Kubernetes.Api.V1.Namespaces.By_name.put
    ~name
    ~body:replacement
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
  replace_namespace ~name:"ocaml" ~replacement uri
  >>= Lwt_io.printlf "%s"
  |> Lwt_main.run
