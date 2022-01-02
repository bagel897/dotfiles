function! myspacevim#before() abort
  function! s:cargo_task() abort
      if filereadable('Cargo.toml')
          let commands = ['build', 'run', 'test']
          let conf = {}
          for cmd in commands
              call extend(conf, {
                          \ cmd : {
                          \ 'command': 'cargo',
                          \ 'args' : [cmd],
                          \ 'isDetected' : 1,
                          \ 'detectedName' : 'cargo:'
                          \ }
                          \ })
          endfor
          return conf
      else
          return {}
      endif
  endfunction
  function! s:make_tasks() abort
      if filereadable('Makefile')
          let subcmds = filter(readfile('Makefile', ''), "v:val=~#'^.PHONY'")
          let conf = {}
          for subcmd in subcmds
              let commands = split(subcmd)[1:]
              for cmd in commands
                  call extend(conf, {
                              \ cmd : {
                              \ 'command': 'make',
                              \ 'args' : [cmd],
                              \ 'isDetected' : 1,
                              \ 'detectedName' : 'make:'
                              \ }
                              \ })
              endfor
          endfor
          return conf
      else
          return {}
      endif
  endfunction
  call SpaceVim#plugins#tasks#reg_provider(function('s:make_tasks'))
  call SpaceVim#plugins#tasks#reg_provider(funcref('s:cargo_task'))
endfunction
