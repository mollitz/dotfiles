(defvar exwm-terminal-command "urxvt"
  "Terminal command to run.")

(defvar exwm--locking-command "lock"
  "Command to run when locking session")

(defvar exwm-app-launcher--prompt "$ "
  "Prompt for the EXWM application launcher")

(defvar exwm--hide-tiling-modeline nil
  "Whether to hide modeline.")

(exwm-input-set-key (kbd "s-<escape>") 'exwm-reset)

(exwm-input-set-key (kbd "<s-tab>") #'spacemacs/exwm-jump-to-last-exwm)
;; + Bind a key to switch workspace interactively
(exwm-input-set-key (kbd "s-w") 'exwm-workspace-switch)
;; + Set shortcuts to switch to a certain workspace.
(exwm-input-set-key (kbd "s-n")
                    (lambda () (interactive) (exwm-workspace-switch 0)))
(exwm-input-set-key (kbd "s-r")
                    (lambda () (interactive) (exwm-workspace-switch 1)))
(exwm-input-set-key (kbd "s-t")
                    (lambda () (interactive) (exwm-workspace-switch 2)))
(exwm-input-set-key (kbd "s-d")
                    (lambda () (interactive) (exwm-workspace-switch 3)))
(exwm-input-set-key (kbd "s-g")
                    (lambda () (interactive) (exwm-workspace-switch 4)))
(exwm-input-set-key (kbd "s-6")
                    (lambda () (interactive) (exwm-workspace-switch 5)))
(exwm-input-set-key (kbd "s-7")
                    (lambda () (interactive) (exwm-workspace-switch 6)))
(exwm-input-set-key (kbd "s-8")
                    (lambda () (interactive) (exwm-workspace-switch 7)))
(exwm-input-set-key (kbd "s-9")
                    (lambda () (interactive) (exwm-workspace-switch 8)))
(exwm-input-set-key (kbd "s-0")
                    (lambda () (interactive) (exwm-workspace-switch 9)))
;; + Application launcher ('M-&' also works if the output buffer does not
;;   bother you). Note that there is no need for processes to be created by
;;   Emacs.
(exwm-input-set-key (kbd "s-c") #'spacemacs/exwm-app-launcher)

(exwm-input-set-key (kbd "s-a") #'helm-exwm)

(fancy-battery-mode)

(defun moritzs/exwm-logout ()
  (interactive)
  (recentf-save-list)
  (save-some-buffers)
  (start-process-shell-command "logout" nil "kill -9 -1"))

(exwm-input-set-key (kbd "s-C-q") #'moritzs/exwm-logout)


;; autostart
(call-process-shell-command "/home/moritz/.spacemacs.d/autostart.sh")

;; (desktop-environment-mode)  (inside config now)


(exwm-input-set-key (kbd "<XF86LaunchB>") #'desktop-environment-screenshot)
(exwm-input-set-key (kbd "S-<XF86LaunchB>") #'desktop-environment-screenshot-part)


(exwm-input-set-key (kbd "s-v") #'moritzs/open-browser) ;; todo open in workspace 2or 3
(exwm-input-set-key (kbd "s-S-v") #'moritzs/open-browser)  ;; todo open in side tab on current workspace

(exwm-input-set-key (kbd "s-i") #'exwm-workspace-switch-to-buffer) ;; import window
(exwm-input-set-key (kbd "s-e") #'exwm-workspace-move-window) ;; export window


(setq browse-url-generic-program "qutebrowser")
;; (setq helm-exwm-emacs-buffers-source (helm-exwm-build-emacs-buffers-source))
;; (setq helm-exwm-source (helm-exwm-build-source))
;; (setq helm-mini-default-sources `(helm-exwm-emacs-buffers-source
;;                                   helm-exwm-source
;;                                   helm-source-recentf)

(setq exwm-layout-show-all-buffers t)  ;; enable switching to other workspaces
(setq exwm-workspace-show-all-buffers nil)
(add-to-list 'helm-source-names-using-follow "EXWM buffers")

;; TODO
;; hotkey for opening new window in qutebrowser (with input)
;; hotkey for helm-all browser windows
;; (hotkey for all exwm windows)

;;(exwm-input-set-key (kbd "s-v") 'helm-exwm-switch-browser)
;; (exwm-input-set-key (kbd "s-v") 'helm-exwm)

(exwm-input-set-key (kbd "<XF86AudioPlay>") #'spotify-playpause)
(exwm-input-set-key (kbd "<XF86AudioNext>") #'spotify-next)
(exwm-input-set-key (kbd "<XF86AudioPrev>") #'spotify-previous)

;; (exwm-input-set-key exwm-workspace-move-window)

(defun sarg/run-or-raise (NAME PROGRAM)
  (interactive)
  (let ((buf (cl-find-if
              (lambda (buf) (string= NAME (buffer-name buf)))
              (buffer-list))))

    (if buf (switch-to-buffer buf)
      (start-process NAME nil PROGRAM))))

(defun sarg/with-browser ()
  "Opens browser side-by-side with current window"
  (interactive)
  (delete-other-windows)
  (set-window-buffer (split-window-horizontally) "qutebrowser"))

(exwm-input-set-key (kbd "s-p") 'sarg/with-browser)

;; TODO symon.el?

(require 'term)
(define-key term-raw-map (kbd "s-c") (lambda () (interactive) (term-send-raw-string "\C-c")))
(define-key term-raw-map (kbd "s-d") (lambda () (interactive) (term-send-raw-string "\C-d")))
(define-key term-raw-map (kbd "s-r") (lambda () (interactive) (term-send-raw-string "\C-r")))
