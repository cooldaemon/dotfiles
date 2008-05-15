if !exists('loaded_snippet') || &cp
    finish
endif

let st = g:snip_start_tag
let et = g:snip_end_tag
let cd = g:snip_elem_delim

exec "Snippet xml <?xml version=\"1.0\" encoding=\"utf-8\"?><CR>"

exec "Snippet ap <mx:Application<CR>\<TAB>xmlns:mx=\"http://www.adobe.com/2006/mxml\"<CR>xmlns:dc=\"dsp.*\"<CR>horizontalAlign=\"".st.et."\" verticalAlign=\"".st.et."\"<CR>\<BS>><CR>\<TAB>".st.et."<CR>\<BS></mx:Application>"

exec "Snippet vb <mx:VBox<CR>\<TAB>xmlns:mx=\"http://www.adobe.com/2006/mxml\"<CR>horizontalAlign=\"".st.et."\" verticalAlign=\"".st.et."\"<CR>\<BS>><CR>\<TAB>".st.et."<CR>\<BS></mx:VBox>"
exec "Snippet hb <mx:HBox><CR>\<TAB>".st.et."<CR>\<BS></mx:HBox>"

exec "Snippet sp <mx:Spacer><CR>".st.et

exec "Snippet cdata <![CDATA[".st.et."]]><CR>"

exec "Snippet hr <mx:HRule width=\"".st.et."\" /><CR>".st.et

exec "Snippet panel <mx:Panel<CR>\<TAB>title=\"".st.et."\"<CR>paddingTop=\"".st.et."\" paddingBottom=\"".st.et."\"<CR>paddingLeft=\"".st.et."\" paddingRight=\"".st.et."\"<CR>\<BS>><CR>\<TAB>".st.et."<CR>\<BS></mx:Panel>"

exec "Snippet vs <mx:ViewStack id=\"".st.et."\" historyManagementEnabled=\"true\"><CR>\<TAB><dc:".st.et." id=\"".st.et."\" /><CR>\<BS></mx:ViewStack><CR>".st.et

exec "Snippet model <mx:Model id=\"".st.et."\"><CR>\<TAB><info><CR>\<TAB>".st.et."<CR>\<BS></info><CR>\<BS></mx:Model>"

exec "Snippet btn <mx:Button label=\"".st.et."\" click=\"".st.et."\" />".st.et
exec "Snippet chk <mx:CheckBox id=\"".st.et."\" label=\"".st.et."\" />".st.et
exec "Snippet radio <mx:RadioButtonGroup id=\"".st."GroupName".et."\" /><CR><mx:RadioButton label=\"".st.et."\" value=\"".st.et."\" groupName=\"".st."GroupName".et."\" /><CR><mx:RadioButton label=\"".st.et."\" value=\"".st.et."\" groupName=\"".st."GroupName".et."\" /><CR>".st.et

exec "Snippet label <mx:Label text=\"".st.et."\" toolTip=\"".st.et."\" /><CR>".st.et
exec "Snippet labelb <mx:Label><CR>\<TAB>".st.et."<CR>\<BS></mx:Label>"
exec "Snippet labelm <mx:Label text=\"{'".st.et."'}\" /><CR>"

exec "Snippet text <mx:Text text=\"".st.et."\" /><CR>".st.et
exec "Snippet textb <mx:Text><CR>\<TAB>".st.et."<CR>\<BS></mx:Text>"
exec "Snippet textm <mx:Text text=\"{'".st.et."'}\" /><CR>"

exec "Snippet textc <mx:text><CR>\<TAB>".st.et."<CR>\<BS></mx:text>"

exec "Snippet html <mx:htmlText><![CDATA[<CR>\<TAB>".st.et."<CR>\<BS>]]></mx:htmlText>"

exec "Snippet tinp <mx:TextInput id=\"".st.et."\" text=\"".st.et."\" maxChars=\"".st.et."\" /><CR>".st.et
exec "Snippet tinpb <mx:TextInput id=\"".st.et."\"><CR>\<TAB>".st.et."<CR>\<BS></mx:TextInput>"
exec "Snippet tinpp <mx:TextInput id=\"".st.et."\" text=\"".st.et."\" maxChars=\"".st.et."\" displayAsPassword=\"true\" /><CR>".st.et
exec "Snippet tinphk <mx:TextInput id=\"".st.et."\" text=\"".st.et."\" maxChars=\"".st.et."\" imeMode=\"{IMEConversionMode.JAPANESE_KATAKANA_HALF}\" /><CR>".st.et
exec "Snippet tinpzk <mx:TextInput id=\"".st.et."\" text=\"".st.et."\" maxChars=\"".st.et."\" imeMode=\"{IMEConversionMode.JAPANESE_KATAKANA_FULL}\" /><CR>".st.et
exec "Snippet tinputa <mx:TextInput id=\"".st.et."\" text=\"".st.et."\" maxChars=\"".st.et."\" restrict=\"A-Za-z\" /><CR>".st.et

exec "Snippet tarea <mx:TextArea id=\"".st.et."\" text=\"".st.et."\" /><CR>".st.et
exec "Snippet tareab <mx:TextArea id=\"".st.et."\"><CR>\<TAB>".st.et."<CR>\<BS></mx:TextArea>"
exec "Snippet tareap <mx:TextArea id=\"".st.et."\" text=\"".st.et."\" displayAsPassword=\"true\" /><CR>".st.et
exec "Snippet tareahk <mx:TextArea id=\"".st.et."\" text=\"".st.et."\" imeMode=\"{IMEConversionMode.JAPANESE_KATAKANA_HALF}\" /><CR>".st.et
exec "Snippet tareaa <mx:TextArea id=\"".st.et."\" text=\"".st.et."\" restrict=\"A-Za-z\" /><CR>".st.et
exec "Snippet taream <mx:TextArea id=\"".st.et."\" text=\"{'".st.et."'}\" /><CR>"

exec "Snippet rtext <mx:RichTextEditor id=\"".st.et."\" /><CR>".st.et

exec "Snippet num <mx:NumericStepper id=\"".st.et."\" value=\"".st.et."\" minimum=\"".st.et."\" maximum=\"".st.et."\" />".st.et

exec "Snippet date <mx:DateField id=\"".st.et."\" selectedDate=\"{new Date(".st.et.")}\" yearNavigationEnabled=\"true\" editable=\"true\" dayNames=\"['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat']\" monthSymbol=\"".st.et."\" yearSymbol=\"".st.et."\" formatString=\"YYYY/MM/DD\" /><CR>".st.et

