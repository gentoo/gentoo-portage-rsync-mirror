# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/setconf/setconf-0.5.3.ebuild,v 1.1 2013/03/16 18:51:02 ssuominen Exp $

EAPI=5

DESCRIPTION="A small python based utility that can be used to change configuration files"
HOMEPAGE="http://setconf.roboticoverlords.org/"
SRC_URI="http://${PN}.roboticoverlords.org/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/python"

src_unpack() {
	unpack ${A}
	cd "${S}"
	unpack ./${PN}.1.gz
}

src_install() {
	newbin ${PN}.py ${PN}
	doman ${PN}.1
}
