#lang racket


(define p (open-input-file "7/oxygen.png" #:mode 'binary))

(let loop ([count 0])
  (let ([b (read-byte p)])
    (unless (eof-object? b)
      (when (zero? b)
        (printf "~a\n" count))
      (loop (add1 count)))))
    
(close-input-port p)