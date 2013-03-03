# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/kencfs/kencfs-1.2-r1.ebuild,v 1.2 2013/03/02 19:14:26 hwoarang Exp $

EAPI=5
LANGS="it"

inherit qt4-r2

DESCRIPTION="GUI frontend for encfs"
HOMEPAGE="http://kde-apps.org/content/show.php?content=134003"
SRC_URI="http://kde-apps.org/CONTENT/content-files/134003-${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="kde-base/kdelibs
	dev-qt/qtcore:4
	dev-qt/qtgui:4
"
RDEPEND="${DEPEND}
	sys-fs/encfs
"

PATCHES=(
	"${FILESDIR}/${PN}-1.1-underlinking.patch"
	"${FILESDIR}/${P}-desktop.patch"
	"${FILESDIR}/${P}-encfs5.patch"
	"${FILESDIR}/${P}-gcc-4.7.patch"
)

src_prepare() {
	qt4-r2_src_prepare

	sed -i ${PN}.pro -e "/^doc.path =/s/${PN}-1.1/${PF}/" \
		|| die "sed docdir failed"

	if ! use linguas_it ; then
		sed -i ${PN}.pro -e "s/*.qm//" \
			|| die "sed TRANSLATIONS failed"
	fi
}
