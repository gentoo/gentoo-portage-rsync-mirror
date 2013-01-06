# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/qrq/qrq-0.1.4.ebuild,v 1.3 2011/05/11 08:00:17 phajdan.jr Exp $

DESCRIPTION="Yet another CW trainer for Linux/Unix"
HOMEPAGE="http://fkurz.net/ham/qrq.html"
SRC_URI="http://fkurz.net/ham/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# fix ordering of compiler options
	sed -i -e "s/g++ -pth/g++ \$^ -pth/" \
		-e "s/\$@ \$^/\$@/" Makefile || die "sed failed"
	# avoid prestripping of 'qrq' binary
	sed -i -e "s/install -s -m/install -m/" Makefile || die "patch failed"
}

src_install() {
	emake DESTDIR="${D}/usr" install || die "install failed"
	dodoc CHANGELOG README || die "dodoc failed"
}
