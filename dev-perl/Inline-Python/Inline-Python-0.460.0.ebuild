# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Inline-Python/Inline-Python-0.460.0.ebuild,v 1.1 2014/12/09 23:26:00 dilfridge Exp $

EAPI=5

PYTHON_COMPAT=( python{2_7,3_3,3_4} )

MODULE_AUTHOR=NINE
MODULE_VERSION=0.46
inherit python-single-r1 perl-module

DESCRIPTION="Easy implementation of Python extensions"

SLOT="0"
KEYWORDS=""
IUSE="test"

RDEPEND="
	virtual/perl-Data-Dumper
	virtual/perl-Digest-MD5
	>=dev-perl/Inline-0.46
	${PYTHON_DEPS}
"
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? ( virtual/perl-Test-Simple )
"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

SRC_TEST="do"
