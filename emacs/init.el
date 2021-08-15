(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#0a0814" "#f2241f" "#67b11d" "#b1951d" "#4f97d7" "#a31db1" "#28def0" "#b2b2b2"])
 '(column-number-mode t)
 '(custom-enabled-themes '(deeper-blue))
 '(custom-safe-themes
   '("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "5f824cddac6d892099a91c3f612fcf1b09bb6c322923d779216ab2094375c5ee" default))
 '(font-use-system-font t)
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
 '(package-selected-packages
   '(lean-mode tuareg company company-lsp company-coq lsp-mode))
 '(pdf-view-midnight-colors '("#b2b2b2" . "#292b2e"))
 '(show-paren-mode t)
 '(tool-bar-mode nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tuareg-font-lock-attribute-face ((t (:inherit font-lock-preprocessor-face)))))

;; -------------
;; -- General --
;; -------------

;; No startup screen.
(setq inhibit-startup-screen 1)

;; Lines, columns, etc.
(tool-bar-mode 0)
(menu-bar-mode 1)
(scroll-bar-mode 1)
(column-number-mode t)
(show-paren-mode 1)
(global-display-line-numbers-mode t)

;; (global-hl-line-mode 1)
;; (set-face-background hl-line-face "RoyalBlue4")

;; Always use spaces instead of TABs.
(setq-default indent-tabs-mode nil)

;; Easy switching between windows.
(windmove-default-keybindings)

;; Backups
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; ---------
;; -- Ada --
;; ---------

;; Ada Language Server
(defgroup project-build nil
  "LSP options for Project"
  :group 'ada-mode)

(defcustom project-build-type "Debug"
  "Controls the type of build of a project.
   Default is Debug, other choices are Release and Coverage."
  :type '(choice
          (const "Debug")
          (const "Coverage")
          (const "Release"))
  :group 'project-build)

;; Ada mode
;; (setq ada-xref-tool 'ada-gnat-xref)

;; Fix
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")
