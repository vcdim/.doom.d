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
(setq doom-font (font-spec :family "Sarasa Mono SC"))
;; (setq doom-font (font-spec :family "JetBrains Mono" :size 24)
;;       doom-big-font (font-spec :family "JetBrains Mono" :size 36)
;;       doom-variable-pitch-font (font-spec :family "Overpass" :size 24))

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

;; --------
;; org-roam
;; --------
(setq org-roam-directory "~/SynologyDrive/Study/roam")
(add-hook 'after-init-hook 'org-roam-mode)

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



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#252526" "#d02b61" "#60aa00" "#d08928" "#6c9ef8" "#b77fdb" "#00aa80" "#dddddd"])
 '(custom-safe-themes
   (quote
    ("d74c5485d42ca4b7f3092e50db687600d0e16006d8fa335c69cf4f379dbd0eee" "3577ee091e1d318c49889574a31175970472f6f182a9789f1a3e9e4513641d86" "fe94e2e42ccaa9714dd0f83a5aa1efeef819e22c5774115a9984293af609fce7" "76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" "bc836bf29eab22d7e5b4c142d201bcce351806b7c1f94955ccafab8ce5b20208" "0fe9f7a04e7a00ad99ecacc875c8ccb4153204e29d3e57e9669691e6ed8340ce" "1ca1f43ca32d30b05980e01fa60c107b02240226ac486f41f9b790899f6f6e67" "a02836a5807a687c982d47728e54ff42a91bc9e6621f7fe7205b0225db677f07" "fe76f3d5094967034192f6a505085db8db6deb0e135749d9a54dc488d6d3ee2f" "669e05b25859b9e5b6b9809aa513d76dd35bf21c0f16d8cbb80fb0727dc8f842" "70cc30fd9d27a8d0d3ae82974ac2c409fd2cd5746470e2246778c6bec2d4857c" "3bca56f0b4e4e6b6f94b92588cd26e06c585beccdecaea32b1cf5b67b78d6a86" "eb94e44599a45c495ad472ad551a40b87cbc4bae9631211e7a78d72b102c61b1" "70ed3a0f434c63206a23012d9cdfbe6c6d4bb4685ad64154f37f3c15c10f3b90" "23ddc2b1dc800bcb0151603c48b37443bd95f8b43713d607a1074bc67fb226ba" "5091eadbb87fa0a168a65f2c3e579d1a648d764f12ab9d3ab7bdefca709cd2a5" "55257ccc6763185dde2146bcc5aa2b83130cc55042c45daaf5efe3c3137b578f" "5a411e7cb2d7955b28c514cd5b75782c6dd4ba027089fec17a2573405b0fdd5c" "2878517f049b28342d7a360fd3f4b227086c4be8f8409f32e0f234d129cee925" "7d56fb712ad356e2dacb43af7ec255c761a590e1182fe0537e1ec824b7897357" "e7666261f46e2f4f42fd1f9aa1875bdb81d17cc7a121533cad3e0d724f12faf2" "dd854be6626a4243375fd290fec71ed4befe90f1186eb5b485a9266011e15b29" "423435c7b0e6c0942f16519fa9e17793da940184a50201a4d932eafe4c94c92d" "7dc3fe8fadb914563790a3fbe587fd455626442f66da333ea4de2c455feefb98" "5e0b63e0373472b2e1cf1ebcc27058a683166ab544ef701a6e7f2a9f33a23726" "d7cc230da628bd70f02f630faee6c2fba0f9987b1ca32c62a2e13c168570d5f9" "aed6332e9a38b49bb044b994e8be0d57a2f67ff6ca96f5ce8e0130562c4cc233" "fa1fa0bc00fc80f5466cfd6b595e4a010d0c1953b7f135fd2658ca93ff8c8a17" "b60f08ddc98a95485ec19f046a81d5877b26ab80a67782ea5b91a00ea4f52170" "2d1fe7c9007a5b76cea4395b0fc664d0c1cfd34bb4f1860300347cdad67fb2f9" "76b24560ca720742fa59f03998d6ea8e20f0353c7309f4923b49af34eaec4f65" default)))
 '(fci-rule-color "#505050")
 '(jdee-db-active-breakpoint-face-colors (cons "#1b1d1e" "#fc20bb"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1b1d1e" "#60aa00"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1b1d1e" "#505050"))
 '(objed-cursor-color "#d02b61")
 '(pdf-view-midnight-colors (cons "#dddddd" "#1b1d1e"))
 '(rustic-ansi-faces
   ["#1b1d1e" "#d02b61" "#60aa00" "#d08928" "#6c9ef8" "#b77fdb" "#00aa80" "#dddddd"])
 '(vc-annotate-background "#1b1d1e")
 '(vc-annotate-color-map
   (list
    (cons 20 "#60aa00")
    (cons 40 "#859f0d")
    (cons 60 "#aa931a")
    (cons 80 "#d08928")
    (cons 100 "#d38732")
    (cons 120 "#d6863d")
    (cons 140 "#da8548")
    (cons 160 "#ce8379")
    (cons 180 "#c281aa")
    (cons 200 "#b77fdb")
    (cons 220 "#bf63b2")
    (cons 240 "#c74789")
    (cons 260 "#d02b61")
    (cons 280 "#b0345c")
    (cons 300 "#903d58")
    (cons 320 "#704654")
    (cons 340 "#505050")
    (cons 360 "#505050")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Sarasa Mono SC" :foundry "nil" :slant normal :weight normal :height 200 :width normal)))))
