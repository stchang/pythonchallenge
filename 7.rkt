#lang racket


;; not working -- run and see


(define (read-chunk p)
  (printf "chunk: ")
  (define length-bytes (reverse (bytes->list (read-bytes 4 p))))
  (for-each displayln length-bytes)
  (define length (+ (first length-bytes)
                    (* (second length-bytes) 255)
                    (* (third length-bytes) 255 255)
                    (* (fourth length-bytes) 255 255 255)))
  (printf "~a bytes, " length)
  (define type-bytes (bytes->list (read-bytes 4 p)))
  (define type (apply string (map integer->char type-bytes)))
  (printf "type: ~a\n" type)
  (define data-bytes (bytes->list (read-bytes length p)))
  (read-bytes 4 p))
  

(define p (open-input-file "7/oxygen.png" #:mode 'binary))


;; A PNG file starts with an 8-byte signature. 
;; The hexadecimal byte values are 89 50 4E 47 0D 0A 1A 0A; 
;; the decimal values are 137 80 78 71 13 10 26 10
(define header (read-bytes 8 p))
(let loop ()
  (unless (eof-object? (peek-bytes 1 0 p))
    (read-chunk p)
    (loop)))


(close-input-port p)

#;(let loop ([bs bs])
  (when (= (first bs) (second bs) (third bs))
    (printf "~a\n" (integer->char (first bs))))
  (unless (= 3 (length bs))
    (loop (cdr bs))))
      