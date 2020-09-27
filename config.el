;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here


;; machine-specific configrations
(cond
 ;; my laptop
 ((string-equal system-type "darwin")
  (progn
    (setq synology-home-directory "~/SynologyDrive/")
    (setenv "PATH" (concat "/Users/gq/software/flutter/bin:" (getenv "PATH")))
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
(cnfonts-enable)
(setq cnfonts-personal-fontnames
      '(("Victor Mono" "Sarasa Mono SC" "Cascadia Code")
        ()
        ()))
;; ----------
;; load theme
;; ----------
(load-theme 'doom-one-light t)
;; -------------------
;; doc-view resolution
;; -------------------
(setq doc-view-resolution 200)

;; ------------------------------
;; specific file-open application
;; ------------------------------
(setq org-file-apps
      '(("\\.pdf::\\([[:digit:]]+\\)\\'" lambda
        (_file link)
        (org-pdfview-open link))
       ("\\.pdf\\'" lambda
        (_file link)
        (org-pdfview-open link))
       (directory . emacs)
       (auto-mode . emacs)
       ("\\.mm\\'" . default)
       ("\\.x?html?\\'" . default)
       ("\\.pptx?\\'" . system)
       ("\\.docx?\\'" . system)
       ("\\.xlsx?\\'" . system)
       )
      )
;; ---------------
;; sidebar configs
;; ---------------
;; neotree
(setq neo-theme (if (display-graphic-p) 'icons 'arrow))
(doom-themes-neotree-config)
;; treemacs
(setq doom-themes-treemacs-theme "doom-colors")
(doom-themes-treemacs-config)

;; ----------
;; tex engine
;; ----------
(setq-default TeX-engine 'xetex)

;; ------------------
;; default major mode
;; ------------------
(setq-default major-mode 'org-mode)

;; ---------
;; shortcuts
;; ---------
(global-set-key (kbd "<f12>") 'treemacs)
(global-set-key (kbd "<C-f12>") 'treemacs-switch-workspace)
(global-set-key (kbd "<S-f12>") 'neotree-toggle)
(global-set-key (kbd "C-*") 'insert-zero-width-space)
(global-set-key (kbd "<C-M-right>") 'centaur-tabs-forward-tab)
(global-set-key (kbd "<C-M-left>") 'centaur-tabs-backward-tab)
(global-set-key (kbd "<home>") 'beginning-of-line)
(global-set-key (kbd "<end>") 'end-of-line)

;; ------------
;; column width
;; ------------
(setq-default fill-column 80)

(global-set-key (kbd "M-=") 'cnfonts-increase-fontsize)
(global-set-key (kbd "M--") 'cnfonts-decrease-fontsize)
(global-set-key (kbd "s-=") 'cnfonts-increase-fontsize)
(global-set-key (kbd "s--") 'cnfonts-decrease-fontsize)

(setq-default fill-column 80)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#f0f0f0" "#e45649" "#50a14f" "#986801" "#4078f2" "#a626a4" "#0184bc" "#383a42"])
 '(custom-safe-themes
   (quote
    ("bc836bf29eab22d7e5b4c142d201bcce351806b7c1f94955ccafab8ce5b20208" default)))
 '(fci-rule-color "#383a42")
 '(jdee-db-active-breakpoint-face-colors (cons "#f0f0f0" "#4078f2"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#f0f0f0" "#50a14f"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#f0f0f0" "#9ca0a4"))
 '(objed-cursor-color "#e45649")
 '(pdf-view-midnight-colors (cons "#383a42" "#fafafa"))
 '(rustic-ansi-faces
   ["#fafafa" "#e45649" "#50a14f" "#986801" "#4078f2" "#a626a4" "#0184bc" "#383a42"])
 '(vc-annotate-background "#fafafa")
 '(vc-annotate-color-map
   (list
    (cons 20 "#50a14f")
    (cons 40 "#688e35")
    (cons 60 "#807b1b")
    (cons 80 "#986801")
    (cons 100 "#ae7118")
    (cons 120 "#c37b30")
    (cons 140 "#da8548")
    (cons 160 "#c86566")
    (cons 180 "#b74585")
    (cons 200 "#a626a4")
    (cons 220 "#ba3685")
    (cons 240 "#cf4667")
    (cons 260 "#e45649")
    (cons 280 "#d2685f")
    (cons 300 "#c07b76")
    (cons 320 "#ae8d8d")
    (cons 340 "#383a42")
    (cons 360 "#383a42")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
