package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"

	log "github.com/sirupsen/logrus"
)

type SecretMessage struct {
	Secret string
}

func (s *SecretMessage) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	log.Infof("%s %s %s\n", r.RemoteAddr, r.Method, r.URL)
	w.Header().Set("Content-Type", "application/json")

	switch r.Method {
	case http.MethodGet:
		json.NewEncoder(w).Encode(map[string]string{"secret": s.Secret})
	default:
		http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
	}
}

func handleRequests() {
	// Configuration
	var ok bool
	port, ok := os.LookupEnv("PORT")
	if !ok {
		port = "8080"
	}
	secret_message, ok := os.LookupEnv("SECRET_MESSAGE")
	if !ok {
		log.Warn("SECRET_MESSAGE env var was unset, using empty string")
	}

	// API Routes
	secret := SecretMessage{Secret: secret_message}
	http.HandleFunc("/secret", secret.ServeHTTP)

	log.Fatal(http.ListenAndServe(fmt.Sprintf(":%s", port), nil))
}

func main() {
	log.SetFormatter(&log.TextFormatter{
		FullTimestamp: true,
	})
	log.SetOutput(os.Stdout)

	handleRequests()
}
