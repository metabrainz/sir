#!/usr/bin/env perl

use utf8;
use warnings;
use strict;

my $dir = shift() || "./sql/";

# This script is taken from musicbrainz-server/admin/GenerateSqlScripts.pl
# See https://github.com/metabrainz/musicbrainz-server/blob/master/admin/GenerateSQLScripts.pl

sub process_functions
{
    my ($infile, $outfile) = @_;

    unless (-e "$dir/$infile") {
        print "Could not find $infile, skipping\n";
        return;
    }

    open FILE, "<$dir/$infile";
    my $create_functions_sql = do { local $/; <FILE> };
    close FILE;

    my @functions;
    while ($create_functions_sql =~ m/CREATE .*?FUNCTION\s+(.+?)\s+RETURNS/gi) {
        my $name = $1;
        push @functions, $name;
    }
    # Functions created by the previous versions of SIR
    push @functions, qw(
        search_link_attribute_type_insert
        search_link_attribute_type_update
        search_link_attribute_type_delete
    );
    @functions = sort(@functions);

    my @aggregates;
    while ($create_functions_sql =~ m/CREATE\s+AGGREGATE\s+(\w+).*basetype[\s=]+(\w+)/gi) {
        push @aggregates, [$1, $2];
    }
    @aggregates = sort(@aggregates);

    open OUT, ">$dir/$outfile";
    print OUT "-- Automatically generated, do not edit.\n";
    print OUT "\\unset ON_ERROR_STOP\n\n";
    foreach my $func (@functions) {
        print OUT "DROP FUNCTION IF EXISTS $func;\n";
    }
    foreach my $agg (@aggregates) {
        my ($name, $type) = @$agg;
        print OUT "DROP AGGREGATE IF EXISTS $name ($type);\n";
    }
    close OUT;
}

process_functions("CreateFunctions.sql", "DropFunctions.sql");

sub process_triggers
{
    my ($infile, $outfile) = @_;

    unless (-e "$dir/$infile") {
        print "Could not find $infile, skipping\n";
        return;
    }

    open FILE, "<$dir/$infile";
    my $create_triggers_sql = do { local $/; <FILE> };
    close FILE;

    my @triggers;
    while ($create_triggers_sql =~ m/CREATE (?:CONSTRAINT )?TRIGGER\s+"?([a-z0-9_]+)"?\s+.*?\s+ON\s+"?([a-z0-9_\.]+)"?.*?;/gsi) {
        push @triggers, [$1, $2];
    }
    # Triggers created by the previous versions of SIR
    push @triggers, (
        ['search_release_packaging_insert', 'musicbrainz.release_packaging'],
        ['search_release_packaging_update', 'musicbrainz.release_packaging'],
        ['search_release_packaging_delete', 'musicbrainz.release_packaging'],
        ['search_link_attribute_type_insert', 'musicbrainz.link_attribute_type'],
        ['search_link_attribute_type_update', 'musicbrainz.link_attribute_type'],
        ['search_link_attribute_type_delete', 'musicbrainz.link_attribute_type']
    );
    @triggers = sort(@triggers);

    open OUT, ">$dir/$outfile";
    print OUT "-- Automatically generated, do not edit.\n";
    print OUT "\\unset ON_ERROR_STOP\n\n";
    foreach my $trigger (@triggers) {
        print OUT "DROP TRIGGER IF EXISTS $trigger->[0] ON $trigger->[1];\n";
    }
    close OUT;
}

process_triggers("CreateTriggers.sql", "DropTriggers.sql");

=head1 COPYRIGHT

Copyright (C) 2009 Lukas Lalinsky
Copyright (C) 2012 Aurélien Mino

This program is free software; you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 2 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program; if not, write to the Free Software
Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

=cut
