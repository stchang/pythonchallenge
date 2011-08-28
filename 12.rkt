#lang racket

(define p (open-input-file "12/evil2.gfx" #:mode 'binary))

(define bs1 null)
(define bs2 null)
(define bs3 null)
(define bs4 null)
(define bs5 null)

(let loop ()
  (let* ([b1 (read-byte p)]
         [b2 (read-byte p)]
         [b3 (read-byte p)]
         [b4 (read-byte p)]
         [b5 (read-byte p)])
    (unless (and (eof-object? b1)
                 (eof-object? b2)
                 (eof-object? b3)
                 (eof-object? b4)
                 (eof-object? b5))
              (set! bs1 (cons b1 bs1))
              (set! bs2 (cons b2 bs2))
              (set! bs3 (cons b3 bs3))
              (set! bs4 (cons b4 bs4))
              (set! bs5 (cons b5 bs5))
              (loop))))

(define o1 (open-output-file "12/out1.gif" #:exists 'replace))
(define o2 (open-output-file "12/out2.gif" #:exists 'replace))
(define o3 (open-output-file "12/out3.gif" #:exists 'replace))
(define o4 (open-output-file "12/out4.gif" #:exists 'replace))
(define o5 (open-output-file "12/out5.gif" #:exists 'replace))
  
(write-bytes (apply bytes (reverse bs1)) o1)
(write-bytes (apply bytes (reverse bs2)) o2)
(write-bytes (apply bytes (reverse bs3)) o3)
(write-bytes (apply bytes (reverse bs4)) o4)
(write-bytes (apply bytes (reverse bs5)) o5)

(close-output-port o1)
(close-output-port o2)
(close-output-port o3)
(close-output-port o4)
(close-output-port o5)

(close-input-port p)