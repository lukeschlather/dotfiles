;;Luke jf Schlather's .emacs file
;;Version 1.2.2
;;October 26, 2007

(custom-set-variables
  ;; custom-set-variables was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 '(case-fold-search t)
 '(current-language-environment "Latin-1")
 '(default-input-method "latin-1-prefix")
 '(global-font-lock-mode t nil (font-lock))
 '(show-paren-mode t nil (paren)))

(custom-set-faces
  ;; custom-set-faces was added by Custom -- don't edit or cut/paste it!
  ;; Your init file should contain only one such instance.
 )

;;Set C-x r to be reindent whole buffer.

;; Provide access to window manager clipboard.
(define-key global-map  (kbd "C-S-v") 'clipboard-yank)
(define-key global-map  (kbd "C-S-c") 'clipboard-kill-ring-save)

(add-hook 'python-mode-hook
     (lambda ()
(define-key python-mode-map (kbd "C-c [") 'python-shift-left)
(define-key python-mode-map (kbd "C-c ]") 'python-shift-right)
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

;; load word-wrapper (doesen't the file with newlines.)
(add-hook 'text-mode-hook 'visual-line-mode)

(defun wc nil "Count words in buffer" (interactive)
  (shell-command-on-region (point-min) (point-max) "wc -w"))
(defun word-count wc)

;;WORD PROCESSING

;;Assuming aspell is spell check
(setq-default spell-command "aspell")
(setq-default ispell-program-name "aspell")
(setq-default ispell-extra-args '("--reverse"))
;;aspell end


;;OLAF SPECIFIC - DELETE WHEN THEY GO OUT OF SCOPE
(setq lpr-switches "- P mohn")

;;END OLAF

;;the sto-entry stuff - really nice tool
(load-file "~/.autoinsert/sto-entry.el")

;;do a yubnub search
(defun yubnub (command)
  "Use `browse-url' to submits a command to yubnub and opens
result in an external browser defined in `browse-url-browser-function'.

To get started  `M-x yubnub <RET> ls <RET>' will return a list of 
all yubnub commands."
  (interactive "sCommand:")
  (browse-url 
   (concat "http://yubnub.org/parser/parse?command=" command)))

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

;; ;; store count in variable
;; (defvar word-count
;;   nil
;;   "*Current value returned from `count-words-paragraph' function.")

;; ;; only setup timer once
;; (unless word-count
;;   ;; seed word-count
;;   (setq word-count "0")
;;   ;; create timer to keep word-count updated
;;   (run-with-idle-timer 0.5 t #'(lambda ()
;;                                  (setq word-count (number-
;; to-string (wc))))))

;; ;; add count words paragraph the mode line
;; (unless (memq 'word-count (nth 8 mode-line-format))
;;   (push (cons '#(" w:" 0 3) (help-echo "mouse-1: select (drag to
;; resize), mouse-2 = C-x 1, mouse-3 = C-x 0"))
;;               '(word-count))
;;         (nthcdr 8 mode-line-format)))
;; (set-default 'mode-line-format mode-line-format) 

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
(tool-bar-mode -1)
(put 'scroll-left 'disabled nil)


;; Code environments

(load-file "~/.autoinsert/groovy-mode.el")
(load-file "~/.autoinsert/markdown-mode.el")
(append '(("\\.markdown\\'" . markdown-mode)
   auto-mode-alist))
(append '(("\\.frm\\'" . visual-basic-mode)
   auto-mode-alist))
;(load-file "/home/code/golang/misc/emacs/go-mode.el")

