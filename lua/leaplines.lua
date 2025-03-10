local function get_line_starts(direction, skip_range)
  local winid = vim.api.nvim_get_current_win()
  local _let_1_ = vim.fn.getwininfo(winid)
  local wininfo = _let_1_[1]
  local cur_line = vim.fn.line(".")
  local top
  if (direction == "down") then
    top = cur_line
  else
    top = wininfo.topline
  end
  local bottom
  if (direction == "up") then
    bottom = cur_line
  else
    bottom = wininfo.botline
  end
  local skip_range0 = (skip_range or 2)
  local targets = {}
  local lnum = top
  while (lnum <= bottom) do
    local fold_end = vim.fn.foldclosedend(lnum)
    if (fold_end ~= -1) then
      lnum = (fold_end + 1)
    else
      if ((lnum < (cur_line - skip_range0)) or (lnum > (cur_line + skip_range0))) then
        table.insert(targets, {pos = {lnum, 1}})
      else
      end
      lnum = (lnum + 1)
    end
  end
  do
    local cur_row = (vim.fn.screenpos(winid, cur_line, 1)).row
    local rows_from_cur
    local function _6_(t)
      local _let_7_ = t.pos
      local row = _let_7_[1]
      local col = _let_7_[2]
      local spos = vim.fn.screenpos(winid, row, col)
      local srow = spos.row
      return math.abs((cur_row - srow))
    end
    rows_from_cur = _6_
    local function _8_(t1, t2)
      return (rows_from_cur(t1) < rows_from_cur(t2))
    end
    table.sort(targets, _8_)
  end
  return targets
end
local function leap(direction, skip_range)
  return (require("leap")).leap({backward = (direction == "up"), targets = get_line_starts(direction, skip_range)})
end
return {leap = leap}
