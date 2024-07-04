# Get a list of built-in accounts
$builtInAccounts = @(
    "Administrator",
    "DefaultAccount",
    "Guest",
    "SYSTEM",
    "LOCAL SERVICE",
    "NETWORK SERVICE"
)

# Get all scheduled tasks
$tasks = Get-ScheduledTask

# Filter tasks by checking the author
$userTasks = foreach ($task in $tasks) {
    $taskDetails = Get-ScheduledTaskInfo -TaskName $task.TaskName -TaskPath $task.TaskPath
    $taskAuthor = $task.Principal.UserId

    # Check if the author is not a built-in account
    if ($taskAuthor -and $builtInAccounts -notcontains $taskAuthor) {
        [PSCustomObject]@{
            TaskName        = $task.TaskName
            TaskPath        = $task.TaskPath
            Author          = $task.Principal.UserId
            Description     = $task.Description
            LastRunTime     = (Get-ScheduledTaskInfo -TaskName $task.TaskName -TaskPath $task.TaskPath).LastRunTime
            NextRunTime     = $task.NextRunTime
            Status          = (Get-ScheduledTaskInfo -TaskName $task.TaskName -TaskPath $task.TaskPath).TaskState
            Actions         = $task.Actions | ForEach-Object {
                [PSCustomObject]@{
                    Type       = $_.ActionType
                    Path       = $_.Execute
                    Arguments  = $_.Arguments
                    WorkingDir = $_.WorkingDirectory
                }
            }
        }
    }
}

# Display the tasks created by users
$userTasks | Format-Table -AutoSize
$userTasks | Format-List
