defmodule Unix do
  def ps_ax do
    """
  PID   TT  STAT      TIME COMMAND
    1   ??  Us    17:14.20 /sbin/launchd
   42   ??  Ss     2:36.52 /usr/sbin/syslogd
   43   ??  Ss     1:53.19 /usr/libexec/UserEventAgent (System)
   45   ??  Ss     0:04.87 /usr/libexec/kextd
   46   ??  Ss     1:47.15 /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/FSEvents.framework/Versions/A/Support/fseventsd
   50   ??  Ss     0:03.56 /System/Library/CoreServices/appleeventsd --server
   51   ??  Ss     0:32.81 /usr/libexec/configd
   52   ??  Ss     0:28.16 /System/Library/CoreServices/powerd.bundle/powerd
   58   ??  Ss     0:34.85 /usr/libexec/airportd
   60   ??  SNs    0:02.37 /usr/libexec/warmd
   61   ??  Ss     6:31.02 /System/Library/Frameworks/CoreServices.framework/Frameworks/Metadata.framework/Support/mds
   67   ??  Ss     0:03.97 /usr/libexec/diskarbitrationd
   72   ??  Us     0:14.53 /System/Library/CoreServices/backupd.bundle/Contents/Resources/mtmfs --tcp --resvport --listen localhost --oneshot --noportmap --nobrowse
   73   ??  Ss     1:23.08 /usr/libexec/opendirectoryd
   75   ??  Ss     0:00.79 /usr/sbin/wirelessproxd
   77   ??  Ss     0:36.66 /System/Library/PrivateFrameworks/ApplePushService.framework/apsd
9101   ??  Ss     0:00.12 /System/Library/PrivateFrameworks/WirelessDiagnostics.framework/Support/awdd
806 s001  U      0:00.08 login -fp abhyuditjain
48807 s001  S+     0:01.82 -zsh
11680 s002  S+     0:06.65 /usr/local/bin/vim
11888 s002  R+     0:00.01 ps ax
18734 s002  Ss     0:00.08 /Users/abhyuditjain/Applications/iTerm.app/Contents/MacOS/iTerm2 --server login -fp abhyuditjain
18735 s002  S      0:00.03 login -fp abhyuditjain
18736 s002  S      0:00.45 -zsh
    """
  end

  def grep(input, match) do
    String.split(input, "\n")
    |> Enum.filter(fn(line) -> Regex.match?(~r/#{match}/, line)  end)
  end

  def awk(lines, column) do
    lines
    |> Enum.map(fn (line) -> 
      stripped = String.trim(line)
      Regex.split(~r/ /, stripped, trim: true)
      |> Enum.at(column - 1)
    end)
  end
end

defmodule PipeOperatorPlaygroundTest do
  use ExUnit.Case
  doctest PipeOperatorPlayground

  test "ps_ax outputs some processes" do
    output = """
  PID   TT  STAT      TIME COMMAND
    1   ??  Us    17:14.20 /sbin/launchd
   42   ??  Ss     2:36.52 /usr/sbin/syslogd
   43   ??  Ss     1:53.19 /usr/libexec/UserEventAgent (System)
   45   ??  Ss     0:04.87 /usr/libexec/kextd
   46   ??  Ss     1:47.15 /System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/FSEvents.framework/Versions/A/Support/fseventsd
   50   ??  Ss     0:03.56 /System/Library/CoreServices/appleeventsd --server
   51   ??  Ss     0:32.81 /usr/libexec/configd
   52   ??  Ss     0:28.16 /System/Library/CoreServices/powerd.bundle/powerd
   58   ??  Ss     0:34.85 /usr/libexec/airportd
   60   ??  SNs    0:02.37 /usr/libexec/warmd
   61   ??  Ss     6:31.02 /System/Library/Frameworks/CoreServices.framework/Frameworks/Metadata.framework/Support/mds
   67   ??  Ss     0:03.97 /usr/libexec/diskarbitrationd
   72   ??  Us     0:14.53 /System/Library/CoreServices/backupd.bundle/Contents/Resources/mtmfs --tcp --resvport --listen localhost --oneshot --noportmap --nobrowse
   73   ??  Ss     1:23.08 /usr/libexec/opendirectoryd
   75   ??  Ss     0:00.79 /usr/sbin/wirelessproxd
   77   ??  Ss     0:36.66 /System/Library/PrivateFrameworks/ApplePushService.framework/apsd
9101   ??  Ss     0:00.12 /System/Library/PrivateFrameworks/WirelessDiagnostics.framework/Support/awdd
806 s001  U      0:00.08 login -fp abhyuditjain
48807 s001  S+     0:01.82 -zsh
11680 s002  S+     0:06.65 /usr/local/bin/vim
11888 s002  R+     0:00.01 ps ax
18734 s002  Ss     0:00.08 /Users/abhyuditjain/Applications/iTerm.app/Contents/MacOS/iTerm2 --server login -fp abhyuditjain
18735 s002  S      0:00.03 login -fp abhyuditjain
18736 s002  S      0:00.45 -zsh
    """

    assert Unix.ps_ax == output
  end

  test "grep(thing) returns lines that match 'thing'" do
    input = """
    foo
    bar
    foo thing
    baz
    thing cux
    """
    output = ["foo thing", "thing cux"]

    assert Unix.grep(input, "thing") == output
  end

  test "awk(1) splits on whitespace and returns the first column" do
    input = ["foo bar", " baz      qux "]
    output = ["foo", "baz"]

    assert Unix.awk(input, 1) == output
  end

  test "the whole pipeline works" do
    assert Unix.ps_ax |> Unix.grep("vim") |> Unix.awk(1) == ["11680"]
  end
end
