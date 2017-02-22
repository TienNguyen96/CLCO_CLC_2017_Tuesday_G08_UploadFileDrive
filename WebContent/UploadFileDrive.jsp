<?xml version="1.0" encoding="UTF-8" ?>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Insert title here</title>
 <script type="text/javascript">
      var CLIENT_ID = '96178218174-f723mlkvgeoe833kqiuckgm3fq9n546s.apps.googleusercontent.com';
      var SCOPES = 'https://www.googleapis.com/auth/drive';
      function appendResults(url) {
        var results = document.getElementById('results');
        var a = document.createElement('a');
        a.href = url;
        results.appendChild(a);
        a.appendChild(document.createTextNode(url));
      }
      
      function createPublicFolder1(folderName) {
        var body = {
          'title': folderName,
          'mimeType': "application/vnd.google-apps.folder"
        };
        var request = gapi.client.drive.files.insert({
          'resource': body
        });
        request.execute(function(resp) {
          appendResults('http://googledrive.com/host/'+resp.id);
          var permissionBody = {
            'value': '',
            'type': 'anyone',
            'role': 'reader'
          };
          var permissionRequest = gapi.client.drive.permissions.insert({
            'fileId': resp.id,
            'resource': permissionBody
          });
          permissionRequest.execute(function(resp) { });
        });
      }
      /**
       * Called when the client library is loaded to start the auth flow.
       */
      function handleClientLoad() {
        window.setTimeout(checkAuth, 1);
      }
      /**
       * Check if the current user has authorized the application.
       */
      function checkAuth() {
        gapi.auth.authorize({
          'client_id': CLIENT_ID,
          'scope': SCOPES,
          'immediate': true}, handleAuthResult);
      }
      /**
       * Called when authorization server replies.
       *
       * @param {Object} authResult Authorization result.
       */
      function handleAuthResult(authResult) {
        var authButton = document.getElementById('authorizeButton');
        var filePicker = document.getElementById('publish');
        authButton.style.display = 'none';
        filePicker.style.display = 'none';
        if (authResult && !authResult.error) {
          // Access token has been successfully retrieved, requests can be sent to the API.
          filePicker.style.display = 'block';
          filePicker.onclick = uploadFile;          
        } else {
          // No access token could be retrieved, show the button to start the authorization flow.
          authButton.style.display = 'block';
          authButton.onclick = function() {
              gapi.auth.authorize({
                'client_id': CLIENT_ID,
                'scope': SCOPES,
                'immediate': false}, handleAuthResult);
          };
        }
      }
      /**
       * Start the file upload.
       *S
       * @param {Object} evt Arguments from the file selector.
       */
       
      function uploadFile(evt) {
        gapi.client.load('drive', 'v2', function() {
          var d = new Date();
          var t = (d.getTime() - d.getMilliseconds())/1000;
          createPublicFolder1("sdfsdđfsdfe");
        });
      }
    </script>
    <script type="text/javascript" src="https://apis.google.com/js/client.js?onload=handleClientLoad"></script>
</head>
<body>
	 <!--Add a file picker for the user to start the upload process -->
    
    <input type="button" id="publish" style="display: none" value="Publish" />
    <input type="button" id="authorizeButton" style="display: none" value="Authorize" />
    <div id="results"></div>
</body>
</html>