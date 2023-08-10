<!DOCTYPE html>
<html>
<head>
    <title>Result Page</title>
</head>
<body>
    <%
        Long generatedId = (Long) request.getAttribute("generatedId");
        if (generatedId != null) {
    %>
        <script>
            window.onload = function() {
                showIdMessage(<%= generatedId %>);
            };

            function showIdMessage(id) {
                var popup = document.createElement("div");
                popup.style.position = "fixed";
                popup.style.top = "50%";
                popup.style.left = "50%";
                popup.style.transform = "translate(-50%, -50%)";
                popup.style.backgroundColor = "#ffffff";
                popup.style.padding = "20px";
                popup.style.borderRadius = "5px";
                popup.innerHTML = "Your ID is: " + id + "<br><br>";
                popup.innerHTML += "Do you want to proceed to the new page?" + "<br><br>";
                popup.innerHTML += "<button onclick='proceedToNewPage()'>Yes</button>";
                popup.innerHTML += "<button onclick='closePopup()'>Close</button>";

                document.body.appendChild(popup);
            }

            function closePopup() {
                document.querySelector("div").style.display = "none";
            }

            function proceedToNewPage() {
                window.location.href = "login.jsp"; // Replace with the URL of your new page
            }
        </script>
    <% } %>
</body>
</html>
