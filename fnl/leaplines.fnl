(fn get-line-starts [direction skip-range]
  (let [winid (vim.api.nvim_get_current_win)
        [wininfo] (vim.fn.getwininfo winid)
        cur-line (vim.fn.line ".")
        top (if (= direction :down) cur-line wininfo.topline)
        bottom (if (= direction :up) cur-line wininfo.botline)
        skip-range (or skip-range 2)
        targets []]
    (var lnum top)
    (while (<= lnum bottom)
      (local fold-end (vim.fn.foldclosedend lnum))
      ; Skip over folded ranges
      (if (not= fold-end -1)
        (set lnum (+ fold-end 1))
        (do
          (when (or (< lnum (- cur-line skip-range)) (> lnum (+ cur-line skip-range)))
            (table.insert targets {:pos [lnum 1]}))
          (set lnum (+ lnum 1)))))

    ; Sort them by vertical screen distance from cursor.
    (let [cur-row (. (vim.fn.screenpos winid cur-line 1) :row)
          rows-from-cur (fn [t]
                          (let [[row col] t.pos
                                spos (vim.fn.screenpos winid row col)
                                srow (. spos :row)]
                            (math.abs (- cur-row srow))))]
      (table.sort targets (fn [t1 t2]
                            (< (rows-from-cur t1) (rows-from-cur t2)))))
    targets))

(fn leap [direction skip-range]
  ((. (require :leap) :leap) {:backward (= direction :up)
                              :targets (get-line-starts direction skip-range)}))

{: leap}
