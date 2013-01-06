# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/hxtools/hxtools-20121125-r1.ebuild,v 1.1 2012/11/30 18:22:35 scarabeus Exp $

EAPI=5

DESCRIPTION="A collection of tools and scripts"
HOMEPAGE="http://inai.de/projects/hxtools/"
SRC_URI="http://jftp.inai.de/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="
	dev-lang/perl
	>=sys-libs/libhx-3.12.1
"
RDEPEND="${DEPEND}"

src_install() {
	default

	# man2html is provided by man
	rm -rf "${ED}"/usr/bin/man2html
	rm -rf "${ED}"/usr/share/man/man1/man2html*
}
