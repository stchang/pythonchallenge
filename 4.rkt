#lang racket

(require net/url)

(define (get-next-url nothing)
  (string-append "http://www.pythonchallenge.com/pc/def/linkedlist.php?nothing=" nothing))

;; run loop with any "nothing" to start (as string), ie 58765
(define (loop nothing)
  (let* ([p (get-pure-port (string->url (get-next-url nothing)))]
         [txt (read-string 100000 p)]
         [tmp (close-input-port p)]
         [next-nothing (regexp-match #rx"[0-9]+" txt)])
    (if next-nothing
        (begin 
          (printf "nothing = ~a\n" next-nothing)
          (loop (car next-nothing)))
        txt)))