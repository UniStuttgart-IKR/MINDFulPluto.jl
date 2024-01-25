function send_toast(message, title="MINDFulPluto.jl")
    return @htl("""
    <!--html-->

    <script>
    
    add_toast_to_div($(title), $(message))

    </script>
    <!--!html-->
    """)
    

end