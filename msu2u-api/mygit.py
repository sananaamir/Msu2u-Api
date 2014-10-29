from subprocess import call
import sys

if __name__ == "__main__":

    if len(sys.argv) < 2:
         print 'Usage: mygit branchname "comment" \n Example: mygit web "first commit"'
         sys.exit(0)

#    alias = sys.argv[1]
    comment = sys.argv[1]

    call(["git" , "add" , "-A"])
    call(["git" , "commit", "-m", comment])
    call(["git" , "push" , "phalcon" , "master"]);
    call(["git" , "push" , "origin" , "master"]); 
    #call(["git" , "push" ,alias , "+master:refs/heads/master"]);
