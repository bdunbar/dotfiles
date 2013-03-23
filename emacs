(message "*** HOWDY .emacs loading ***")

;;; This was installed by package-install.el.
;;; This provides support for the package system and
;;; interfacing with ELPA, the package archive.
;;; Move this code earlier if you want to reference
;;; packages in your .emacs.
(when
    (load
     (expand-file-name "~/.emacs.d/elpa/package.el"))
  (package-initialize))


;; 2011-12-5 - setup for SLIME
(setq inferior-lisp-program "/opt/local/bin/clisp")

;; 2011-12-12 - ORG setup
(require 'org-install)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

;; 2011-12-13 - Subversion setup

(add-to-list 'load-path "~/elisp")
(require 'psvn)

;; 2011-12-14 - TRAMP
(require 'tramp)
;; (setq tramp-default-method "scp")

;; 2012-10-05 - MORE TRAMP
(add-to-list 'tramp-default-user-alist '(nil nil "brian.dunbar.admin") t)



;;2011-12-19 From Yegge's Effective Emacs - http://sites.google.com/site/steveyegge2/effective-emacs
(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;;2012-02-02 dos-mode from http://www.emacswiki.org/emacs/dos.el
(autoload 'dos-mode "dos" "Edit Dos scripts." t)
(add-to-list 'auto-mode-alist '("\\.bat$" . dos-mode))


;;2012-03-26 - following should encrypt a heading in org-mode - see http://orgmode.org/manual/org_002dcrypt_002eel.html
;;2012-03-30 - Does not work.  Yet.
 (require 'org-crypt)
     (org-crypt-use-before-save-magic)
     (setq org-tags-exclude-from-inheritance (quote ("crypt")))
     
     (setq org-crypt-key nil)
       ;; GPG key to use for encryption
       ;; Either the Key ID or set to nil to use symmetric encryption.
	nil
     
     (setq auto-save-default nil)
       ;; Auto-saving does not cooperate with org-crypt.el: so you need
       ;; to turn it off if you plan to use org-crypt.el quite often.
       ;; Otherwise, you'll get an (annoying) message each time you
       ;; start Org.
     
       ;; To turn it off only locally, you can insert this:
       ;;
       ;; # -*- buffer-auto-save-file-name: nil; -*-


;;2012-04-19 - Puppet
;;2012-04-19 - Puppet - load the module
(when
    (load
     (expand-file-name "~/.emacs.d/puppet/puppet-mode.el"))
  (package-initialize))

;;2012-04-19 - Puppet - associate .pp with puppet mode
(setq auto-mode-alist (cons '("\\.pp$" . puppet-mode) auto-mode-alist))

;;2012-05-03 - Speedbar
(require 'sr-speedbar)
;; Additional extensions we use
(speedbar-add-supported-extension
  '("PKGBUILD" ".txt" ".org" ".pdf" ".css"
    ".php" ".conf" ".patch" ".diff" ".lua" ".sh")
)

;;2012-08-15 - TaskJuggler
(add-to-list 'load-path "~/.emacs.d/")

(require 'taskjuggler-mode)
(put 'erase-buffer 'disabled nil)

;;2012-11-30 - COBOL
(autoload 'cobol-mode "cobol-mode" "A major mode for editing ANSI Cobol/Scobol files." t nil)

;;2013-01-16 - edit to allow verbose debugging
;; see http://superuser.com/questions/189285/how-to-troubleshoot-aquamacs-emacs-problems-opening-files-with-tramp
(setq tramp-verbose 10)

;;2013-02-11 - edit for date / time stamp insertion
;; C-c\C-d date
;; C-c\C-t time
;; ====================
;; insert date and time

(defvar current-date-time-format "%a %b %d %H:%M:%S %Z %Y"
  "Format of date to insert with `insert-current-date-time' func
See help of `format-time-string' for possible replacements")

(defvar current-time-format "%a %H:%M:%S"
  "Format of date to insert with `insert-current-time' func.
Note the weekly scope of the command's precision.")

(defun insert-current-date-time ()
  "insert the current date and time into current buffer.
Uses `current-date-time-format' for the formatting the date/time."
       (interactive)
       (insert "==========\n")
;       (insert (let () (comment-start)))
       (insert (format-time-string current-date-time-format (current-time)))
       (insert "\n")
       )

(defun insert-current-time ()
  "insert the current time (1-week scope) into the current buffer."
       (interactive)
       (insert (format-time-string current-time-format (current-time)))
       (insert "\n")
       )

(global-set-key "\C-c\C-d" 'insert-current-date-time)
(global-set-key "\C-c\C-t" 'insert-current-time)

;;2013-03-01 - edit for emacsclient
;; start the emacsserver that listens to emacsclient
(server-start)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector ["black" "#d55e00" "#009e73" "#f8ec59" "#0072b2" "#cc79a7" "#56b4e9" "white"])
 '(custom-enabled-themes nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;Mon Mar 11 10:23:58 CDT 2013
;; reference http://stackoverflow.com/questions/6532998/how-to-run-multiple-shells-on-emacs
;; function to ask for shell name so we can have multiple instances of eshell
(defun create-shell ()
    "creates a shell with a given name"
    (interactive);; "Prompt\n shell name:")
    (let ((shell-name (read-string "shell name: " nil)))
    (shell (concat "*" shell-name "*"))))

;; And the same for eshell
(defun create-eshell ()
    "creates a shell with a given name"
    (interactive);; "Prompt\n eshell name:")
    (let ((eshell-name (read-string "eshell name: " nil)))
    (eshell (concat "*" eshell-name "*"))))

;;Tue Mar 12 12:43:35 CDT 2013
;; new function for eshell creation
;; ref: http://www.reddit.com/r/emacs/comments/1a3254/emacs_eshell_am_i_doing_something_wrong/
(defun eshell-new (name)
  "Create a shell buffer named NAME."
  (interactive "sEshell Name: ")
  (let* ((bn (concat "*eshell:" name "*"))
         (eb (get-buffer bn)))
    (if eb
        (switch-to-buffer eb)
      (eshell)
      (rename-buffer bn))))

(defun eshell-main ()
  (interactive)
  (eshell-new "main"))

(global-set-key (kbd "<f7>") 'eshell-main)

(defun eshell/asc (cmd &rest args)
  "Eshell async shell command, to get rid of double quotes"
  (interactive)
  (let* ((asc-buffer-name (concat "*asc:" cmd "*"))
         (buffer (get-buffer-create (generate-new-buffer-name asc-buffer-name)))
         (directory default-directory))
    ;; If will kill a process, query first.
    (setq proc (get-buffer-process buffer))
    (if proc
        (if (yes-or-no-p "A command is running.  Kill it? ")
            (kill-process proc)
          (error "Shell command in progress")))
    (with-current-buffer buffer
      (setq buffer-read-only nil)
      ;; Setting buffer-read-only to nil doesn't suffice
      ;; if some text has a non-nil read-only property,
      ;; which comint sometimes adds for prompts.
      (let ((inhibit-read-only t))
        (erase-buffer))
      (display-buffer buffer)
      (setq default-directory directory)
      (setq proc (start-file-process-shell-command 
                  asc-buffer-name 
                  buffer cmd 
                  (eshell-flatten-and-stringify args)))
      (setq mode-line-process '(":%s"))
      (require 'shell) (shell-mode)
      (set-process-sentinel proc 'shell-command-sentinel)
      ;; Use the comint filter for proper handling of carriage motion
      ;; (see `comint-inhibit-carriage-motion'),.
      (set-process-filter proc 'comint-output-filter))))

;;========== Sat Mar 16 18:36:37 CDT 2013
;; MINGUS
(load  "/Users/bdunbar/.emacs.d/mingus/libmpdee.el")
(add-to-list 'load-path "/path/where/mingus/resides")
(autoload 'mingus "mingus" nil t)