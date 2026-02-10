declare-option -docstring "grep command to use when searching for todo pattern" \
	str todo_grepcmd rg

declare-option -docstring "the todo-string to search for (default: 'TODO:')" \
	str todo_todostr TODO:

provide-module todo %{
    define-command -docstring %{
        todo: find all todo-comments in the working-directory
    } todo %{ evaluate-commands %sh{
        name="*TODO*"
        output=$(mktemp -d "${TMPDIR:-/tmp}"kak-info.XXXXXXXX)/fifo

        mkfifo ${output}

        ( eval "\"${kak_opt_todo_grepcmd}\" \"${kak_opt_todo_todostr}\" --vimgrep" > ${output} & ) > /dev/null 2>&1 < /dev/null
        printf %s\\n "
        	echo -debug 'output is ${output}'
        	edit! -readonly -fifo ${output} ${name}
        	hook -always -once buffer BufCloseFifo .* %{ nop %sh{ rm -r $(dirname ${output}) } } 
        	hook buffer NormalKey <ret> %{
            	evaluate-commands -save-regs /a %{
                    evaluate-commands -draft %{
                        execute-keys 'xs^(.+):(\d+):(\d+)<ret>'
                    	set-register a %reg{1} %reg{2} %reg{3}
                    }
              	 	edit -existing %reg{a}
            	}
        	}
        "
    }}
}
