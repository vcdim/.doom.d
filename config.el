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
(setq org-directory my-org-folder)
(setq org-default-notes-file (concat synology-home-directory "Life/org/agenda.org"))
(setq +org-capture-todo-file (concat synology-home-directory "Life/org/agenda.org"))
(setq +org-capture-notes-file (concat synology-home-directory "Life/org/agenda.org"))
(setq +org-capture-journal-file (concat synology-home-directory "Life/org/journal.org"))
(setq org-log-done 'time)
(setq org-src-tab-acts-natively t)
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
;; --------
;; org-roam
;; --------
(setq org-roam-dailies-capture-templates '(("d" "daily" plain (function org-roam-capture--get-point) ""
    :immediate-finish t
    :file-name "dailies/%<%Y-%m-%d>"
    :head "#+TITLE: %<%Y-%m-%d>")))
(setq org-roam-graph-viewer "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome")
(setq org-roam-graph-exclude-matcher '("private" "dailies"))

;; ----------------
;; chinese font fix
;; ----------------
(cnfonts-enable)
(setq cnfonts-personal-fontnames
      '(("Victor Mono" "Sarasa Mono SC" "Cascadia Code")
        ("Kai" "WenQuanYi Micro Hei Mono" "WenQuanYi Zen Hei Mono" "WenQuanYi Zen Hei")
        ()))
;; ----------
;; load theme
;; ----------
(load-theme 'doom-one t)
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
       ("\\.pdf?\\'" . system)
       ("\\.pptx?\\'" . system)
       ("\\.docx?\\'" . system)
       ("\\.xlsx?\\'" . system)
       ("\\.png?\\'" . system)
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
;; -------
;; cnfonts
;; -------

(global-set-key (kbd "M-=") 'cnfonts-increase-fontsize)
(global-set-key (kbd "M--") 'cnfonts-decrease-fontsize)
(global-set-key (kbd "s-=") 'cnfonts-increase-fontsize)
(global-set-key (kbd "s--") 'cnfonts-decrease-fontsize)
;; ----
;; path
;; ----
(exec-path-from-shell-initialize)

(use-package org-roam
      :ensure t
      :hook
      (after-init . org-roam-mode)
      :custom
      (org-roam-directory (concat synology-home-directory "roam/"))
      :bind (:map org-roam-mode-map
              (("C-c n l" . org-roam)
               ("C-c n f" . org-roam-find-file)
               ("C-c n g" . org-roam-graph))
              :map org-mode-map
              (("C-c n i" . org-roam-insert))
              (("C-c n I" . org-roam-insert-immediate))))


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(holiday-bahai-holidays nil)
 '(holiday-hebrew-holidays nil)
 '(holiday-islamic-holidays nil)
 '(holiday-oriental-holidays nil)
 '(holiday-christian-holidays nil)
 )
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
