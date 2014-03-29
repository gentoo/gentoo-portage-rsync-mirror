# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/setconf/setconf-0.6.2.ebuild,v 1.1 2014/03/29 09:24:42 ssuominen Exp $

EAPI=5

DESCRIPTION="A small python based utility that can be used to change configuration files"
HOMEPAGE="http://setconf.roboticoverlords.org/"
SRC_URI="http://${PN}.roboticoverlords.org/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="=dev-lang/python-3*"

src_unpack() {
	unpack ${A}
	cd "${S}"
	unpack ./${PN}.1.gz
}

src_prepare() {
	sed -i -e 's:/usr/bin/python:/usr/bin/python3:' ${PN}.py || die #462326
}

src_install() {
	dobin ${PN}.py
	ln -s ${PN}.py "${ED}"/usr/bin/${PN}
	doman ${PN}.1
}
