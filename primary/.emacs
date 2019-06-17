;;Luke jf Schlather's .emacs file
(when window-system (set-frame-size (selected-frame) 80 24))

(add-to-list 'load-path "~/.autoinsert/")
;; http://melpa.org/#/getting-started
(require 'package) 
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("elpa" . "http://tromey.com/elpa/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)

(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) 

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))
(setq use-package-always-ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(case-fold-search t)
 '(current-language-environment "Latin-1")
 '(default-input-method "latin-1-prefix")
 '(global-font-lock-mode t nil (font-lock))
 '(package-selected-packages
   (quote
    (typescript-mode
     csharp-mode
     csproj-mode
     csharp
     powershell
     powershell-mode
     web-mode
     haml-mode
     yaml-mode
     markdown-mode
     go-mode
     use-package
     )))
 '(show-paren-mode t nil (paren)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;; Provide access to window manager clipboard.
(define-key global-map  (kbd "C-S-v") 'clipboard-yank)
(define-key global-map  (kbd "C-S-c") 'clipboard-kill-ring-save)

;; This is a Windows system hotkey that causes Emacs to error when it is used
(global-set-key (kbd "<C-lwindow>") 'ignore)


(add-hook 'python-mode-hook
          (lambda ()
            (define-key python-mode-map (kbd "C-c [") 'python-shift-left)
            (define-key python-mode-map (kbd "C-c ]") 'python-shift-right)
            (setq python-fill-docstring-style 'django)
            ))
;; M-x apropos ftw
(define-key global-map  (kbd "C-h") 'backward-kill-word)

;; Yes or no prompts now just require y or n:
(fset 'yes-or-no-p 'y-or-n-p)

;;Auto-Insert
(setq auto-insert-alist 
      '(
	("main\\.cpp$" . ["main.cpp" auto-update-code])
	("\\.cpp$" . ["insert.cpp" auto-update-code])
	("\\.c$" . ["insert.c" auto-update-code])
	("[Mm]akefile" . ["template.mk" auto-update-code])
	("\\.h$" . ["insert.h" auto-update-code])
	("\\.tex$" . ["insert.tex"])
	("\\.pl$" . ["insert.pl" auto-update-code])
	("\\.py$" . ["insert.py" auto-update-code])
	("\\.java$" . ["insert.java" auto-update-code])
	("\\.markdown$" . ["insert.markdown" auto-update-code])
	("\\.html$" . ["insert.html" auto-update-code])
        )
      )


(setq auto-insert-directory "~/.autoinsert/")
(setq auto-insert-query nil)
(add-hook 'find-file-hooks 'auto-insert)
;; function replaces the string '&ljfs:marker' by the current file
;; name. You could use a similar approach to insert name and date into
;; your file.
(defun insert-today ()
  "Insert today's date into buffer"
  (interactive)
  (insert (format-time-string "%A, %B %e %Y" (current-time))))

(defun auto-update-code () 
  "Replace keywords in a file. '&namspace:whatever;' should be language-independent"
  (interactive)
  (save-excursion
    (while (search-forward "&ljfs:filename;" nil t)
      (save-restriction
	(narrow-to-region (match-beginning 0) (match-end 0))
	(replace-match (file-name-sans-extension (file-name-nondirectory buffer-file-name)))
	(subst-char-in-region (point-min) (point-max) ?. ?_)
	))
    )

  (save-excursion
    ;; Replace &ljfs:filenameh; with file name sans suffix
    (while (search-forward "&ljfs:cpph;" nil t)
      (save-restriction
	(narrow-to-region (match-beginning 0) (match-end 0))
	(replace-match (concat "_"  (upcase (file-name-sans-extension (file-name-nondirectory buffer-file-name))) "_")) t
        
	))
    )
  (save-excursion
    ;; replace &ljfs:date; with today's date
    (while (search-forward "&ljfs:date;" nil t)
      (save-restriction
	(narrow-to-region (match-beginning 0) (match-end 0))
	(replace-match "")
	(insert-today)
	))
    )
  )

;;fix it so that c++ mode is default for .h files.
(append '(("\\.h\\'" . c++-mode)
	  auto-mode-alist))

;; WORD PROCESSING

(setq-default fill-column 80)
;; load word-wrapper (doesen't the file with newlines.)
(add-hook 'text-mode-hook 'visual-line-mode)
(add-hook 'text-mode-hook 'flyspell-mode)

(defun word-count nil "Count words in buffer" (interactive)
       (shell-command-on-region (point-min) (point-max) "wc -w"))

;;WORD PROCESSING

;;Assuming aspell is spell check
(setq-default spell-command "aspell")
(setq-default ispell-program-name "aspell")
(setq-default ispell-extra-args '("--reverse"))

;; 
(load-file "~/.autoinsert/sto-entry.el")

;;do a google search
(defun google (command)
  "Use `browse-url' to submits a command to google and opens
result in an external browser defined in `browse-url-browser-function'.
To get started  `M-x google <RET> ls <RET>' will return a list of 
all google commands."
  (interactive "sCommand:")
  (browse-url 
   command))


(setq inhibit-splash-screen 1)
(setq initial-scratch-message nil)
(setq initial-major-mode 'fundamental-mode)

(put 'downcase-region 'disabled nil)

;instead of beeping, emacs flashes
(setq visible-bell 1)
;Now some people find the flashing annoying. To turn the alarm totally off, you can use this:
; (setq ring-bell-function 'ignore)

;;hide passwords in shell prompt

(add-hook 'comint-output-filter-functions
	  'comint-watch-for-password-prompt)

;;html stuff

(defun downcase-html-tags () (interactive)
       (save-excursion
         (beginning-of-buffer)
         (while (re-search-forward "</?\\([a-zA-Z]+\\)" nil t)
           (downcase-region (match-beginning 1) (match-end 1)))
         )
       )


;; Join these channels at startup.
(setq rcirc-startup-channels-alist
      '(("\\.freenode\\.net$" "#emacs" "#ubuntu")))

;;; This is the binary name of my scheme implementation
(setq scheme-program-name "mzscheme")
(setq sql-sqlite-program "/usr/bin/sqlite3")

(put 'upcase-region 'disabled nil)

;;Disable the menu bar at the top of the screen.
(menu-bar-mode -1)
;;Disable scroll bar.
;;(toggle-scroll-bar -1)
(if (display-graphic-p)
    (tool-bar-mode -1)
  )
(put 'scroll-left 'disabled nil)

(setq-default indent-tabs-mode nil)
(setq-default c-basic-offset 2)
(setq js-indent-level 2)
(setq css-indent-offset 2)
(setq ruby-deep-indent-paren nil)

(use-package go-mode)
(use-package markdown-mode)
(use-package yaml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
  )

(use-package haml-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.haml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.slim\\'" . web-mode))
  )

(use-package web-mode
  :config
  (add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.php\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.tpl\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  )

(defun my-go-mode-hook ()
  (add-hook 'before-save-hook 'gofmt-before-save)
  (setq tab-width 2 standard-indent 2 indent-tabs-mode nil))
(add-hook 'go-mode-hook 'my-go-mode-hook) 
(set-face-attribute 'default nil :height 140)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

(if (file-exists-p "~/.pyenv/shims/python3")
    (lambda ()
      (use-package flycheck
        :config
        (add-hook 'python-mode-hook 'flycheck-mode)
        (add-hook 'python-mode-hook (lambda ()
                                      (flycheck-select-checker 'python-flake8)
                                      ))
        )
      (setq 'flycheck-python-flake8-executable "~/.pyenv/shims/python3")
      (setq 'flycheck-python-pycompile-executable "~/.pyenv/shims/python3")
      (setq 'flycheck-python-pylint-executable "~/.pyenv/shims/python3")
      )
  )

(when window-system (set-frame-size (selected-frame) 80 24))

(use-package powershell)
(use-package csharp-mode)
(use-package csproj-mode)
(use-package typescript-mode)
