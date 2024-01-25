using HypertextLiteral

function get_html_select(class_name, label, options)
    return @htl("""
        <!--html-->
            <select class="form-select btn btn-outline-light btn-lg domain $(class_name)" aria-label="$(label)">
                <option selected>$(label)</option>
                $([htl"<option> $(i) </option>" for i in options])
            </select>
        <!--!html-->
        """)
end

function get_html_select(class_name, label, options, id)
    return @htl("""
        <!--html-->
            <select class="form-select btn btn-outline-light btn-lg domain $(class_name)" aria-label="$(label)" id="$(id)">
                <option selected>$(label)</option>
                $([htl"<option> $(i) </option>" for i in options])
            </select>
        <!--!html-->
        """)
end

function get_html_button(class_name, label)
    return @htl("""
        <!--html-->
            <button class="btn btn-outline-light btn-lg create-intent node $(class_name)">
                $(label)
            </button>
        <!--!html-->
        """)
end

function get_html_button(class_name, label, onclick)
    return @htl("""
        <!--html-->
            <button class="btn btn-outline-light btn-lg create-intent node $(class_name)" onclick="$(onclick)">
                $(label)
            </button>
        <!--!html-->
        """)
end