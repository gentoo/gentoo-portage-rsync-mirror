# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-XSAccessor/Class-XSAccessor-1.160.0.ebuild,v 1.1 2012/11/12 20:24:38 tove Exp $

EAPI=4

MODULE_AUTHOR=SMUELLER
MODULE_VERSION=1.16
inherit perl-module

DESCRIPTION="Generate fast XS accessors without runtime compilation"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~ppc-aix ~ppc-macos ~x86-solaris"
IUSE=""

DEPEND="
	>=dev-perl/AutoXS-Header-1.01
"
RDEPEND="${DEPEND}
	!dev-perl/Class-XSAccessor-Array
"

SRC_TEST=do
mymake=( OPTIMIZE=${CFLAGS} )
