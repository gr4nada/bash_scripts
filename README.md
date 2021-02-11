# JENKINS API SHELL

------------------------------------------------

## start_build

* Description

    Start .

* Usage

    ```console
    user@server:~$ start_build
    user@server:~$ start_build [help|--help
    ```

## show_scenarios

* Description

  Show the scenarios appended data as the api log file.

* Usage

  ```console
  user@server:~$ show_scenarios
  user@server:~$ show_scenarios [help|--help
  ```

## status_build
  
* Description

  Get the status.

* Usage

  ```console
  user@server:~$ status_build
  user@server:~$ status_build [help|--help
  ```

## stop_build

* Description

  Stop .

* Usage

  ```console
  user@server:~$ stop_build
  user@server:~$ stop_build [help|--help
    ```

## show_log

* Description

  Show the output appended data as the api log file.

* Usage

  ```console
  user@server:~$ show_log
  user@server:~$ show_log [help|--help
    ```

## save_log

* Description

  Appended data on the api log file.

* Options:

  * TYPE
    * EVENT -  Create a tag event on LOG. The message in this case is a event title.
    * INFO - Log INFO level.
    * ERROR - Log ERROR level.
    * WARN - Log WARN level.

* Usage

  ```console
  user@server:~$ save_log <TYPE> <MESSAGE>
  user@server:~$ save_log [help|--help
  ```
