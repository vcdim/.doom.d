;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here


;; machine-specific configrations
(cond
 ;; my laptop
 ((string-equal system-type "darwin")
  (progn
    (setq synology-home-directory "~/SynologyDrive/")
    (toggle-frame-fullscreen)
    )
  )

 ;; office server
 ;; ((string-equal system-type "gnu/linux")
 ;;  (progn
 ;;    (setq synology-home-directory "~/SynologyDrive/")
 ;;    (setq centaur-tabs-modified-marker "•")
 ;;    (toggle-frame-maximized)
 ;;    )
 ;;  )
 ;; company laptop
 ;; ((string-equal system-name "DESKTOP-O8CMASO")
 ;;  (progn
 ;;    (setq synology-home-directory (concat (getenv "HOME") "/SynologyDrive/"))
 ;;    (setq centaur-tabs-modified-marker "•")
 ;;    (toggle-frame-maximized)
 ;;    )
 ;;  )
 ;; home windows
 ;; ((string-equal system-name "USER-20160423BL")
 ;;  (progn
 ;;    (setq synology-home-directory "c:/Users/Administrator/SynologyDrive/")
 ;;    (toggle-frame-maximized)
 ;;    )
 ;;  )
 ;; ;; home2 windows
 ;; ((string-equal system-name "MICRO-906032057")
 ;;  (progn
 ;;    (setq synology-home-directory "d:/SynologyDrive/")
 ;;    (toggle-frame-maximized)
 ;;    (add-to-list 'exec-path "d:/texlive/2019/bin/win32/")
 ;;    (setenv "PATH" (concat "d:/texlive/2019/bin/win32;" (getenv "PATH")))
 ;;    (add-hook 'org-mode-hook (lambda () (set (make-local-variable 'system-time-locale) "C")))
 ;;    )
 ;;  )
 )

;; ----------------
;; zero width space
;; ----------------
(defun insert-zero-width-space () (interactive) (insert-char #x200b))
(defun my-latex-filter-zws (text backend info)
  (when (org-export-derived-backend-p backend 'latex)
    (replace-regexp-in-string "\x200B" "{}" text)))

;; -----------------------
;; org mode specifications
;; -----------------------
(setq my-org-folder (concat synology-home-directory "Life/org/"))
(setq org-log-done 'time)
(setq org-src-tab-acts-natively t)
(setq org-default-notes-file (concat my-org-folder "agenda.org"))
(setq org-agenda-files `(,my-org-folder))
(setq org-bullets-bullet-list '("✏" "§" "•" "▷"))
(setq org-html-checkbox-type 'html)
(setq org-latex-compiler "xelatex")
(setq org-latex-classes '(("beamer" "\\documentclass[presentation]{beamer}"
        ("\\section{%s}" . "\\section*{%s}")
        ("\\subsection{%s}" . "\\subsection*{%s}")
        ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
       ("ctexart" "\\documentclass[10pt, nocap]{ctexart}"
        ("\\section{%s}" . "\\section*{%s}")
        ("\\subsection{%s}" . "\\subsection*{%s}")
        ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
        ("\\paragraph{%s}" . "\\paragraph*{%s}")
        ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
       ("article" "\\documentclass[11pt]{article}"
        ("\\section{%s}" . "\\section*{%s}")
        ("\\subsection{%s}" . "\\subsection*{%s}")
        ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
        ("\\paragraph{%s}" . "\\paragraph*{%s}")
        ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))
       ("report" "\\documentclass[11pt]{report}"
        ("\\part{%s}" . "\\part*{%s}")
        ("\\chapter{%s}" . "\\chapter*{%s}")
        ("\\section{%s}" . "\\section*{%s}")
        ("\\subsection{%s}" . "\\subsection*{%s}")
        ("\\subsubsection{%s}" . "\\subsubsection*{%s}"))
       ("book" "\\documentclass[11pt]{book}"
        ("\\part{%s}" . "\\part*{%s}")
        ("\\chapter{%s}" . "\\chapter*{%s}")
        ("\\section{%s}" . "\\section*{%s}")
        ("\\subsection{%s}" . "\\subsection*{%s}")
        ("\\subsubsection{%s}" . "\\subsubsection*{%s}")))
      )
(eval-after-load 'ox '(add-to-list 'org-export-filter-body-functions 'my-latex-filter-zws))

;; ----------------
;; chinese font fix
;; ----------------
(setq doom-font (font-spec :family "Sarasa Mono SC"))

;; ---------------
;; sidebar configs
;; ---------------
;; neotree
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(doom-themes-neotree-config)
;; treemacs
(setq doom-themes-treemacs-theme "doom-colors")
(doom-themes-treemacs-config)

;; ---------
;; shortcuts
;; ---------
(global-set-key (kbd "<f12>") 'treemacs)
(global-set-key (kbd "C-*") 'insert-zero-width-space)
(global-set-key (kbd "<S-f12>") 'neotree-toggle)
(global-set-key (kbd "<C-M-right>") 'centaur-tabs-forward-tab)
(global-set-key (kbd "<C-M-left>") 'centaur-tabs-backward-tab)
(global-set-key (kbd "<home>") 'beginning-of-line)
(global-set-key (kbd "<end>") 'end-of-line)
(setq-default fill-column 80)
