currentlyOnDisplay = 0;
childrenArray = undefined;
function startUp(){
    childrenArray = $("#main-div").children();
    $("#main-div div").click(function () {
        $(childrenArray[currentlyOnDisplay]).animate(
            {
                left: "100%"
            }
        )
        $(childrenArray[(currentlyOnDisplay+1)%childrenArray.length]).animate(
            {
                left: "0%"
            }
        )
        childrenArray[(currentlyOnDisplay+2)%childrenArray.length].style.left = "-100%";
        childrenArray[(currentlyOnDisplay+3)%childrenArray.length].style.left = "-100%";

        currentlyOnDisplay += 1;
        currentlyOnDisplay = currentlyOnDisplay%childrenArray.length;
  });
}