if [ ! -d $1 ]; then
    echo "-- clone --" && git clone $2 $1
fi && \
echo "-- cd $1 --" && cd $1 && \
echo "-- delete origin/HEAD --" && git remote set-head origin -d && \
echo "-- remote set-url https --" && git remote set-url origin $2 && \
for remote in `git branch -r`; do
    loc=${remote#origin/}
    if ! git branch | grep -q $loc ; then
        echo "-- track $remote --" && git branch --track $loc $remote
    fi
done && \
echo "-- fetch --" && git fetch --all && \
echo "-- pull --" && git pull --all && \
echo "-- remote set-url ssh --" && git remote set-url origin "git@github.com:csc59940/$1" && \
echo "-- push --" && git push --all
