# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/kamerka/kamerka-0.8.1-r1.ebuild,v 1.1 2012/07/25 16:17:41 kensington Exp $

EAPI=4
KDE_LINGUAS="cs de es pl sr sr@ijekavian sr@ijekavianlatin sr@Latn"
inherit kde4-base

SRC_URI="http://dosowisko.net/${PN}/downloads/${P}.tar.gz"
DESCRIPTION="Simple photo taking application with fancy animated interface"
HOMEPAGE="http://dos1.github.com/kamerka/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	media-libs/libv4l
	media-libs/phonon
	>=x11-libs/qt-declarative-4.7:4
"
DEPEND="${RDEPEND}"

PATCHES=( "${FILESDIR}/${P}-qa.patch" )

src_prepare() {
	pushd po > /dev/null || die
	local po
	for po in *.po ; do
		mv $po ${po/kamerka_/} || die
	done
	popd > /dev/null || die

	kde4-base_src_prepare
}
