Grab the latest version of nerdTree and stick following in
~/.vim/nerdtree_plugin/override_tab_mapping.vim
Create the file if not exist, also works for vundle installed nerdTree.

```vim
call NERDTreeAddKeyMap({'key': 't', 'callback': 'NERDTreeMyOpenInTab', 'scope': 'FileNode', 'override': 1 })
function NERDTreeMyOpenInTab(node)
    call a:node.open({'reuse': "all", 'where': 't'})
endfunction
```
