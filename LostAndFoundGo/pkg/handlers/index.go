package handlers

import (
	"html/template"
	"log"
	"net/http"
)

type IndexHandler struct {
	lg *log.Logger
}

func NewIndexhandler(l *log.Logger) *IndexHandler {
	return &IndexHandler{lg: l}
}
func (i *IndexHandler) ServeHTTP(rw http.ResponseWriter, r *http.Request) {
	tmpl, err := template.ParseFiles("index.html")

	if err != nil {
		i.lg.Fatal(err)
		http.Error(rw, "", http.StatusInternalServerError)
	}
	tmpl.Execute(rw, nil)
}
