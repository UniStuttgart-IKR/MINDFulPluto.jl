function get_dashboard_main_div(_n1_btn, _n1_sn, _n2_btn, _n2_sn, create_intent_bind, plot_selection_bind, draw_button_bind, compile_button_bind,
    uncompile_button_bind, install_button_bind, uninstall_button_bind, _intent_selection, _wanted_pos, _topology)

    html_div = @htl("""
 	<!--html-->
     <body>
     <div class="position-fixed top-0 end-0 p-3" style="z-index: 11" id="toast_container">

    </div>


     <div class="d-flex align-items-center justify-content-center">
     <div class=" d-flex main-card">
         <div class="left-wrapper">
             <div class="top-desc d-flex align-items-center">
                 <span class="container-fluid title-span justify-content-center align-items-center input-group-text no-border">MINDFulPlutoGUI v0.1</span>
             </div>


             <div class="menu-bar">
                 <div class="container">
                     <div class="row menu-buttons">
                         <button class="btn btn-outline-light btn-lg create-intent text-nowrap" onclick="

                        //show all cards 
                        document.querySelectorAll('.card').forEach((card, i) => {
                            card.style.display = 'block';
                        });

                        //hide last 2 cells 
                        var cells = document.querySelectorAll('.show_input ');
                        cells = Array.prototype.slice.call(cells, -2);
                        cells.forEach((cell, i) => {
                            cell.style.display = 'none';
                        });

                        document.querySelectorAll('.code_folded').forEach((card, i) => {
                                //if col in className of card 
                                if (card.className.includes('col')) {
                                    card.style.display = 'none';
                                }
                        });


                        cells = document.querySelectorAll('.code_folded ');
                        cells = Array.prototype.slice.call(cells, -2);

                        cells.forEach((cell, i) => {
                            cell.querySelector('.cm-editor').style.background = 'transparent';

                            cell.style.display = 'inline-block';
                            cell.style.verticalAlign = 'top';
                            cell.style.width = '30vw';
                            cell.style.maxWidth = '30vw';
                            cell.style.height = '50vh';
                            cell.style.margin = '2.5%';
                            cell.style.textAlign = 'start';

                            cell.style.background = 'rgba(217, 147, 232, 0.1)';
                            cell.style.borderRadius = '16px';
                            cell.style.boxShadow = '0 4px 30px rgba(0, 0, 0, 0.1)';

                            cell.style.padding = '20px 20px 20px 20px';

                            //find element pluto-trafficlight
                            cell.querySelector('pluto-trafficlight').style.display = 'none';

                            var log_container = cell.querySelector('pluto-logs-container');
                            if (log_container != null) {
                                log_container.style.display = 'transparent';
                            }

                            //remove pluto-log-icon
                            var log_icon = cell.querySelector('pluto-log-icon');
                            if (log_icon != null) {
                                log_icon.style.display = 'none';
                            }

                            //find class=Stdout and change style 
                            var stdout = cell.querySelector('pluto-log-dot')
                            if (stdout != null) {
                                stdout.style.background = 'transparent';
                                stdout.style.border = '2px solid #FFFFFF';
                            }
                            
                            var rich_output = cell.querySelector('pluto-output');
                            if (rich_output != null) {
                                rich_output.style.borderRadius = '16px';
                                rich_output.style.background = 'black';
                            }
                            

                        });

                        var p_nb = document.getElementsByTagName('pluto-notebook')[0];
                        p_nb.style.marginTop = '31vh';
                        p_nb.style.marginLeft = '20vw';
                        p_nb.style.marginRight = '-25vw';
                        p_nb.style.backgroundColor = 'transparent';

                        
                         
                      
                     ">
                             Visualisation
                         </button>
                     </div>
                     <div class="row menu-buttons">
                         <button class="btn btn-outline-light btn-lg create-intent text-nowrap">
                             Topology settings
                         </button>
                    </div>
                    <div class="row menu-buttons">
                        <button class="btn btn-outline-light btn-lg create-intent text-nowrap" onclick="

                            //hide all cards 
                            document.querySelectorAll('.card').forEach((card, i) => {
                                card.style.display = 'none';
                            });

                            Array.prototype.slice.call(document.querySelectorAll('.code_folded'), -3).forEach((card, i) => {
                                //if col in className of card 

                                card.style.display = 'none';
                            });

                            //get last 3 cells 
                            var cells = document.querySelectorAll('.show_input ');

                            //only last 3 cells 
                            cells = Array.prototype.slice.call(cells, -2);

                            //move cells to top of screen in a grid 
                            cells.forEach((cell, i) => {
                                cell.querySelector('.cm-editor').style.background = 'transparent';

                                cell.style.display = 'inline-block';
                                cell.style.verticalAlign = 'top';
                                cell.style.width = '30vw';
                                cell.style.margin = '2.5%';
                                cell.style.textAlign = 'start';

                                cell.style.background = 'rgba(217, 147, 232, 0.1)';
                                cell.style.borderRadius = '16px';
                                cell.style.boxShadow = '0 4px 30px rgba(0, 0, 0, 0.1)';

                                cell.style.padding = '20px 20px 20px 20px';

                                //find element pluto-trafficlight
                                cell.querySelector('pluto-trafficlight').style.display = 'none';

                                var log_container = cell.querySelector('pluto-logs-container');
                                if (log_container != null) {
                                    log_container.style.display = 'transparent';
                                }

                                //remove pluto-log-icon
                                var log_icon = cell.querySelector('pluto-log-icon');
                                if (log_icon != null) {
                                    log_icon.style.display = 'none';
                                }

                                //find class=Stdout and change style 
                                var stdout = cell.querySelector('pluto-log-dot')
                                if (stdout != null) {
                                    stdout.style.background = 'transparent';
                                    stdout.style.border = '2px solid #FFFFFF';
                                }
                                
                                

                            });

                            //change pluto-notebook style 
                            var p_nb = document.getElementsByTagName('pluto-notebook')[0];
                            p_nb.style.marginTop = '1.5vh';
                            p_nb.style.marginLeft = '20vw';
                            p_nb.style.marginRight = '-25vw';
                            p_nb.style.backgroundColor = 'transparent';

                            


                            
                         
                        ">
                             Developer Mode
                        </button>
                     </div>
                     <div class="row menu-buttons">
                         <button class="btn btn-outline-light btn-lg create-intent text-nowrap">
                             Alternative GUI?
                         </button>
                     </div>
                     <div class="row menu-buttons settings">
                         <button class="btn btn-outline-light btn-lg create-intent text-nowrap">
                             Dashboard settings
                         </button>
                     </div>
                 </div>
             </div>


         </div>

         <div class="container-fluid content">

             <div class="row flex-nowrap">
                 <div class="col">

                     <div class="card">
                         <div class="card-header text-center">
                             Intent Creation
                         </div>
                         <div class="card-body">

                             <div class="row flex-nowrap">
                                 <div class="col d-flex justify-content-center">
                                    $((_n1_sn))
                                 </div>
                                 <div class="col d-flex justify-content-center">
                                    $((_n1_btn))
                                 </div>
                             </div>
                             <div class="row flex-nowrap">
                                 <div class="col d-flex justify-content-center">
                                    $((_n2_sn))
                                 </div>
                                 <div class="col d-flex justify-content-center">
                                    $((_n2_btn))
                                 </div>
                             </div>
                             <div class="row flex-nowrap">
                                 <div class="col d-flex justify-content-center">
                                    $((create_intent_bind))
                                 </div>
                                 <div class="col d-flex justify-content-center">
                                    $((_topology))
                                 </div>
                             </div>

                         </div>
                     </div>

                 </div>
                 <div class="col">

                     <div class="card">
                         <div class="card-header text-center">
                             Intent Editing
                         </div>
                         <div class="card-body">

                             <div class="row flex-nowrap">
                                 <div class="col d-flex justify-content-center">
                                     <select class="form-select btn btn-outline-light btn-lg node" aria-label="Node 1">
                                         <option selected>Comp algo</option>
                                         <option value=1>1</option>
                                         <option value=2>2</option>
                                         <option value=3>3</option>
                                     </select>
                                 </div>
                                 <div class="col d-flex justify-content-center">
                                     <button class="btn btn-outline-light btn-lg create-intent node">
                                         Remove
                                     </button>
                                 </div>
                             </div>
                             <div class="row flex-nowrap">
                                 <div class="col d-flex justify-content-center">
                                    $((compile_button_bind))
                                 </div>
                                 <div class="col d-flex justify-content-center">
                                    $((uncompile_button_bind))
                                 </div>
                             </div>
                             <div class="row flex-nowrap">
                                 <div class="col d-flex justify-content-center">
                                    $((install_button_bind))
                                 </div>
                                 <div class="col d-flex justify-content-center">
                                    $((uninstall_button_bind))
                                 </div>
                             </div>

                         </div>
                     </div>


                 </div>
                 <div class="col">
                     <div class="card">
                         <div class="card-header text-center">
                             Drawing
                         </div>
                         <div class="card-body">

                             <div class="row flex-nowrap">
                                 <div class="col d-flex justify-content-center">
                                    $((_intent_selection))
                                 </div>
                                 <div class="col d-flex justify-content-center">
                                    $((draw_button_bind))
                                 </div>
                             </div>
                             <div class="row flex-nowrap">
                                 <div class="col d-flex justify-content-center">
                                    $((plot_selection_bind))
                                 </div>
                                 <div class="col d-flex justify-content-center">
                                     <button class="btn btn-outline-light btn-lg create-intent node">
                                         Remove
                                     </button>
                                 </div>
                             </div>
                             <div class="row flex-nowrap">
                                 <div class="col d-flex justify-content-center">
                                    $((_wanted_pos))
                                 </div>
                                 <div class="col d-flex justify-content-center">
                                     <button class="btn btn-outline-light btn-lg create-intent node">
                                         Placeholder
                                     </button>
                                 </div>
                             </div>

                         </div>
                     </div>
                 </div>
             </div>

         </div>
     </div>
 </div>
 </body>

 	<style>

        body {
            background: linear-gradient(40deg, hsla(237, 90%, 4%, 1) 0%, hsla(266, 85%, 20%, 1) 100%);
            
        }
        
        .main {
            height: 30vh;
        }
        
        .main-card {
            width: 90vw;
            height: 90vh;
        
            margin: 5vh 0 5vh 0;
        
            background: rgba(251, 168, 255, 0.12);
            border-radius: 16px;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
            backdrop-filter: blur(10px);
        }
        
        .menu-bar {
            height: 80vh;
            width: 10vw;
            padding: 2vh 1vw 2vh 1vw;
            margin: 2vh 2vw 2vh 2vh;

            padding-left: 12px;
            padding-right: 12px;
        }
        
        .top-desc {
            width: 10vw;
            height: 4vh;
            padding: 2vh 1vw 2vh 1vw;
            margin: 2vh 2vw 2vh 2vh;
        
            /*font-weight: bold;*/
            font-size: 16px;
            color: white;
        
            /*background: rgba(144, 81, 224, 0.34) !important;*/

            padding-left: 12px;
            padding-right: 12px;
        }
        
        .heading {
        
        }
        
        .menu-buttons {
            padding: 0vh 0 2vh 0;
            height: 5vh;
        }
        
        .settings {
            margin-top: 52vh;
        }
        
        .content {
            padding: 2vh 2vw 2vh 2vw;
        }
        
        .card, .menu-bar, .top-desc {
            background: rgba(217, 147, 232, 0.1);
            border-radius: 16px;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
            /*backdrop-filter: blur(10.2px);*/
        }
        
        .card-header {
            padding: 20px 20px 0px 20px;
            font-weight: bold;
            font-size: 30px;
            color: white;
        }
        
        .domain, .node {
            max-width: 10vw;
            margin: 1vh 0vw 0 0;
            width: 10vw;
            min-width: 4vw;
        }
        
        .create-intent {
            width: 10vw;
            min-width: 5vw;
        }

        .title-span {
            font-weight: bold;
            font-size: 16px;
            color: white;
            background: transparent;
            border: none;
        }
        
        /*.div-creating {*/
        /*    width: 30vw;*/
        /*    margin-left: 10vw;*/
        /*}*/
        
        .div-editing {
            width: 50vw;
            margin-right: 10vw;
        }
        
        .create-intent:hover, .domain:hover, .node:hover, .domain:focus, .node:focus {
            background: #359b9b;
            color: white;
        }
        
        .create-intent:focus {
            background-color: rgba(255, 255, 255, 0);
        
        }

        .toast {
            background: rgba(96, 50, 107, 0.6);
            border-radius: 16px;
            box-shadow: 0 4px 30px rgba(0, 0, 0, 0.1);
            margin-bottom: 1vh;
        }

        .toast-header {
            font-weight: bolder;
            color: white;
        }

        .toast-body {
            color: white;
        }



        .progress-bar {
            background: rgba(96, 50, 107, 0.6);
        }

    </style>
 	<!--!html-->
    """)

    return html_div


end


function testa()
    
end

export testa