#!/usr/bin/perl

# Copyright 2019-2020 Michael Schlenstedt, michael@loxberry.de
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


##########################################################################
# Modules
##########################################################################

# use Config::Simple '-strict';
# use CGI::Carp qw(fatalsToBrowser);
use LoxBerry::System;
use LoxBerry::Web;
use warnings;
use strict;
#use Data::Dumper;

##########################################################################
# Variables
##########################################################################

my $version = LoxBerry::System::pluginversion();
my $template;


# Init Template
$template = HTML::Template->new(
    filename => "$lbptemplatedir/settings.html",
    global_vars => 1,
    loop_context_vars => 1,
    die_on_bad_params => 0,
);

$template->param("PLUGINNAME", $lbpplugindir);

# Template
LoxBerry::Web::lbheader("LoxoneIcons V$version", "https://wiki.loxberry.de/plugins/loxoneicons/start", "");
print $template->output();
LoxBerry::Web::lbfooter();

exit;
