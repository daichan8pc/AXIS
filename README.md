# AXIS: Active X-platform Integrated System



## Abstract



AXIS is a highly portable, self-contained development environment architecture designed to operate independently of the host machine's local configuration. By leveraging a structured directory system and virtualization of environment variables, AXIS enables seamless transition between different workstations (e.g., academic laboratories and personal machines) while maintaining a consistent development experience.



This repository contains the initialization scripts and configuration definitions for the \*\*v1.0.0 "Awaken"\*\* iteration.



## Architecture Overview



The system adopts a "Portable Application" approach, eliminating the need for administrative privileges or BIOS modifications on the host machine.



* \*\*Core Name:\*\* Awaken (v1.0.0)

* \*\*Target Platform:\*\* Windows 10 / 11 (Host), WSL (Optional integration)

\* \*\*File System:\*\* NTFS (Optimized for symbolic links and file handling efficiency)



### System Components



The environment integrates the following standard development tools in portable mode:



* \*\*Editor:\*\* Visual Studio Code (Portable Mode)

* \*\*Version Control:\*\* Git for Windows (Portable Edition)

* \*\*Security:\*\* KeePassXC (Password Manager \& SSH Agent)



## Directory Structure



The operational integrity of AXIS relies on the following directory hierarchy. Binary files are excluded from this repository to minimize footprint.



```text

AXIS (Root)

├── Start\_Awaken.bat       # Initialization and Environment Injection Script

├── bin/                   # Binary Executables (Git, VSCode, etc.)

│   ├── Git/

│   ├── VSCode/

│   └── KeePassXC/

├── home/                  # Virtualized User Home Directory

│   ├── projects/          # Source Code Repositories

│   └── settings/          # Configuration Files

└── key/                   # Encrypted Credentials (Local Only)



```



## Initialization Process



The system is activated via the `Start\_Awaken.bat` script, which performs the following operations:



1. \*\*Integrity Check:\*\* Verifies the existence of critical binary components.

2. \*\*Path Injection:\*\* Temporarily injects tool paths into the host's process environment.

3. \*\*Home Virtualization:\*\* Overrides `%USERPROFILE%` and `%HOME%` variables to point to the USB storage, ensuring isolation from the host system.

4. \*\*Shell Execution:\*\* Launches the development console and IDE.



## Usage



1. Clone this repository to the root of a formatted USB drive (NTFS recommended).

2. Deploy the required portable binaries into the `bin/` directory.

3. Execute `Start\_Awaken.bat`.



## License



MIT License

