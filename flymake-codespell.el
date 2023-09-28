;;; flymake-codespell.el --- A flymake handler for codespell  -*- lexical-binding: t; -*-

;; Copyright (c) 2023 Chmouel Boudjnah

;; Author: Chmouel Boudjnah <chmouel@chmouel.com>
;; URL: https://github.com/chmouel/flymake-codespell
;; Version: 0.1
;; Package-Requires: ((flymake-quickdef "0.1") (emacs "24"))

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <https://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Uses flymake-quickdef, from https://github.com/karlotness/flymake-quickdef
;;
;; Install:
;;
;; (unless (package-installed-p 'flymake-codespell)
;;     (package-vc-install "https://github.com/chmouel/flymake-codespell"))
;; (use-package flymake-codespell
;;   :hook
;;   (prog-mode .
;;              (lambda ()
;;                (require 'flymake-codespell)
;;                (add-hook 'flymake-diagnostic-functions 'flymake-check-codespell nil t))))
;;; Code:

(require 'flymake-quickdef)

(defconst flymake-codespell-err-regexp
  (rx bol (group (one-or-more (any alnum punct)))
      ":" (group (one-or-more digit))
      ":" space (group (one-or-more any))))

(flymake-quickdef-backend flymake-check-codespell
  :pre-let ((codespell-exec (executable-find "codespell")))
  :pre-check (unless codespell-exec (error "Cannot find codespell executable"))
  :write-type 'file
  :proc-form (list codespell-exec "-d" "-i0" fmqd-temp-file)
  :prep-diagnostic
  (let* ((lnum (string-to-number (match-string 2)))
         (text (match-string 3))
         (pos (flymake-diag-region fmqd-source lnum))
         (beg (car pos))
         (end (cdr pos))
         (type :warning)
         (msg text))
    (list fmqd-source beg end type msg))
  :search-regexp flymake-codespell-err-regexp)

(provide 'flymake-codespell)

;;; flymake-codespell.el ends here
