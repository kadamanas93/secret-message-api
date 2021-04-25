package main

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"net/http"
	"os"

	"github.com/go-sql-driver/mysql"
	log "github.com/sirupsen/logrus"
)

type SecretMessage struct {
	Secret string
}

type DB struct {
	db *sql.DB
}

func (d *DB) setUpSql() {
	// DB Configuration params
	db_user, ok := os.LookupEnv("DB_USER")
	if !ok {
		log.Warn("No sql username provided in env var DB_USER")
	}
	db_password, ok := os.LookupEnv("DB_PASSWORD")
	if !ok {
		log.Warn("No sql password provided in env var DB_PASSWORD")
	}
	db_url, ok := os.LookupEnv("DB_URL")
	if !ok {
		log.Warn("No sql url provided in env var DB_URL")
	}

	sqlConfig := mysql.NewConfig()
	sqlConfig.User = db_user
	sqlConfig.Passwd = db_password
	sqlConfig.Addr = db_url

	db, err := sql.Open("mysql", sqlConfig.FormatDSN())
	if err != nil {
		log.Warn(err)
	}

	d.db = db

	// Close db connection for now
	d.db.Close()
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

	db := DB{}
	db.setUpSql()

	handleRequests()
}
