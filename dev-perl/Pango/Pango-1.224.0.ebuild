# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Pango/Pango-1.224.0.ebuild,v 1.10 2014/03/04 20:16:04 vincent Exp $

EAPI=5

MODULE_AUTHOR=XAOC
MODULE_VERSION=1.224
inherit perl-module

DESCRIPTION="Layout and render international text"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ia64 ~mips ppc ppc64 sparc x86 ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	>=dev-perl/glib-perl-1.220.0
	>=dev-perl/Cairo-1.0.0
	>=x11-libs/pango-1.0.0
"
DEPEND="
	${RDEPEND}
	>=dev-perl/extutils-depends-0.300.0
	>=dev-perl/extutils-pkgconfig-1.30.0
"

src_prepare() {
	perl-module_src_prepare
	sed -i -e "s:exit 0:exit 1:g" "${S}"/Makefile.PL || die "sed failed"
}
