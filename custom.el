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

(eval-after-load 'org
  '(setq org-capture-templates
         '(
           ("j" "Journal" entry
            (file+olp+datetree +org-capture-journal-file)
            "* %U %?" :prepend t)
           ("s" "Study" entry
            (file+headline +org-capture-todo-file "Study")
            "* TODO %T %?" :prepend t)
           ("l" "Life" entry
            (file+headline +org-capture-todo-file "Life")
            "* TODO %T %?" :prepend t)
           ("m" "Michelin")
           ("mm" "Meetings" entry
            (file+headline +org-capture-todo-file "Meetings")
            "* TODO %T %?" :prepend t)
           ("ma" "Michelin Aviation" entry
            (file+headline +org-capture-todo-file "Aviation")
            "* TODO %T %?" :prepend t)
           ("a" "Amazon")
           ("aa" "Amazon" entry
            (file+headline +org-capture-todo-file "Amazon")
            "* TODO %T %?" :prepend t)
           )
        )
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
