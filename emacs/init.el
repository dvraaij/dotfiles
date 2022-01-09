(package-initialize)

(load "~/.config/emacs/rc/rc.el")

;;; No startup screen.
(setq inhibit-startup-screen 1)

;;; Appearance
(defun rc/get-default-font ()
  (cond
   ((eq system-type 'windows-nt) "Consolas-12")
   ((eq system-type 'gnu/linux) "Iosevka-12")))

(add-to-list 'default-frame-alist `(font . ,(rc/get-default-font)))

(tool-bar-mode 0)
(menu-bar-mode 1)
(scroll-bar-mode 1)
(column-number-mode 1)
(show-paren-mode 1)
(size-indication-mode 1)

;;; Easy switching between windows.
(windmove-default-keybindings)

;;; Easy window resizing.
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;;; Scrolling.
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1)))
(setq mouse-wheel-progressive-speed nil)
(setq mouse-wheel-follow-mouse 't)
(setq scroll-step 1)

;;; Backups.
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Use ido and smex.
(ido-mode 1)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;;; Tabs
(setq custom-tab-width 4)

(defun disable-tabs ()
  (interactive)
  (setq indent-tabs-mode nil))
(defun enable-tabs ()
  (interactive)
  (local-set-key (kbd "TAB") 'tab-to-tab-stop)
  (setq indent-tabs-mode t)
  (setq tab-width custom-tab-width))

;;; Whitespace mode
(defun rc/set-up-whitespace-handling ()
  (interactive)
  (whitespace-mode 0)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))

(add-hook 'emacs-lisp-mode 'rc/set-up-whitespace-handling)
(add-hook 'tuareg-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'c++-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'c-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'java-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'lua-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'rust-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'scala-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'markdown-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'haskell-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'python-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'erlang-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'asm-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'nasm-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'go-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'nim-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'why3-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'yaml-mode-hook 'rc/set-up-whitespace-handling)

;;; display-line-numbers-mode
(when (version<= "26.0.50" emacs-version)
  (global-display-line-numbers-mode))

;;; Magit
;; magit requres this lib, but it is not installed automatically on
;; Windows.
(rc/require 'cl-lib)
(rc/require 'magit)

(setq magit-auto-revert-mode nil)

(global-set-key (kbd "C-c m s") 'magit-status)
(global-set-key (kbd "C-c m l") 'magit-log)

;;; Editorconfig
(rc/require 'editorconfig)
(editorconfig-mode 1)

;;; Ada mode (also requires gnatcoll-sqlite and gnatcoll_xref)
;; (rc/require 'ada-mode)
;;
;; (defgroup project-build nil
;;   "LSP options for Project"
;;   :group 'ada-mode)
;;
;; (defcustom project-build-type "Debug"
;;   "Controls the type of build of a project.
;;    Default is Debug, other choices are Release and Coverage."
;;   :type '(choice
;;           (const "Debug")
;;           (const "Coverage")
;;           (const "Release"))
;;   :group 'project-build)
;;
;; (setq ada-xref-tool 'ada-gnat-xref)

;; c-mode
(setq-default c-basic-offset 4
              c-default-style '((java-mode . "java")
                                (awk-mode . "awk")
                                (other . "bsd")))

(add-hook 'c-mode-hook (lambda ()
                         (interactive)
                         (c-toggle-comment-style -1)))

;;; why3-mode.

;;    Note that Fedora package why3-emacs copies the why3.el and why3.elc
;;    to a location that works only if OPAM is installed. You ned to
;;    copy them to the corredt location manually.
;;
;;       cd /usr/share/why3
;;       sudo mkdir emacs
;;       sudo cp /usr/share/emacs/site-lisp/why3.* ./emacs

(setq why3-share
      (if (boundp 'why3-share) why3-share (ignore-errors (car (process-lines "why3" "--print-datadir")))))

(setq why3el
      (let ((f (expand-file-name "emacs/why3.elc" why3-share)))
	(if (file-readable-p f) f
	  (let ((f (expand-file-name "emacs/site-lisp/why3.elc" opam-share)))
	    (if (file-readable-p f) f nil)))))

(when why3el
  (autoload 'why3-mode why3el "Major mode for Why3." t)
  (setq auto-mode-alist (cons '("\\.mlw$" . why3-mode) auto-mode-alist)))

;;; LaTeX mode
(add-hook 'tex-mode-hook
          (lambda ()
            (interactive)
            (add-to-list 'tex-verbatim-environments "code")))

;;; Text mode
(add-hook 'text-mode-hook 'disable-tabs)

;;; Enable uppercase and lower-case commands (C-x C-u and C-x C-l)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; Multiple cursors
(rc/require 'multiple-cursors)

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->")         'mc/mark-next-like-this)
(global-set-key (kbd "C-<")         'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<")     'mc/mark-all-like-this)
(global-set-key (kbd "C-\"")        'mc/skip-to-next-like-this)
(global-set-key (kbd "C-:")         'mc/skip-to-previous-like-this)

;;; Move Text
(rc/require 'move-text)
(global-set-key (kbd "M-p") 'move-text-up)
(global-set-key (kbd "M-n") 'move-text-down)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(custom-enabled-themes '(deeper-blue))
 '(custom-safe-themes default)
 '(package-selected-packages
   '(smex multiple-cursors move-text magit editorconfig dash-functional tuareg company company-lsp lsp-mode))
 '(frame-brackground-mode 'dark)
 '(global-display-line-numbers-mode t)
 '(hl-todo-keyword-faces
   '(("TODO" . "#dc752f")
     ("NEXT" . "#dc752f")
     ("THEM" . "#2d9574")
     ("PROG" . "#4f97d7")
     ("OKAY" . "#4f97d7")
     ("DONT" . "#f2241f")
     ("FAIL" . "#f2241f")
     ("DONE" . "#86dc2f")
     ("NOTE" . "#b1951d")
     ("KLUDGE" . "#b1951d")
     ("HACK" . "#b1951d")
     ("TEMP" . "#b1951d")
     ("FIXME" . "#dc752f")
     ("XXX+" . "#dc752f")
     ("\\?\\?\\?+" . "#dc752f")))
 '(pdf-view-midnight-colors '("#b2b2b2" . "#292b2e"))
 '(whitespace-style
   (quote
    (face empty trailing tab-mark space-mark))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tuareg-font-lock-attribute-face ((t (:inherit font-lock-preprocessor-face)))))

;; Fix
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
