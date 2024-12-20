package main

import (
	"fmt"
	"log"
	"net/http"
)

var BuildVersion = "v0.0"

func main() {
	log.Println("Starting server...2.0")
	http.HandleFunc("/version", version)
	http.ListenAndServe(":3000", nil) //nolint

}

func version(w http.ResponseWriter, r *http.Request) {
	fmt.Fprint(w, BuildVersion)
}
