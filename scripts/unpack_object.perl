#! /usr/bin/env perl

use strict;
use warnings;

use subs qw/ git_tree_contents_pattern read_raw_tree_object /;

use Compress::Zlib;

my $treeobj = read_raw_tree_object;

my $git_tree_contents = git_tree_contents_pattern;
die "$0: invalid tree" unless $treeobj =~ /^$git_tree_contents\z/;

die "$0: unexpected header" unless $treeobj =~ s/^(tree [0-9]+)\0//;
print $1, "\n";

# e.g., 100644 SP .gitattributes \0 sha1-bytes
while ($treeobj) {
  # /s is important so . matches any byte!
  if ($treeobj =~ s/^([0-7]+) (.+?)\0(.{20})//s) {
    my($mode,$name,$bytes) = (oct($1),$2,$3);
    printf "%06o %s %s\t%s\n",
      $mode, ($mode == 040000 ? "tree" : "blob"),
      unpack("H*", $bytes), $name;
  }
  else {
    die "$0: unexpected tree entry";
  }
}

sub git_tree_contents_pattern {
  qr/
  (?(DEFINE)
    (?<tree>  tree (?&SP) (?&decimal) \0 (?&entry)+ )
    (?<entry> (?&octal) (?&SP) (?&strnull) (?&sha1bytes) )

    (?<strnull>   [^\0]+ \0)
    (?<sha1bytes> (?s: .{20}))
    (?<decimal>   [0-9]+)
    (?<octal>     [0-7]+)
    (?<SP>        \x20)
  )

  (?&tree)
  /x;
}

sub read_raw_tree_object {
  # $ git rev-parse v2.7.2^{tree}
  # 802b6758c0c27ae910f40e1b4862cb72a71eee9f
  #
  # NOTE: extracted using git unpack-objects
    my $tree = ".git/objects/76/d46ec90118b00608a3a6d9be4a5813cd5bf56f";

  open my $fh, "<", $tree or die "$0: open $tree: $!";
  binmode $fh or die "$0: binmode: $!";
  local $/;
  my $treeobj = uncompress <$fh>;
  die "$0: uncompress failed" unless defined $treeobj;

  $treeobj
}
