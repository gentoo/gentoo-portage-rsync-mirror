# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/tkabber/tkabber-0.11.0.ebuild,v 1.5 2012/03/18 15:32:53 armin76 Exp $

inherit eutils

DESCRIPTION="Tkabber is a Free and Open Source client for the Jabber instant messaging system, written in Tcl/Tk."
HOMEPAGE="http://tkabber.jabber.ru/"
SRC_URI="http://files.jabber.ru/tkabber/${P}.tar.gz
	plugins? ( http://files.jabber.ru/tkabber/tkabber-plugins-${PV}.tar.gz )"
IUSE="plugins ssl"

DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3
	>=dev-tcltk/tcllib-1.3
	>=dev-tcltk/bwidget-1.3
	ssl? ( >=dev-tcltk/tls-1.4.1 )
	>=dev-tcltk/tkXwin-1.0
	>=dev-tcltk/tkimg-1.2
	>=dev-tcltk/tktray-1.1"
RDEPEND="${DEPEND}"

# Disabled because it depends on gpgme 0.3.x
#	crypt? ( >=dev-tcltk/tclgpgme-1.0 )

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"

src_compile() {
	# dont run make, because the Makefile is broken with all=install
	:
}

src_install() {
	make install DESTDIR="${D}" PREFIX=/usr \
		DOCDIR="/usr/share/doc/${P}"

	dodoc AUTHORS ChangeLog INSTALL README
	dohtml README.html

	if use plugins; then
		cd "${WORKDIR}/tkabber-plugins-${PV}"
		make install DESTDIR="${D}" PREFIX=/usr \
			DOCDIR="/usr/share/doc/${P}"
	fi
}
