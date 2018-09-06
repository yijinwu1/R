use.switch <- function(x) {
  switch(x,
         "a"="first",
         "b"="second",
         "z"="last",
         "D"="third",
         "1"=1,
         "other")
}

use.switch("d")

use.switch(1) #answer first
use.switch(2) #answer second
use.switch(3) #answer last
use.switch(4) #answer third
use.switch(5) #answer 1
use.switch(6) #answer other
use.switch(7) #no answer because only "a,b,z,D,1,other" six number
