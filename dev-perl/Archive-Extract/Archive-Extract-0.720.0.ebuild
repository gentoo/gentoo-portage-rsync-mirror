# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Archive-Extract/Archive-Extract-0.720.0.ebuild,v 1.1 2014/09/27 16:52:06 dilfridge Exp $

EAPI=5

MODULE_AUTHOR=BINGOS
MODULE_VERSION=0.72
inherit perl-module

DESCRIPTION="Generic archive extracting mechanism"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="
	virtual/perl-File-Path
	virtual/perl-File-Spec
	virtual/perl-IPC-Cmd
	virtual/perl-Locale-Maketext-Simple
	virtual/perl-Module-Load-Conditional
	virtual/perl-Params-Check
	virtual/perl-if
"
DEPEND="${DEPEND}"

SRC_TEST="do"
