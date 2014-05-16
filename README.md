stack_loop is a simple little application.  It runs another program repeatedly,
with arguments taken from a file. If the program returns a 0 status then
stack_loop pops that set of args from the file and runs the program again with
the next set of arguments.

If the program returns any other status, stack_loop leaves the arguments file
as is, and presents a prompt. Simply hitting `return` with trigger a new
attempt to run arguments from the stack file.

Why is this useful? Consider running tests, and focusing on a single test file,
or even a line from the test file. Once the focused test is complete, you
usually want to run the whole suite. If there are failures, you'd like to focus
on just those until they pass, then run the whole suite again. That's exactly
what stack_loop was designed for.

But wait! It's built to be agnostic not only of test solutions, but of testing!
Maybe there's some other repetitive task that this would be useful for. I have
no idea, and I don't care. Knock yourself out.
