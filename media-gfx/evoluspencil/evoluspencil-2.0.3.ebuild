# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/evoluspencil/evoluspencil-2.0.3.ebuild,v 1.1 2013/01/28 15:05:56 kensington Exp $

EAPI=5
MY_P="pencil-${PV}"

inherit fdo-mime

DESCRIPTION="A simple GUI prototyping tool to create mockups."
HOMEPAGE="http://pencil.evolus.vn/"
SRC_URI="http://${PN}.googlecode.com/files/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="|| ( www-client/firefox www-client/firefox-bin )"

S=${WORKDIR}/${MY_P}

src_prepare() {
	# avoid file collisions with media-gfx/pencil
	mv usr/bin/{pencil,${PN}} || die
	mv usr/share/{pencil,${PN}} || die
	mv usr/share/applications/{pencil,${PN}}.desktop || die

	sed -e "s/pencil/${PN}/" -i usr/bin/${PN} \
		-i usr/share/applications/${PN}.desktop || die

	sed -e 's/xulrunner/firefox/' -i usr/bin/${PN} || die
}

src_install() {
	doins -r usr
	fperms +x /usr/bin/${PN}
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
