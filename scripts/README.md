# PowerShell lolAD Search Script

This PowerShell script allows users to request commands from the LOLAD project repository based on specified keywords or technique numbers. It retrieves data from the LOLAD project's HTML table and filters commands accordingly.
The LOLAD project provides a comprehensive collection of Active Directory techniques, commands, and functions that can be used natively to support offensive security operations and Red Team exercises. These techniques leverage AD’s built-in tools to conduct reconnaissance, privilege escalation, and lateral movement, among other tactics. Understanding these methods helps defenders strengthen AD configurations and improve monitoring capabilities

## Overview

The script provides an easy way to search for PowerShell commands. Below are screenshots demonstrating the script in action:

![Search Result Example 1](/scripts/screen1.png)
*Figure 1: Example of searching for commands with a specific keyword.*

![Search Result Example 2](/scripts/screen2.png)
*Figure 2: Example of displaying a specific command by technique number.*

## Script Overview

### Parameters

- `-Keyword`: (Optional) A string to filter commands by the technique name or command.
- `-Number`: (Optional) An integer to display a specific command based on its number.

### Example Usage

1. **Display All PowerShell Commands**

   To display all available PowerShell commands from the LOLAD project:

   ```powershell
   .\search-lolad.ps1
    ```

2. **Filter by Keyword**

To filter commands containing a specific keyword, use the -Keyword parameter:

```powershell
.\search-lolad.ps1 -Keyword dns 
```
3. **Display a Specific Command by Number**

To fine display a command by its technique number, use the -Number parameter:

```powershell
.\search-lolad.ps1 -Keyword dns -number 55
```
## Requirements

Windows PowerShell
Internet access to retrieve data from the LOLAD project repository.


## Contributing
Feel free to submit issues or pull requests for improvements or additional commands.

