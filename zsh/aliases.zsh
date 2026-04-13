# Git
alias g='git'
alias push='git push'
alias pull='git pull'
alias ch='git checkout'
alias ad='git add .'
alias gm='git commit -m'
alias stash='g stash -u'
alias stag='git checkout staging;git pull origin staging'
alias dev='git checkout develop;git pull origin develop'
alias mas='git checkout master;git pull origin master'
alias ddb="git branch --merged|egrep -v '\*|develop|staging|master|main'|xargs git branch -d"

# Git worktree
alias gwa='f(){ git worktree add -b feature/$1 ../worktree-$1 develop; unset -f f; }; f'
alias gwl='git worktree list'

# git-gtr
alias gn="git gtr new"
alias ga="git gtr ai"
alias gr="git gtr rm"

# GitHub CLI
alias ghb='gh browse'
alias ghbb='gh pr view -w'
alias ghc='gh pr create -w'

# React Native
alias ns='npm start'
alias nd='nr dev'
alias andcp='mkdir -p android/app/src/main/assets & cp stockEditor/dist/index.html android/app/src/main/assets/index.html'
alias rand='npx react-native run-android'
alias rios='npx react-native run-ios'
alias bland='./android/gradlew --project-dir ./android assembleRelease'
alias device='adb devices'

# Tools
alias ccd="claude --dangerously-skip-permissions"
