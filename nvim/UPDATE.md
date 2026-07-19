# 변경 이력 (2026-07-18 ~ 2026-07-19)

LazyVim starter 기본 상태에서 아래 변경을 적용했다.

## 1. Go / Python LSP 활성화

### `lazyvim.json` (수정)

`extras` 배열에 언어 프리셋 두 개를 선언. 이 파일이 선언의 핵심으로,
새 머신에서 clone 후 nvim 실행 시 아래 도구들이 Mason으로 자동 설치된다.

```json
"extras": [
  "lazyvim.plugins.extras.lang.go",
  "lazyvim.plugins.extras.lang.python"
]
```

- `lang.go` → gopls, gofumpt, goimports, golangci-lint + Go treesitter 파서
- `lang.python` → pyright, ruff + venv-selector.nvim

### `lazy-lock.json` (자동 변경)

python extra가 추가한 `venv-selector.nvim` 항목이 기록됨.

## 2. VSCode 스타일 자동 호버

### `lua/config/options.lua` (수정)

```lua
vim.opt.updatetime = 500
```

커서가 멈춘 뒤 자동 호버(CursorHold)가 발동하기까지의 대기시간.
기본값 4000ms → 500ms.

### `lua/config/autocmds.lua` (수정)

LSP가 붙은 버퍼에서 커서를 올려두면(`CursorHold`) 자동으로
`vim.lsp.buf.hover({ border = "rounded" })`를 호출하는 autocmd 추가.
호버를 지원하는 서버가 attach된 버퍼에만 등록된다.

### `lua/config/keymaps.lua` (수정)

`K` 수동 호버도 자동 호버와 동일하게 둥근 테두리를 쓰도록 키맵 오버라이드.

## 3. 호버 팝업 테두리 (noice)

### `lua/plugins/noice.lua` (신규)

LazyVim에서는 noice.nvim이 LSP 호버 렌더링을 가로채기 때문에
`vim.lsp.buf.hover()`에 넘긴 border 옵션만으로는 테두리가 적용되지 않는다.
noice 쪽에서 두 가지를 설정:

- `presets.lsp_doc_border = true` — 호버/시그니처 문서 창에 둥근 테두리
- `routes`에 "No information available" 알림 숨김 — 자동 호버가 키워드·공백
  위에서 발동할 때 뜨는 불필요한 알림 제거

## 4. 문서

### `README.md` (수정)

- 활성화된 Extras(LSP) 섹션 추가 (lang.go, lang.python 설명)
- 디렉터리 구조의 `lazyvim.json` 설명 갱신
- 플러그인 표에 venv-selector.nvim 추가

## 저장소 외부 변경 (커밋 대상 아님)

- Mason(`~/.local/share/nvim/mason/`)에 gopls, gofumpt, goimports,
  golangci-lint, pyright, ruff 설치됨 — 새 머신에서는 extras 선언에 따라 자동 재설치
- Go treesitter 파서 6종(go, gomod, gosum, gowork 등) 컴파일됨

## 알려진 이슈

- `:LspConfig` 피커의 미리보기 패널에서
  `_provider_to_client_registration` nil 에러 발생 가능 — snacks.nvim이
  Neovim 0.12 전용 내부 API를 참조하는 업스트림 버그로, 실제 LSP 동작과는
  무관하며 무시해도 된다. (Neovim 0.11.6 + snacks.nvim 조합, 업스트림 수정 대기)
