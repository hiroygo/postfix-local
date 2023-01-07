package main

import (
	"fmt"
	"net/smtp"
)

func main() {
	c, err := smtp.Dial("localhost:8080")
	if err != nil {
		panic(err)
	}
	// MAIL FROM
	if err := c.Mail("foo@test.localhost"); err != nil {
		panic(err)
	}
	// RCPT TO
	if err := c.Rcpt("root@recv.localhost"); err != nil {
		panic(err)
	}
	// DATA
	err = func() error {
		data := `From: foo@test.localhost
Subject: TEST
HELLO
`

		w, err := c.Data()
		if err != nil {
			return err
		}
		defer w.Close()
		_, err = fmt.Fprintf(w, data)
		if err != nil {
			return err
		}
		return nil
	}()
	if err != nil {
		panic(err)
	}

	// QUIT
	err = c.Quit()
	if err != nil {
		panic(err)
	}
}
