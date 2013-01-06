# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/fastjar/fastjar-0.98-r2.ebuild,v 1.5 2012/12/16 13:53:42 ago Exp $

EAPI=4

inherit eutils

DESCRIPTION="A jar program written in C"
HOMEPAGE="https://savannah.nongnu.org/projects/fastjar"
SRC_URI="http://download.savannah.nongnu.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86 ~amd64-linux ~x86-linux ~x86-macos ~sparc-solaris"

IUSE=""

# bug #188542
RDEPEND="!<=dev-java/kaffe-1.1.7-r5"

src_prepare() {
	# bug #325557
	epatch "${FILESDIR}/0.98-traversal.patch"
}
