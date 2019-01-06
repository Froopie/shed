default: bundles

server:
		node src/server.js

deps:
		npm install

docker-image:
		docker -t shed/runner .

OT_FILES = text-operation.js selection.js wrapped-operation.js undo-manager.js client.js codemirror-adapter.js socketio-adapter.js ajax-adapter.js editor-client.js
OT_DEPS = $(patsubst %, src/ot.js/%, $(OT_FILES))
bundle-ot: $(OT_DEPS)
		awk '{print $0}' $^ > src/client/js/ot.js

CM_FILES = lib/codemirror.js addon/mode/loadmode.js keymap/vim.js keymap/emacs.js addon/search/search.js addon/search/searchcursor.js addon/search/jump-to-line.js addon/dialog/dialog.js mode/meta.js mode/python/python.js mode/clike/clike.js mode/ruby/ruby.js mode/javascript/javascript.js
CM_DEPS = $(patsubst %, node_modules/codemirror/%, $(CM_FILES))
bundle-codemirror: $(CM_DEPS)
		cat $^ > src/client/js/codemirror.js

CSS_FILES = node_modules/codemirror/lib/codemirror.css node_modules/codemirror/addon/dialog/dialog.css src/client/css/editor.css src/client/css/themes.css src/client/css/bootstrap.css 
bundle-css: $(CSS_FILES)
		cat $^ > src/client/dist/all.css

bundles: bundle-ot bundle-codemirror bundle-css

.PHONY:clean

clean:
		rm src/client/js/codemirror.js src/client/dist/all.css