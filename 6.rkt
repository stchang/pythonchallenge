#lang racket

(define (get-next-file nothing)
  (string-append "6/" nothing ".txt"))

;; run loop with any "nothing" to start (as string), ie 90052
(define (loop nothing)
  (let* ([p (open-input-file (get-next-file nothing))]
         [txt (read-string 100000 p)]
         [tmp (close-input-port p)]
         [next-nothing (regexp-match #rx"[0-9]+" txt)])
    (if next-nothing
        (begin 
          (printf "nothing = ~a\n" next-nothing)
          (printf "text = ~a\n" txt)
          (loop (car next-nothing)))
        txt)))