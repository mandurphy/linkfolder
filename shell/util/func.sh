m_jsonpath=""
jopen()
{
    m_jsonpath=$1
}

jget()
{
    if [ "$2" ] ;then
	    jq -r .$1 $2
    else
        jq -r .$1 $m_jsonpath
    fi
}

nfsBoot()
{
    if [ -z "`mount -t nfs`" ]; then
        return 1
    else
        return 0
    fi
}

procExists()
{
ps -ef | grep $1 | grep -v grep > /dev/null
return $?
}
