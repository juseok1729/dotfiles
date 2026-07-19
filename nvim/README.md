# 💤 Neovim 설정 (LazyVim)

[LazyVim](https://github.com/LazyVim/LazyVim) starter 템플릿 기반의 개인 Neovim 설정입니다.
플러그인 매니저는 [lazy.nvim](https://github.com/folke/lazy.nvim)을 사용하며, 첫 실행 시 자동으로 부트스트랩됩니다.

## 디렉터리 구조

```
~/.config/nvim
├── init.lua                    # 진입점 — config.lazy 로드
├── lua/
│   ├── config/
│   │   ├── lazy.lua            # lazy.nvim 부트스트랩 및 설정
│   │   ├── options.lua         # updatetime 등 추가 옵션
│   │   ├── keymaps.lua         # K 호버 키맵 오버라이드
│   │   └── autocmds.lua        # 커서 호버 자동 표시 autocmd
│   └── plugins/
│       ├── colorscheme.lua     # tokyonight 커스터마이징
│       └── noice.lua           # 호버 문서 테두리 + 알림 필터
├── lazy-lock.json              # 플러그인 버전 락파일 (커밋 대상)
├── lazyvim.json                # LazyVim extras 선언 (lang.go, lang.python 활성화)
├── stylua.toml                 # Lua 포매터 설정 (2칸 들여쓰기, 120자)
└── .neoconf.json               # lua_ls / neodev 설정
```

## 활성화된 Extras (LSP)

`lazyvim.json`에 선언된 언어별 프리셋입니다. 이 파일이 선언적 관리의 핵심으로,
새 머신에서 clone 후 nvim을 실행하면 아래 도구들이 Mason으로 자동 설치됩니다.

- **`lang.go`** — gopls(LSP), gofumpt/goimports(포맷), golangci-lint(린트), Go treesitter 파서
- **`lang.python`** — pyright(LSP), ruff(린트/포맷 LSP), venv-selector.nvim(가상환경 선택)

extras 추가/제거는 `:LazyExtras` UI를 쓰거나 `lazyvim.json`의 `extras` 배열을 직접 편집하면 됩니다.
전체 목록: https://www.lazyvim.org/extras

## 커스터마이징 내역

### 컬러스킴 (`lua/plugins/colorscheme.lua`)

- **tokyonight** 테마에 투명 배경 적용 (`transparent = true`, 사이드바/플로팅 창 포함)
- `CursorLine`: 배경색 대신 밑줄로 표시
- `CursorLineNr`: 흰색 볼드
- `Visual`: 반전(reverse) 스타일

### VSCode 스타일 자동 호버

함수/변수 위에 커서를 올려두면 0.5초 뒤 문서 팝업이 자동으로 뜹니다.
세 파일에 나뉘어 구현되어 있습니다:

- `lua/config/options.lua` — `updatetime = 500` (호버 발동 대기시간)
- `lua/config/autocmds.lua` — LSP attach된 버퍼에서 `CursorHold` 시
  `vim.lsp.buf.hover()` 자동 호출
- `lua/config/keymaps.lua` — `K` 수동 호버도 자동 호버와 동일한
  둥근 테두리를 쓰도록 오버라이드

### noice 설정 (`lua/plugins/noice.lua`)

LazyVim에서는 noice.nvim이 LSP 호버 렌더링을 담당하므로 테두리도 noice에서 설정합니다:

- `presets.lsp_doc_border = true` — 호버/시그니처 문서 창에 둥근 테두리
- "No information available" 알림 숨김 라우트 — 자동 호버가 키워드·공백
  위에서 발동할 때 뜨는 불필요한 알림 제거

LazyVim 기본 options / keymaps / autocmds 목록은 `lua/config/` 각 파일
상단 주석의 LazyVim 소스 링크를 참고하세요.

## 주요 플러그인

LazyVim 기본 구성으로 설치되는 플러그인들입니다 (버전은 `lazy-lock.json`에 고정):

| 분류 | 플러그인 |
|---|---|
| 코어 | lazy.nvim, LazyVim, snacks.nvim, plenary.nvim |
| LSP / 도구 설치 | nvim-lspconfig, mason.nvim, mason-lspconfig.nvim, lazydev.nvim |
| 자동완성 / 스니펫 | blink.cmp, friendly-snippets |
| 문법 / 편집 | nvim-treesitter(+textobjects), nvim-ts-autotag, ts-comments.nvim, mini.ai, mini.pairs, flash.nvim |
| 포맷 / 린트 | conform.nvim, nvim-lint |
| Git | gitsigns.nvim |
| UI | tokyonight.nvim, catppuccin, bufferline.nvim, lualine.nvim, noice.nvim, nui.nvim, mini.icons, which-key.nvim |
| 검색 / 탐색 | grug-far.nvim, todo-comments.nvim, trouble.nvim |
| 세션 | persistence.nvim |
| 언어 extras | venv-selector.nvim (python) |

## 설치 (dotfiles로 사용하기)

### 새 머신에 설치

```sh
# 기존 설정 백업 (선택)
mv ~/.config/nvim ~/.config/nvim.bak
mv ~/.local/share/nvim ~/.local/share/nvim.bak

# 이 저장소 클론
git clone <이 저장소 URL> ~/.config/nvim

nvim   # 첫 실행 시 lazy.nvim이 자동으로 플러그인 설치
```

### dotfiles 저장소에서 심볼릭 링크로 관리하는 경우

```sh
ln -s ~/dotfiles/nvim ~/.config/nvim
```

## 유지보수

- `:Lazy` — 플러그인 관리 UI (업데이트 확인은 백그라운드에서 자동 실행, 알림은 꺼져 있음)
- `:Lazy update` — 플러그인 업데이트 후 `lazy-lock.json` 갱신 → 커밋해두면 다른 머신에서 동일 버전 재현 가능
- `:Lazy restore` — 락파일 기준으로 플러그인 버전 복원
- `:LazyExtras` — LazyVim extras(언어별 프리셋 등) 활성화 → `lazyvim.json`에 기록됨
- `:LazyHealth` — 설치 상태 점검

## 요구 사항

- Neovim >= 0.9 (최신 안정판 권장)
- git, [Nerd Font](https://www.nerdfonts.com/) (아이콘 표시용)
- ripgrep, fd (검색 기능용 권장)
- 투명 배경을 지원하는 터미널 (tokyonight transparent 설정 사용 중)
