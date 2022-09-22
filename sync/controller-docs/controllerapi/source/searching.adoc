== Searching

Use the search query string parameter to perform a case-insensitive
search within all designated text fields of a model (added in AWX 1.4):

....
http://<server name>/api/v2/model_verbose_name?search=findme
....

Search across related fields (added in AWX 1.4 / automation controller
3.1):

....
http://<server name>/api/v2/model_verbose_name?related__search=findme
....
