local paredit = require("nvim-paredit.api")

local prepare_buffer = require("tests.nvim-paredit.utils").prepare_buffer
local expect = require("tests.nvim-paredit.utils").expect

describe("element raising", function()
  vim.api.nvim_set_option_value("filetype", "janet", {
    buf = 0,
  })

  it("should raise the element", function()
    prepare_buffer({
      content = "(a (b))",
      cursor = { 1, 4 },
    })
    paredit.raise_element()
    expect({
      content = "(a b)",
      cursor = { 1, 3 },
    })
  end)

  it("should raise form elements when cursor is placed on edge", function()
    prepare_buffer({
      content = "(a (b))",
      cursor = { 1, 3 },
    })

    paredit.raise_element()
    expect({
      content = "(b)",
      cursor = { 1, 0 },
    })

    prepare_buffer({
      content = "(a @[b])",
      cursor = { 1, 3 },
    })

    paredit.raise_element()
    expect({
      content = "@[b]",
      cursor = { 1, 0 },
    })
    prepare_buffer({
      content = "(a [b])",
      cursor = { 1, 3 },
    })

    paredit.raise_element()
    expect({
      content = "[b]",
      cursor = { 1, 0 },
    })
    prepare_buffer({
      content = "(a @{:a b})",
      cursor = { 1, 3 },
    })
    paredit.raise_element()
    expect({
      content = "@{:a b}",
      cursor = { 1, 0 },
    })
    prepare_buffer({
      content = "(a {:a b})",
      cursor = { 1, 3 },
    })
    paredit.raise_element()
    expect({
      content = "{:a b}",
      cursor = { 1, 0 },
    })
  end)

  it("should do nothing if it is a direct child of the document root", function()
    prepare_buffer({
      content = { "a", "b" },
      cursor = { 1, 0 },
    })
    paredit.raise_form()
    expect({
      content = { "a", "b" },
      cursor = { 1, 0 },
    })
  end)
end)
