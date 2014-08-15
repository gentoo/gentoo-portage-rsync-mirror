# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/librevenge/librevenge-0.0.1.ebuild,v 1.1 2014/08/15 13:02:53 scarabeus Exp $

EAPI="5"

inherit eutils multilib multilib-minimal autotools-utils

DESCRIPTION="A helper library for REVerses ENGineered formats filters"
HOMEPAGE="http://sf.net/p/libwpd/librevenge"
if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://git.code.sf.net/p/libwpd/librevenge"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="http://sf.net/projects/libwpd/files/${PN}/${P}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="|| ( MPL-2.0 LGPL-2.1 )"
SLOT="0"
IUSE="doc"

RDEPEND="
	dev-libs/boost
	dev-util/cppunit
	sys-libs/zlib
"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
"

[[ ${PV} == "9999" ]] && AUTOTOOLS_AUTORECONF=yes

src_configure() {
	myeconfargs=(
		"--disable-static"
		"--disable-werror"
		"$(use_with doc docs)"
		"--docdir=${EPREFIX}/usr/share/doc/${PF}"
	)
	autotools-utils_src_configure
}

src_install() {
	autotools-utils_src_install
	prune_libtool_files --all
}
