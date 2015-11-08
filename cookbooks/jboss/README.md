JBoss 6 Cookbook
=====================

This cookbook will install Jboss 6.0.0.Final on Ubuntu

Requirements
------------
- Chef 11 or higher
- Ruby 1.9 or higher (preferably from the Chef full-stack installer)
- Network accessible package repositories
- 'recipe[selinux::disabled]' on RHEL platforms

Platform Support
----------------
The following platforms have been tested:

```
|----------------+-----+
|                |1.4.8|
|----------------+-----+
| ubuntu-12.04   |  X  |
|----------------+-----+
| ubuntu-14.04   |  X  |
|----------------+-----+
```

Cookbook Dependencies
------------
- apt
- firewall

License & Authors
-----------------
- Author:: terghalin (<terghalin@gmail.com>)


```text
Copyright:: 2015 terghalin

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
