function send_toast(message, title="MINDFulPluto.jl")
    intent_names = [x["name"] for x in intent_list]
    intent_configs = [string(x["n1_sn"]) * "." * string(x["n1"]) * " -> " * string(x["n2_sn"]) * "." * string(x["n2"]) for x in intent_list]
    intent_toplogies = [x["topology"] for x in intent_list]
    intent_states = [get_intent_state(intent_list[i]["ibns"][intent_list[i]["sn"]], intent_list[i]["id"]) for i in 1:length(intent_list)]

    return @htl("""
    <!--html-->

    <script>
    
    add_toast_to_div($(title), $(message))

    //---------update intent-list---------

    //find intent list
    let intent_list = document.querySelector("#intent_selection_select");

    //find out which option was selected in intent_list
    let selected_value = intent_list.value;
    
    //clear intent list except first option
    while (intent_list.options.length > 1) {
        intent_list.remove(1);
    }
    
    //add intents to intent list
    $(intent_names).forEach((intent, i) => {
        let option = document.createElement("option");
        option.value = intent;
        option.innerHTML = intent;
        //check if intent was selected
        if (selected_value != undefined) {
            if (selected_value == intent) {
                option.selected = true;
            }
        }
        intent_list.appendChild(option);
    });
    console.log("updated intent list with selected intent: " + selected_value);

    //---------update intent-table---------

    let intent_names = $(intent_names);
    let intent_configs = $(intent_configs);
    let intent_toplogies = $(intent_toplogies);
    let intent_states = $(intent_states);

    console.log(intent_states);
    let intent_table = document.querySelector(".table > tbody");

    //clear all <tr> except first one
    while (intent_table.childElementCount > 0) {
        intent_table.removeChild(intent_table.lastChild);
    }

    //add new <tr> for each intent
    intent_names.forEach((intent_name, index) => {
        let new_row = document.createElement("tr");
        new_row.innerHTML = `
            <th scope="row">\${index + 1}</th>
            <td>\${intent_name}</td>
            <td>\${intent_toplogies[index]}</td>
            <td>\${intent_configs[index]}</td>
            <td>\${intent_states[index]}</td>
        `;
        intent_table.appendChild(new_row);
    });

    </script>
    <!--!html-->
    """)
    

end