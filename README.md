* [Date](#date)
  * [setDateFromString](#function-setdatefromstring)
  * [setDateTimeFromString](#function-setdatetimefromstring)
  * [setDateFromTimestamp](#function-setdatefromtimestamp)
  * [setDateTimeFromTimestamp](#function-setdatetimefromtimestamp)
  * [setDateFromYMD](#function-setdatefromymd)
  * [setDateTimeFromYMDHMS](#function-setdatetimefromymdhms)
  * [getDateString](#function-getdatestring)
  * [getDateTimeString](#function-getdatetimestring)
  * [getTimestamp](#function-gettimestamp)
  * [terminate](#function-terminate)

# Date

> Date object Solidity contract

Skeleton Codeworks, LLC

<skeleton.codeworks@gmail.com>


>      This contract provides multi-purpose storage for date objects in
>      six different formats, stored as public members.  The formats are:
>      1) "yyyy-mm-dd" date string format (also known as ISO),
>      2) "yyyy-mm-dd hh:mm:ss" date and time string format,
>      3) Unix timestamp format,
>      4) Dt struct format, a struct with year, month, day, and
>         weekday attributes,
>      5) DtTime struct format, a struct with year, month, day, hour,
>         minute, second and weekday attributes,
>      6) year, month, day, hour, minute, second, and weekday members on
>         the contract itself.
> 
>      Whenever the contract is set using one of the several available
>      set functions, including at initialization, then all six of the above
>      formats are set to the same date and time, so that all members of the
>      contract will always be in agreement.  The contract can be reset
>      with a new date any number times.


### *public members*

| **type** | **name** | **description** |
|-|-|-|
| `uint16` | year | Year (>= 1970, <= 9999) |
| `uint8` | month | Month (1 - 12) |
| `uint8` | day | Day (1 - 31) |
| `uint8` | hour | Hour (0 - 23) |
| `uint8` | minute | Minute (0 - 59) |
| `uint8` | second | Second (0 - 59) |
| `string` | weekday | Day of the week (e.g., "Monday") |
| `string` | isoDate | Date in ISO format ("yyyy-mm-dd") |
| `string` | isoDateTime | Date and time in quasi-ISO format ("yyyy-mm-dd hh:mm:ss") |
| `uint256` | timestampDate | Date in Unix time format |
| `Dt` | dt | Date as a `Dt` struct (object with members: `uint16` year, `uint8` month, `uint8` day, and `string` weekday) |
| `DtTime` | dtTime | Date as a `DtTime` struct (object with members: `uint16` year, `uint8` month, `uint8` day, `uint8` hour, `uint8` minute, `uint8` second, and `string` weekday) |
| `address` | owner | Owner address |


### *constructor*

Date(_year, _month, _day)

> Create Date object.  Must be initialized with year, month, day only - all time members are set to 0.

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `uint16` | _year | Year as integer |
| `uint8` | _month | Month as integer |
| `uint8` | _day | Day as integer |


### *function* setDateFromString

Date.setDateFromString(_dt) `nonpayable`

> Set date from date string

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `string` | _dt | Date as ISO date string ("yyyy-mm-dd") |


### *function* setDateTimeFromString

Date.setDateTimeFromString(_dt) `nonpayable`

> Set date and time from date and time string

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `string` | _dt | Date as date and time string ("yyyy-mm-dd hh:mm:ss") |


### *function* setDateFromTimestamp

Date.setDateFromTimestamp(_timestamp) `nonpayable`

> Set date from timestamp

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `uint256` | _timestamp | Date as timestamp integer |


### *function* setDateTimeFromTimestamp

Date.setDateTimeFromTimestamp(_timestamp) `nonpayable`

> Set date and time from timestamp

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `uint256` | _timestamp | Date as timestamp integer |


### *function* setDateFromYMD

Date.setDateFromYMD(_year, _month, _day) `nonpayable`

> Set date from year, month, day

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `uint16` | _year | Year as integer |
| `uint8` | _month | Month as integer |
| `uint8` | _day | Day as integer |


### *function* setDateTimeFromYMDHMS

Date.setDateTimeFromYMDHMS(_year, _month, _day, _hour, _minute, _second) `nonpayable`

> Set date and time from year, month, day, hour, minute, second

Inputs

| **type** | **name** | **description** |
|-|-|-|
| `uint16` | _year | Year as integer |
| `uint8` | _month | Month as integer |
| `uint8` | _day | Day as integer |
| `uint8` | _hour | Hour as integer |
| `uint8` | _minute | Minute as integer |
| `uint8` | _second | Second as integer |


### *function* getDateString

Date.getDateString() `view`

> Get date string



Outputs

| **type** | **name** | **description** |
|-|-|-|
| `string` |  | Returns date string as "yyyy-mm-dd" |


### *function* getDateTimeString

Date.getDateTimeString() `view`

> Get date and time string



Outputs

| **type** | **name** | **description** |
|-|-|-|
| `string` |  | Returns date and time string as "yyyy-mm-dd hh:mm:ss" |


### *function* getTimestamp

Date.getTimestamp() `view`

> Get date as timestamp



Outputs

| **type** | **name** | **description** |
|-|-|-|
| `uint256` |  | Returns timestamp as `uint256` |


### *function* terminate

Date.terminate() `nonpayable`

> Terminate contract - must be owner

