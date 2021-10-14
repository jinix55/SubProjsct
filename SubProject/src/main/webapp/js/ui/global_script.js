
   function sortTable(table, col, reverse) {
     var tb = table.tBodies[0], //use '<tbody>' to ignore '<thead>' and '<tfoot>' rows
         tr = Array.prototype.slice.call(tb.rows,0), //put rows into Array
         i;
         reverse =-((+reverse) || -1);
         tr = tr.sort(function (a,b){ // sort rows
           return reverse // '-1 *' if want opposite border
           *(a.cells[col].textContent.trim() // using '.textContent.trim()' for test
           .localeCompare(b.cells[col].textContent.trim())
         );
       });
         for(i = 0; i < tr.length; ++i) tb.appendChild(tr[i]); //append each row in order
   }

   function makeSortable(table){
           var th = table.tHead, i;
           th && (th = th.rows[0]) && (th = th.cells);
           if (th) i = th.length;
           else return;
           while (--i >= 0) (function(i){
             var dir = 1 ;
             th[i].addEventListener('click', function() {sortTable(table, i, (dir = 1 - dir))});
           }(i));
   }
   function makeAllSortable (parent){
     parent = parent || document.body;
     var t = parent.getElementsByTagName('table'), i = t.length;
     while (--i >= 0) makeSortable(t[i]);
   }
//체크박스//
   var $cbAll = $("#cbAll");
   $cbAll.change(function(){
     var $this = $(this);
     var checked = $this.prop('checked');
     $('input[name="cb"]').prop('checked', checked);

     if(document.querySelector('input[name="cb"]').checked == true){
       document.getElementById("cbAll").classList.remove("notAll");
       document.querySelector(".btn_delete").disabled = false;
     } else {
       //prompt("테스트");confirm("sds");

       document.querySelector(".btn_delete").disabled = true;
     }
   });

   var boxes = $('input[name="cb"]');
   boxes.change(function(){
     var boxLength = boxes.length;
     var checkedLength = $('input[name="cb"]:checked').length;
     var selectAll = (boxLength == checkedLength);

     $cbAll.prop('checked', selectAll);

     if (checkedLength > 0){
       document.querySelector(".btn_delete").disabled = false;
       document.getElementById("cbAll").classList.add("notAll");
       if (selectAll){
         document.getElementById("cbAll").classList.remove("notAll");
       }
     } else {
       document.querySelector(".btn_delete").disabled = true;
       document.getElementById("cbAll").classList.remove("notAll");
     }
   });
//체크박스//

   function customSelectBox(){
     var customSelectEle, i, j, selElmnt, divEle, divEleSelected, c;
     customSelectEle = document.querySelector(".custom_select");
     selElmnt = customSelectEle.getElementsByTagName("select")[0];
     divEle = document.createElement("DIV");
     divEle.setAttribute("class","select_selected");
     divSpan = document.createElement("span");
     divSpan = divEle.appendChild(divSpan)
     divSpan.innerHTML = selElmnt.options[selElmnt.selectedIndex].innerHTML;
     customSelectEle.appendChild(divEle);
     if(divEle.children[0].innerHTML == "분류"){
       divEle.children[0].classList.add("color_lightGray");
     }
     divEleSelected = document.createElement("ul");
     divEleSelected.setAttribute("class","select_items select_hide");
     Array.from(selElmnt).forEach((item, index) => {
       c = document.createElement("li");
       cSpan = document.createElement("span");
       cSpan = c.appendChild(cSpan);
       cSpan.innerHTML = selElmnt.options[index].innerHTML;
       c.addEventListener("click", function(e){
         var y, i, k, selEleParent, selEleSibling;
         selEleParent = this.parentNode.parentNode.getElementsByTagName("select")[0];
         selEleSibling = this.parentNode.previousSibling;
         for ( i = 0; i < selEleParent.length; i++){
           if (selEleParent.options[i].innerHTML == this.children[0].innerHTML){
               selEleParent.selectedIndex = i;
               selEleSibling.innerHTML = this.innerHTML;
               y = this.parentNode.getElementsByClassName("sameSelected");
               for (k = 0; k < y.length; k++){
                 y[k].removeArribute("class");
               }
               this.setAttribute("class","sameSelected");
               break;
           }
         }
         selEleSibling.click();
       });
       divEleSelected.appendChild(c);
       if(c.children[0].innerHTML == "분류"){
         c.children[0].classList.add("color_lightGray")
       }
     });
     customSelectEle.appendChild(divEleSelected);
     divEle.addEventListener("click", function(e){
       e.stopPropagation();
       closeSelect(this);
       this.nextSibling.classList.toggle("select_hide");
       this.classList.toggle("select_arrow_active");
     });
     var text = document.getElementsByClassName("");
     function closeSelect(elmnt){
       var customSelectEle, y, i,
       arrNo = [];
       customSelectEle = document.getElementsByClassName("select_items");
       y = document.getElementsByClassName("select_selected");
       for ( i = 0; i < y.length; i++){
         if (elmnt == y[i]){
           arrNo.push(i);
         }
         else {
           y[i].classList.remove("select_arrow_active");
         }
       }
       for ( i = 0; i < customSelectEle.length; i++){
         if (arrNo.indexOf(i)){
           customSelectEle[i].classList.add("select_hide");
         }
       }
     }
     document.addEventListener("click", closeSelect);
   }


   function gnbAccordion(){
     var acc = document.querySelectorAll(".accordion");
     for (var i = 0; i < acc.length; i++){
       acc[i].addEventListener("click", function(){
         let alreadyActive = this.classList.contains("accordion_active");
         document.querySelectorAll(".gnb_menu .panel").forEach(function(panel){
           panel.style.maxHeight = "0";
           panel.previousElementSibling.classList.remove("accordion_active");
         });
         if(this.nextElementSibling){
         }else {
         }
         if (!alreadyActive){
           this.classList.add("accordion_active");
           if(this.nextElementSibling){
             var panel =this.nextElementSibling;
             panel.style.maxHeight = panel.scrollHeight + "px";
           }
           } else {
           }
         });
       }
     }

   function user(){
     document.querySelector(".btn_gnb_user").addEventListener("click", function(){
       this.parentNode.classList.toggle("on");
     })
   }
   function userAccordion(){
     var acc= document.querySelectorAll('.accordion_user');
     var i;
     for (i = 0; i < acc.length; i++) {
       acc[i].addEventListener('click', function() {
         let alreadyActive = this.classList.contains("accordion_active");
         document.querySelectorAll(".gnb_user .panel").forEach(function(panel){
           panel.style.maxHeight = "0";
           pabnel.previouseElementSibling.classList.remove("accordion_active");
         });
         if (!alreadyActive){
           this.classList.add("accordion_active");
           var panel =this.nextElementSibling;
           panel.style.maxHeight = panel.scrollHeight + "px";
         }
       });
     }
   }
   window.onload = function(){
     makeAllSortable();
     customSelectBox();
     user();
     gnbAccordion();
   };
 //달력
 $(function() {
    //input을 datepicker로 선언
    $("#datepicker").datepicker();
    //$("#datepicker2").datepicker();

    //From의 초기값을 오늘 날짜로 설정
    $('#datepicker').datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
    //To의 초기값을 내일로 설정
    //$('#datepicker2').datepicker('setDate', '+1D'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
 });
