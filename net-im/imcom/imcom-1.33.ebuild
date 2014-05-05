# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/imcom/imcom-1.33.ebuild,v 1.10 2014/05/05 17:31:30 lordvan Exp $

EAPI=4

SRC_URI="http://nafai.dyndns.org/files/${P}.tar.gz"
#SRC_URI="http://nafai.dyndns.org/files/imcom-betas/${PN}-${MYVER}.tar.gz"
HOMEPAGE="http://imcom.floobin.cx"
DESCRIPTION="Python commandline Jabber Client"

DEPEND=">=dev-lang/python-2.2
	>=dev-python/pyxml-0.7"
RDEPEND="${DEPEND}"

SLOT="0"
LICENSE="BSD"
KEYWORDS="x86 ~ppc sparc ~amd64"
IUSE=""

src_configure() {
	./configure --prefix=/usr || die "configure failed"
}

src_compile() {
	emake || die "emake failed"
}

src_install() {
	dodoc CONTRIBUTORS README* TODO WHATSNEW docs/CHANGELOG
	dohtml docs/*.html docs/*.png docs/*.jpg docs/*.css
	doman docs/imcom.1
	make prefix="${D}/usr" install-bin
}
