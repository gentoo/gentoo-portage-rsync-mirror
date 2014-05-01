# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-crypt/kencfs/kencfs-1.3.1.ebuild,v 1.1 2014/05/01 16:17:12 kensington Exp $

EAPI=5

inherit qt4-r2

DESCRIPTION="GUI frontend for encfs"
HOMEPAGE="http://kde-apps.org/content/show.php?content=134003"
SRC_URI="http://kde-apps.org/CONTENT/content-files/134003-${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	kde-base/kdelibs:4
"
RDEPEND="${DEPEND}
	kde-base/kwalletd
	sys-fs/encfs
"

PATCHES=(
	"${FILESDIR}/${PN}-1.2-desktop.patch"
	"${FILESDIR}/${PN}-1.2-encfs5.patch"
	"${FILESDIR}/${PN}-1.2-gcc-4.7.patch"
	"${FILESDIR}/${PN}-1.3.0-build-fix.patch"
)

src_prepare() {
	qt4-r2_src_prepare

	sed -i ${PN}.pro -e "/^doc.path =/s/${PN}-1.3/${PF}/" \
		|| die "sed docdir failed"
}
