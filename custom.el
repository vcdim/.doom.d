(defface busy-1  '((t :foreground "black" :background "#eceff1")) "")
(defface busy-2  '((t :foreground "black" :background "#cfd8dc")) "")
(defface busy-3  '((t :foreground "black" :background "#b0bec5")) "")
(defface busy-4  '((t :foreground "black" :background "#90a4ae")) "")
(defface busy-5  '((t :foreground "white" :background "#78909c")) "")
(defface busy-6  '((t :foreground "white" :background "#607d8b")) "")
(defface busy-7  '((t :foreground "white" :background "#546e7a")) "")
(defface busy-8  '((t :foreground "white" :background "#455a64")) "")
(defface busy-9  '((t :foreground "white" :background "#37474f")) "")
(defface busy-10 '((t :foreground "white" :background "#263238")) "")

(defadvice calendar-generate-month
  (after highlight-weekend-days (month year indent) activate)
  "Highlight weekend days"
  (dotimes (i 31)
    (let ((date (list month (1+ i) year))
          (count (length (org-agenda-get-day-entries
                          "~/SynologyDrive/Life/org/agenda.org" (list month (1+ i) year)))))
      (cond ((= count 0) ())
            ((= count 1) (calendar-mark-visible-date date 'busy-1))
            ((= count 2) (calendar-mark-visible-date date 'busy-2))
            ((= count 3) (calendar-mark-visible-date date 'busy-3))
            ((= count 4) (calendar-mark-visible-date date 'busy-4))
            ((= count 5) (calendar-mark-visible-date date 'busy-5))
            ((= count 6) (calendar-mark-visible-date date 'busy-6))
            ((= count 7) (calendar-mark-visible-date date 'busy-7))
            ((= count 8) (calendar-mark-visible-date date 'busy-8))
            ((= count 9) (calendar-mark-visible-date date 'busy-9))
            (t  (calendar-mark-visible-date date 'busy-10)))
      )))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("f7216d3573e1bd2a2b47a2331f368b45e7b5182ddbe396d02b964b1ea5c5dc27" "be9645aaa8c11f76a10bcf36aaf83f54f4587ced1b9b679b55639c87404e2499" "7a994c16aa550678846e82edc8c9d6a7d39cc6564baaaacc305a3fdc0bd8725f" "730a87ed3dc2bf318f3ea3626ce21fb054cd3a1471dcd59c81a4071df02cb601" "01cf34eca93938925143f402c2e6141f03abb341f27d1c2dba3d50af9357ce70" "711efe8b1233f2cf52f338fd7f15ce11c836d0b6240a18fffffc2cbd5bfe61b0" "57bd93e7dc5fbb5d8d27697185b753f8563fe0db5db245592bab55a8680fdd8c" "8d7684de9abb5a770fbfd72a14506d6b4add9a7d30942c6285f020d41d76e0fa" "2899018e19d00bd73c10c4a3859967c57629c58a955a2576d307d9bdfa2fea35" "6c3b5f4391572c4176908bb30eddc1718344b8eaff50e162e36f271f6de015ca" "5d09b4ad5649fea40249dd937eaaa8f8a229db1cec9a1a0ef0de3ccf63523014" "9efb2d10bfb38fe7cd4586afb3e644d082cbcdb7435f3d1e8dd9413cbe5e61fc" "2f1518e906a8b60fac943d02ad415f1d8b3933a5a7f75e307e6e9a26ef5bf570" "a3b6a3708c6692674196266aad1cb19188a6da7b4f961e1369a68f06577afa16" "76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" "c4bdbbd52c8e07112d1bfd00fee22bf0f25e727e95623ecb20c4fa098b74c1bd" "d74c5485d42ca4b7f3092e50db687600d0e16006d8fa335c69cf4f379dbd0eee" "37144b437478e4c235824f0e94afa740ee2c7d16952e69ac3c5ed4352209eefb" "99ea831ca79a916f1bd789de366b639d09811501e8c092c85b2cb7d697777f93" "71e5acf6053215f553036482f3340a5445aee364fb2e292c70d9175fb0cc8af7" "f2927d7d87e8207fa9a0a003c0f222d45c948845de162c885bf6ad2a255babfd" "4bca89c1004e24981c840d3a32755bf859a6910c65b829d9441814000cf6c3d0" "990e24b406787568c592db2b853aa65ecc2dcd08146c0d22293259d400174e37" default))
 '(org-capture-templates
   '(("a" "Agenda Inbox" entry
      (file+headline +org-capture-todo-file "Inbox")
      "* TODO %T %?" :prepend t)
     ("j" "Journal" entry
      (file+olp+datetree +org-capture-journal-file)
      "* %U %?" :prepend t))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
