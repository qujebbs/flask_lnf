package main

import (
	"log"
	"net/http"
	"os"

	"github.com/Ollinar/case-study-lost-and-found-go/pkg/handlers"
)

func main() {

	mux := http.NewServeMux()
	lgr := log.New(os.Stdout, "", log.Default().Flags())
	mux.Handle("/", handlers.NewIndexhandler(lgr))
	log.Fatal(http.ListenAndServe(":8080", mux))
}
