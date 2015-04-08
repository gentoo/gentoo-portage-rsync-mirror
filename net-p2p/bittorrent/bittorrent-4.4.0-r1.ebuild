# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/bittorrent/bittorrent-4.4.0-r1.ebuild,v 1.8 2012/08/12 23:56:48 ottxor Exp $

EAPI=3

PYTHON_DEPEND="2"

inherit distutils fdo-mime eutils

MY_P="${P/bittorrent/BitTorrent}"
#MY_P="${MY_P/}"
S=${WORKDIR}/${MY_P}

DESCRIPTION="tool for distributing files via a distributed network of nodes"
HOMEPAGE="http://www.bittorrent.com/"
SRC_URI="http://www.bittorrent.com/dl/${MY_P}.tar.gz"

LICENSE="BitTorrent"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ppc ppc64 s390 sh sparc x86"
IUSE="gtk"

RDEPEND="gtk? (
		>=x11-libs/gtk+-2.6:2
		>=dev-python/pygtk-2.6
	)
	>=dev-python/pycrypto-2.0"
DEPEND="${RDEPEND}
	app-arch/gzip
	>=sys-apps/sed-4.0.5
	dev-python/dnspython"

DOCS="TRACKERLESS.txt public.key credits.txt"
PYTHON_MODNAME="BitTorrent"

src_prepare() {
	# path for documentation is in lowercase #109743
	sed -i -r "s:(dp.*appdir):\1.lower():" BitTorrent/platform.py
}

src_install() {
	distutils_src_install
	use gtk || rm -f "${D}"/usr/bin/bittorrent
	dohtml redirdonate.html

	if use gtk ; then
		doicon images/logo/bittorrent.ico
		make_desktop_entry "bittorrent" "BitTorrent" bittorrent.ico "Network"
		echo "MimeType=application/x-bittorrent" \
			>> "${D}"/usr/share/applications/bittorrent-${PN}.desktop
	fi

	newinitd "${FILESDIR}"/bittorrent-tracker.initd bittorrent-tracker
	newconfd "${FILESDIR}"/bittorrent-tracker.confd bittorrent-tracker
}

pkg_postinst() {
	einfo "Remember that BitTorrent has changed file naming scheme"
	einfo "To run BitTorrent just execute /usr/bin/bittorrent"
	einfo "To run the init.d, please use /etc/init.d/bittorrent-tracker"
	distutils_pkg_postinst
	fdo-mime_desktop_database_update
}
