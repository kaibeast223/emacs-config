;; 
;; 
;; Initial emacs configuration files. We'll keep it as small as possible
;; as the real configuration appends in an org file (litterate config.)

;; Support for Emacs 24 and higher only
(let ((minver 24))
  (unless (>= emacs-major-version minver)
    (error "Your Emacs is too old -- this config requires v%s or higher" minver)))

;; Keep track of loading time
(defconst emacs-start-time (current-time))

;; Add custom lisp files to the load-path
(add-to-list 'load-path "~/.emacs.d/lisp")

;; initialize all ELPA packages
(require 'setup-package)

;; (setq package-enable-at-startup nil)
(let ((elapsed (float-time (time-subtract (current-time)
					   emacs-start-time))))
  (message "Loaded packages in %.3fs" elapsed))

;; Make sure we have a decent and recent org-mode version
(when (not (package-installed-p 'org))
  do (package-install 'org))
;;(when (not (package-installed-p 'org-plus-contrib))
;;  do (package-install 'org-plus-contrib))

(require 'org)
(when (string-match "^[1234567]" (org-version))
  (warn "Org-mode is out of date. We expect org 8 or higher, but instead we have %s" (org-version)))

;; keep customize settings in their own file
(setq custom-file
      (expand-file-name "custom.el"
			user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; load the literate configuration
(require 'ob-tangle)
;;(org-babel-load-file
;; (expand-file-name "emacs.org"
;;		   user-emacs-directory))
(org-babel-load-file "~/.emacs.d/emacs.org")

(let ((elapsed (float-time (time-subtract (current-time)
					   emacs-start-time))))
  (message "Loaded settings...done in %.3fs" elapsed))


