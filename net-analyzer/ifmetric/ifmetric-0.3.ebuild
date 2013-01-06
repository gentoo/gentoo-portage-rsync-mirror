# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/ifmetric/ifmetric-0.3.ebuild,v 1.5 2012/10/26 10:53:28 pinkbyte Exp $

EAPI=4

DESCRIPTION="A Linux tool for setting the metrics of all IPv4 routes attached to a given network interface at once"
HOMEPAGE="http://0pointer.de/lennart/projects/ifmetric/"
SRC_URI="http://0pointer.de/lennart/projects/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

# NOTE: this app is linux-only, virtual/os-headers therefore is incorrect
DEPEND="sys-kernel/linux-headers"
RDEPEND=""

DOCS=( README )

src_configure() {
	# man page and HTML are already generated
	econf \
		--disable-xmltoman \
		--disable-lynx
}

src_install() {
	default
	dohtml doc/README.html
}
