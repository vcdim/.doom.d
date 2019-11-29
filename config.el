;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here


;; variables according to different platform or machines
(cond
 ;; this is on my laptop
 ((string-equal system-type "darwin")
  (progn
    (setq synology-home-directory "/Users/gq/SynologyDrive/")
    )
  )
 ;; this is on my server at my office
 ((string-equal system-type "gnu/linux")
  (progn
    (setq synology-home-directory "/home/gq/SynologyDrive/")
    )
  )
 ;; this is on my company laptop
 ((string-equal system-name "DESKTOP-O8CMASO")
  (progn
    (setq synology-home-directory "c:/Users/310251319/SynologyDrive/")
    )
  )
 ;; this is on other windows platforms
 ((string-equal system-type "windows-nt")
  (progn
    (setq synology-home-directory "d:/SynologyDrive/")
    )
  )
 )

(setq my-work-folder (concat synology-home-directory "Work/"))
(setq my-life-folder (concat synology-home-directory "Life/"))
(setq my-study-folder (concat synology-home-directory "Study/"))
(setq my-org-folder (concat synology-home-directory "Life/org/"))

(setq org-src-tab-acts-natively t)
(setq org-default-notes-file (concat my-org-folder "agenda.org"))
(setq org-agenda-files `(,my-org-folder))

(setq doom-font (font-spec :family "Inconsolata for Powerline"))
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset (font-spec :family "Sarasa Mono SC")))

(defun insert-zero-width-space () (interactive) (insert-char #x200b))
(global-set-key (kbd "C-*") 'insert-zero-width-space)
(global-set-key (kbd "<f12>") 'treemacs)