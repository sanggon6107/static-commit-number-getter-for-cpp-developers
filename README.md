# STATIC COMMIT NUMBER GETTER FOR C++ DEVELOPERS

## 1. Introduction
This powershell script is made to help C++ developers get the commit number of HEAD at buid time. <b>Please note that this work is done assuming that the user's development environment is Visual studio on Windows.</b>

## 2. How to use

1. Put "static_commit_number_getter.ps1" to the directory of the project that you want to use. (See example project)
2. Revise the relative directory of the project and .git file in the script if neccessary.

    ```powershell
    $RelativeGitDir = '..\..\' # Hard-code the RELATIVE path from the project folder to the .git file.
    $RelativeProjectDir = '.\' # Pre-build-event usually put the initial directory to the Project dir.
    ```

3. set the pre-buid event as below. (Project property > Build Events > Pre-build event)
   ```cmd
   Powershell -ExecutionPolicy Bypass -File static_commit_number_getter.ps1
   ```

4. Include "CommitNumber.h" from your cpp file as below (See example project) and build the project.

    ```c++
    #include "CommitNumber.h"

    #include <iostream>

    int main()
    {
        std::wcout << "commit number is " << COMMIT_NUMBER << std::endl;
    }
    ```

    The script will automatically make the header file, and the commit number will be defined as "COMMIT_NUMBER" as below.

    ```C++
    #ifndef COMMITNUMBER_H
    #define COMMITNUMBER_H
    #include <tchar.h>

    #define COMMIT_NUMBER _T("cecb17b5a3fcbc314e34c39655aa7fb310dbe297") // DO NOT REVISE THIS FILE MANNUALLY. Pre-build event will do it instead of you.
    #endif
    ```

5. "Ta-da!" Now you'll see the commit number that HEAD is located.

    ```
    commit number is cecb17b5a3fcbc314e34c39655aa7fb310dbe297
    ```