# leaplines.nvim

**leaplines** is a dead simple nvim plugin that leverages the power of
[leap.nvim](https://github.com/ggandor/leap.nvim) to give you an easy way to
jump to the start of a specific line.

Simply call `leaplines.leap` with a direction ("up" or "down"), and an optional
number of lines to skip around the cursor (default 2).

## Installation
### Lazy.nvim
```lua
{
  "Grazfather/leaplines.nvim",
  dependencies = "ggandor/leap.nvim",
  keys = {
    -- Sample mappings only
    {
      desc = "Leap line upwards",
      mode = {"n", "v"},
      "<leader>k",
      function()
        require("leaplines").leap("up")
      end,
    },
    {
      desc = "Leap line downwards",
      mode = {"n", "v"},
      "<leader>j",
      function()
        require("leaplines").leap("down")
      end,
    },
  }
}
```

### Packer
```lua
use({"Grazfather/leaplines.nvim"})
```
