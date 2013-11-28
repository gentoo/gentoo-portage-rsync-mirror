# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-Eksblowfish/Crypt-Eksblowfish-0.9.0-r1.ebuild,v 1.1 2013/11/28 14:50:24 chainsaw Exp $

EAPI=4

MODULE_AUTHOR=ZEFRAM
MODULE_VERSION=0.009
inherit perl-module

DESCRIPTION="the Eksblowfish block cipher"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RDEPEND="
	>=dev-perl/Class-Mix-0.1.0
	>=virtual/perl-MIME-Base64-2.21
	virtual/perl-XSLoader
	virtual/perl-parent
"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	>=virtual/perl-ExtUtils-CBuilder-0.15
	virtual/perl-Module-Build
	virtual/perl-Test-Simple
"

SRC_TEST="do"
