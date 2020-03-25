when HTTP_REQUEST {
	switch [HTTP::uri] {
		"/" -
		"/index.html" {
			HTTP::respond 200 content [ifile get index.html]
		}
		"/js/vendor/jquery-1.11.2.min.js" {
			HTTP::respond 200 content [ifile get jquery-1.11.2.min.js]
		}
		"/img/logo.jpg" {
			HTTP::respond 200 content [ifile get logo.jpg]
		}
		"/css/main.css" {
			HTTP::respond 200 content [ifile get main.css]
		}
		"/js/vendor/modernizr-2.8.3-respond-1.4.2.min.js" {
			HTTP::respond 200 content [ifile get modernizr-2.8.3-respond-1.4.2.min.js]
		}
		"/css/normalize.min.css" {
			HTTP::respond 200 content [ifile get normalize.min.css]
		}
	}
}