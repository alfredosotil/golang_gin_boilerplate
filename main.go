package main

import (
	"fmt"
	"log"
	"os"

	"basic_server/docs"
	"basic_server/server"
	"basic_server/server/db"

	"github.com/joho/godotenv"
)

// @title Gin Demo App
// @version 1.0
// @description This is a demo version of Gin app.

// @contact.name Alfredo Sotil P.
// @contact.url https://www.linkedin.com/in/alfredo-antonio-sotil-pastor-9651837b/
// @contact.email alfredosotil@gmail.com

// @securityDefinitions.apikey ApiKeyAuth
// @in header
// @name Authorization

// @BasePath /
func main() {
	if err := godotenv.Load(); err != nil {
		log.Fatal("Error loading .env file")
	}

	connection := db.InitDB()

	defer func() {
		if err := connection.DB().Close(); err != nil {
			log.Print(err)
		}
	}()

	docs.SwaggerInfo.Host = fmt.Sprintf("%s:%s", os.Getenv("HOST"), os.Getenv("EXPOSE_PORT"))

	app := server.NewServer(connection)
	server.ConfigureRoutes(app)

	if err := app.Run(os.Getenv("PORT")); err != nil {
		log.Print(err)
	}
}
