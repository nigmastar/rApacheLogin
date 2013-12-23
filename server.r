

library("svSocket")
startSocketServer()

users <- data.frame(id=1:4,
                    username=c("michele", "antonio",
                               "john", "lucas"),
                    password=c("12345", "hello",
                               "qwerty", "asdfg"),
                    session_id=0,
                    stringsAsFactors=FALSE)
