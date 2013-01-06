# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MARC-Charset/MARC-Charset-1.330.0.ebuild,v 1.1 2011/08/05 17:10:10 tove Exp $

EAPI=4

MODULE_AUTHOR=GMCHARLT
MODULE_VERSION=1.33
inherit perl-module

DESCRIPTION="convert MARC-8 encoded strings to UTF-8"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"

RDEPEND="
	dev-lang/perl[gdbm]
	dev-perl/XML-SAX
	dev-perl/Class-Accessor
"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST=do
