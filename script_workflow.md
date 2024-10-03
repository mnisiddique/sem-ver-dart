1. Get current version
   a) From firebase if normal build
   b) Or from app/playstore for store build
   c) on unavailable 
   d) use latest git tag
   e) if git tag is unavialable use default base version 1.0.0
   f) on network or api failure simply exit
2. Get commit list of current branch
   note 1: git show-branch (can list all branch with commit)
   note 2: git log --oneline (we'll be using this)
3. Calculate version
   a) analyze commits
   b) bump version if appropriate [If commit changes since last commit/tag]

   Deciding When not to update version.
   1. if there is any new feat/fix/breaking commit changes as compared to previous state?

   ### Note: To get the latest tag of main branch run following command
   ```git tag --points-at main | tail -n 1```

   last tagged version -> v1.0.0

   in any subbranch of any depth 
   next version (2 fix) -> 1.0.1
   next version (2 fix) (copy) -> 1.0.1
   next version (3 fix) -> 1.0.1
   next version (4 fix) -> 1.0.1
   next version (5 fix, 10 feat) -> 1.1.0
   <!-- next version (1 Breaking change ) -> 2.0.0 -->


 
  

