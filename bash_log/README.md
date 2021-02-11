# LOG SHELL

------------------------------------------------

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
