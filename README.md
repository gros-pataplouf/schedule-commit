# git-time

`git-time` is a Bash script that allows you to set a custom commit date for Git operations. This can be useful in situations where you need to backdate commits or simulate historical commits.

## Usage

1. Make the script executable: `chmod +x git-time.sh`
2. Run the script with the desired Git command and arguments: `./git-time.sh [git command] [arguments]`
3. The script will prompt you to enter a custom commit date using a dialog box.
4. After entering a valid date, the script will execute the specified Git command with the provided arguments, setting the `GIT_AUTHOR_DATE` and `GIT_COMMITTER_DATE` environment variables to the custom date.

## Example

To commit changes with a custom date, run:
`./git-time.sh commit -m "My backdated commit"`

## Dependencies

- `git`
- `dialog` (for the interactive date input dialog)

## Notes

- The script checks for invalid date input and prompts the user to correct it.
- The script displays the recent commit history in the dialog box for reference.
- Make sure to have the necessary permissions to execute the script and the required dependencies installed.
