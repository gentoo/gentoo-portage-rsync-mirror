# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libbdplus/libbdplus-0.1.2.ebuild,v 1.1 2015/01/29 01:23:36 radhermit Exp $

EAPI=5

inherit autotools-multilib

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="git://git.videolan.org/${PN}.git"
else
	SRC_URI="http://ftp.videolan.org/pub/videolan/${PN}/${PV}/${P}.tar.bz2"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Blu-ray library for BD+ decryption"
HOMEPAGE="http://www.videolan.org/developers/libbdplus.html"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="aacs static-libs"

RDEPEND="dev-libs/libgcrypt:0=
	dev-libs/libgpg-error
	aacs? ( >=media-libs/libaacs-0.7.0 )"
DEPEND="${RDEPEND}"

DOCS="ChangeLog README.txt"

src_configure() {
	local myeconfargs=(
		--disable-optimizations
		$(use_with aacs libaacs)
	)
	autotools-multilib_src_configure
}
