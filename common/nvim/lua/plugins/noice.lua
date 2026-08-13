return {
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      -- 호버/시그니처 문서 창에 둥근 테두리 (noice가 LSP 호버 렌더링을 담당하므로 여기서 설정)
      opts.presets = opts.presets or {}
      opts.presets.lsp_doc_border = true

      opts.routes = opts.routes or {}
      -- 자동 호버 시 문서가 없는 위치(키워드, 공백 등)에서 뜨는 알림 숨김
      table.insert(opts.routes, {
        filter = { event = "notify", find = "No information available" },
        opts = { skip = true },
      })
    end,
  },
}
