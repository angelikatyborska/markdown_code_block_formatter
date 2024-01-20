IO.puts("Running smoke tests")
IO.puts("\n\n")

{diff, 0} = System.cmd("git", ["diff"])

if diff != "" do
  IO.puts(
    "There are unstaged changes. Stage them (git add) or remove them for this check to be able to work."
  )

  System.halt(1)
end

IO.puts("checking smoke_test_data/project_with_formatted_code")

{_, 0} = System.cmd("mix", ["format"], cd: "smoke_test_data/project_with_formatted_code")
{diff, 0} = System.cmd("git", ["diff"], cd: "smoke_test_data/project_with_formatted_code")

{"", 0} =
  System.cmd("git", ["checkout", "--", "."], cd: "smoke_test_data/project_with_formatted_code")

if diff == "" do
  IO.puts("OK ")
else
  IO.puts(
    "Expected project_with_formatted_code to be unchanged after running `mix format` in it, but there were changes:"
  )

  IO.puts(diff)
  System.halt(2)
end

IO.puts("checking smoke_test_data/project_with_unformatted_code")

{_, 0} = System.cmd("mix", ["format"], cd: "smoke_test_data/project_with_unformatted_code")
{diff, 0} = System.cmd("git", ["diff"], cd: "smoke_test_data/project_with_unformatted_code")

expected_diff =
  """
  diff --git a/smoke_test_data/project_with_unformatted_code/README.md b/smoke_test_data/project_with_unformatted_code/README.md
  index d066e9b..0ccfa0b 100644
  --- a/smoke_test_data/project_with_unformatted_code/README.md
  +++ b/smoke_test_data/project_with_unformatted_code/README.md
  @@ -9,9 +9,9 @@ by adding `project_with_unformatted_code` to your list of dependencies in `mix.e
  #{" "}
   ```elixir
   def deps do
  -[
  -{ :project_with_unformatted_code, "~> 0.1.0" }
  -]
  +  [
  +    {:project_with_unformatted_code, "~> 0.1.0"}
  +  ]
   end
   ```
  #{" "}
  diff --git a/smoke_test_data/project_with_unformatted_code/docs/hello.md b/smoke_test_data/project_with_unformatted_code/docs/hello.md
  index 114bb32..8d4ffe5 100644
  --- a/smoke_test_data/project_with_unformatted_code/docs/hello.md
  +++ b/smoke_test_data/project_with_unformatted_code/docs/hello.md
  @@ -1,7 +1,7 @@
   # Hello!
  #{" "}
   ~~~~elixir
  -%{ x: 7,   y: 8}
  +%{x: 7, y: 8}
   ~~~~
  #{" "}
   [//]: # (elixir-formatter-disable-next-block)
  @@ -11,7 +11,7 @@
   ~~~~
  #{" "}
   ```elixir
  -%{ x: 7,   y: 8}
  +%{x: 7, y: 8}
   ```
  #{" "}
   ```markdown
  diff --git a/smoke_test_data/project_with_unformatted_code/lib/project_with_unformatted_code.ex b/smoke_test_data/project_with_unformatted_code/lib/project_with_unformatted_code.ex
  index 7af383c..c94df7f 100644
  --- a/smoke_test_data/project_with_unformatted_code/lib/project_with_unformatted_code.ex
  +++ b/smoke_test_data/project_with_unformatted_code/lib/project_with_unformatted_code.ex
  @@ -17,13 +17,14 @@ defmodule ProjectWithUnformattedCode do
       # Hello, World!
  #{" "}
       ```elixir
  -    def add(a,b), do: a+b
  +    def add(a, b), do: a + b
       ```
  #{" "}
       ```js
       1+2+3
       ```
       \"""
  +
       :world
     end
   end
  """

{"", 0} =
  System.cmd("git", ["checkout", "--", "."], cd: "smoke_test_data/project_with_unformatted_code")

if diff == expected_diff do
  IO.puts("OK")
else
  IO.puts(
    "Expected project_with_unformatted_code to have specific changes after running `mix format` in it (see `bin/smoke_test.exs`), the actual changes differ:"
  )

  IO.inspect(String.myers_difference(diff, expected_diff))

  System.halt(2)
end
