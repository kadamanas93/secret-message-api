package main

import (
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"
)

func TestSecretApi(t *testing.T) {
	tt := []struct {
		name       string
		method     string
		input      string
		want       string
		statusCode int
	}{
		{
			name:       "with secret",
			method:     http.MethodGet,
			input:      "This is a test",
			want:       `{"secret":"This is a test"}`,
			statusCode: http.StatusOK,
		},
		{
			name:       "with bad method",
			method:     http.MethodPost,
			input:      "",
			want:       "Method not allowed",
			statusCode: http.StatusMethodNotAllowed,
		},
	}

	for _, tc := range tt {
		t.Run(tc.name, func(t *testing.T) {
			request := httptest.NewRequest(tc.method, "/secret", nil)
			responseRecorder := httptest.NewRecorder()

			secretsHandler := SecretMessage{tc.input}
			secretsHandler.ServeHTTP(responseRecorder, request)

			if responseRecorder.Code != tc.statusCode {
				t.Errorf("Want status '%d', got '%d'", tc.statusCode, responseRecorder.Code)
			}

			if strings.TrimSpace(responseRecorder.Body.String()) != tc.want {
				t.Errorf("Want '%s', got '%s'", tc.want, responseRecorder.Body)
			}
		})
	}
}

func TestSqlConnection(t *testing.T) {

}
