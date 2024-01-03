(package-initialize)

;; Package sources.
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
;; (add-to-list 'package-archives '("gnu-devel" . "https://elpa.gnu.org/devel/"))

;; Prefer GNU over Melpa.
(setq package-archive-priorities '(("gnu" . 20)("melpa" . 10)))

(use-package emacs

  :bind  (("S-C-<left>"  . shrink-window-horizontally)
          ("S-C-<right>" . enlarge-window-horizontally)
          ("S-C-<down>"  . shrink-window)
          ("S-C-<up>"    . enlarge-window))

  :config

  ;; Font
  (set-frame-font
   (cond
    ((eq system-type 'windows-nt) "Consolas-12")
    ((eq system-type 'gnu/linux) "Iosevka-12"))
   nil t)

  ;; Tabs
  (setq custom-tab-width 4)
  (setq-default indent-tabs-mode nil)

  (defun enable-fixed-tab-width-using-only-spaces ()
    "Fixed tab width using only spaces"
    (interactive)
    (keymap-local-set "TAB" 'tab-to-tab-stop)  ; use `keymap-local-set` as of Emacs 29.1
    (indent-tabs-mode -1)                      ; use only spaces
    (setq tab-width custom-tab-width))

  :custom

  ;; Startup
  (inhibit-startup-screen t)
  (initial-major-mode 'fundamental-mode)
  (initial-scratch-message "")

  ;; Appearance
  (tool-bar-mode nil)
  (scroll-bar-mode 'right)
  (menu-bar-mode t)
  (column-number-mode t)
  (show-paren-mode t)
  (size-indication-mode t)
  (global-display-line-numbers-mode t)

  ;; Scrolling.
  (scroll-step 1)

  ;; Backups.
  (backup-directory-alist
   `((".*" . ,temporary-file-directory)))
  (auto-save-file-name-transforms
   `((".*" ,temporary-file-directory t))))

(use-package ada-mode
  :load-path "~/opt/old-ada-mode"
  :mode (("\\.gpr$"     . ada-mode)
         ("\\.ad[asb]$" . ada-mode)))

(use-package agda2
  :mode (("\\.agda$"      . agda2-mode)
         ("\\.lagda$"     . agda2-mode)
         ("\\.lagda.md$"  . agda2-mode)
         ("\\.lagda.rst$" . agda2-mode)
         ("\\.lagda.tex$" . agda2-mode)))

(use-package ansi-color
  :custom-face
  (ansi-color-black          ((t (:foreground "#000000" :background "#000000"))))
  (ansi-color-red            ((t (:foreground "#FF0000" :background "#FF0000"))))
  (ansi-color-green          ((t (:foreground "#38DE21" :background "#38DE21"))))
  (ansi-color-yellow         ((t (:foreground "#FFE50A" :background "#FFE50A"))))
  (ansi-color-blue           ((t (:foreground "#1460D2" :background "#1460D2"))))
  (ansi-color-magenta        ((t (:foreground "#FF005D" :background "#FF005D"))))
  (ansi-color-cyan           ((t (:foreground "#00BBBB" :background "#00BBBB"))))
  (ansi-color-white          ((t (:foreground "#BBBBBB" :background "#BBBBBB"))))
  (ansi-color-bright-black   ((t (:foreground "#555555" :background "#555555"))))
  (ansi-color-bright-red     ((t (:foreground "#F40E17" :background "#F40E17"))))
  (ansi-color-bright-green   ((t (:foreground "#3BD01D" :background "#3BD01D"))))
  (ansi-color-bright-yellow  ((t (:foreground "#EDC809" :background "#EDC809"))))
  (ansi-color-bright-blue    ((t (:foreground "#5555FF" :background "#5555FF"))))
  (ansi-color-bright-magenta ((t (:foreground "#FF55FF" :background "#FF55FF"))))
  (ansi-color-bright-cyan    ((t (:foreground "#6AE3FA" :background "#6AE3FA"))))
  (ansi-color-bright-white   ((t (:foreground "#FFFFFF" :background "#FFFFFF")))))

(use-package cc-mode
  :hook (c-mode . (lambda ()
                    (interactive)
                    (c-toggle-comment-style nil)))
  :custom
  (c-basic-offset 4)
  (c-default-style '((java-mode . "java")
                     (awk-mode  . "awk")
                     (other     . "bsd"))))

;; cl-lib is required by Magit on Windows.
(when (eq system-type 'windows-nt)
  (use-package cl-lib))

(use-package custom
  :custom
  (custom-enabled-themes '(deeper-blue)))

(use-package ediff
  :custom
  (ediff-keep-variants nil)
  (ediff-make-buffers-readonly-at-startup nil)
  (ediff-merge-revisions-with-ancestor t)
  (ediff-show-clashes-only t)
  (ediff-split-window-function 'split-window-horizontally)
  (ediff-window-setup-function 'ediff-setup-windows-plain))

(use-package editorconfig
  :ensure t)

(use-package etags
  :bind ("M-T" . tags-search)
  :custom
  (tags-add-tables t)
  (tags-apropos-verbose t)
  (tags-case-fold-search nil)
  (tags-revert-without-query t))

(use-package gud
  :commands gud-gdb
  :bind (("<f9>"    . gud-cont)
         ("<f10>"   . gud-next)
         ("<f11>"   . gud-step)
         ("S-<f11>" . gud-finish))
  :custom
  (gdb-find-source-frame t)
  (gdb-many-windows t))

(use-package ido
  :custom
  (ido-mode t)
  (ido-everywhere t)
  (ido-auto-merge-work-directories-length nil))

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status))

(use-package magit-autorevert
  :after magit
  :custom
  (magit-auto-revert-mode nil))

(use-package move-text
  :ensure t
  :bind (("M-p" . move-text-up)
         ("M-n" . move-text-down)))

(use-package multiple-cursors
  :ensure t
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->"         . mc/mark-next-like-this)
         ("C-<"         . mc/mark-previous-like-this)
         ("C-c C-<"     . mc/mark-all-like-this)
         ("C-\""        . mc/skip-to-next-like-this)
         ("C-:"         . mc/skip-to-previous-like-this)))

(use-package mwheel
  :custom
  (mouse-wheel-scroll-amount '(1 ((shift) . 1)))
  (mouse-wheel-progressive-speed nil)
  (mouse-wheel-follow-mouse 't))

(use-package pdf-tools
  :disabled
  :magic ("%PDF" . pdf-view-mode)
  :custom
  (pdf-view-midnight-colors '("#B2B2B2" . "#292B2E")))

(use-package prog-mode
  :hook (prog-mode . (lambda ()
                       (interactive)
                       (add-to-list 'write-file-functions 'delete-trailing-whitespace))))

(use-package proof-general
  :ensure t
  :no-require t
  :custom
  (proof-splash-time 1))

(use-package smex
  :ensure t
  :bind (("M-x"         . smex)
         ("M-X"         . smex-major-mode-commands)
         ("C-c C-c M-x" . execute-extended-command)))

(use-package tex-mode
  :config
  (add-to-list 'tex-verbatim-environments "code"))

(use-package text-mode
  :hook (text-mode . enable-fixed-tab-width-using-only-spaces))

(use-package tuareg
  :ensure t
  :mode (("\\.ocamlinit$" . tuareg-mode)))

(use-package whitespace
  :custom
  (whitespace-style '(face empty trailing tab-mark space-mark)))

(use-package why3
  :if (locate-library "why3.el")
  :mode ("\\.mlw$" . why3-mode))

(use-package warnings
  :custom
  (warning-suppress-log-types '((comp) (comp)))
  (warning-suppress-types '((comp))))

(use-package windmove
  :custom
  (windmove-default-keybindings '([ignore] shift)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(yaml-mode magit smex move-text editorconfig dash-functional tuareg proof-general multiple-cursors)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
