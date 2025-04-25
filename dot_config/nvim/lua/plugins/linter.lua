return {
  "mfussenegger/nvim-lint",
  opts = {
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },

    linters_by_ft = {
      fish = { "fish" },

      bzl = { "buildifier" },
    },
  },
}
