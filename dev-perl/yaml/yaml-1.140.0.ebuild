# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/yaml/yaml-1.140.0.ebuild,v 1.1 2015/02/25 23:40:57 dilfridge Exp $

EAPI=5

MY_PN=YAML
MODULE_AUTHOR=INGY
MODULE_VERSION=1.14
inherit perl-module

DESCRIPTION="YAML Ain't Markup Language (tm)"

SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~hppa ~m68k ~mips ~ppc ~s390 ~sh ~x86 ~ppc-aix ~x86-fbsd ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	virtual/perl-ExtUtils-MakeMaker
	test? ( dev-perl/Test-YAML )
"

SRC_TEST="do"
