# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/librevenge/librevenge-9999.ebuild,v 1.2 2014/08/16 07:36:55 scarabeus Exp $

EAPI="5"

inherit eutils multilib-minimal

DESCRIPTION="A helper library for REVerses ENGineered formats filters"
HOMEPAGE="http://sf.net/p/libwpd/librevenge"
if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://git.code.sf.net/p/libwpd/librevenge"
	inherit git-r3 autotools
	KEYWORDS=""
else
	SRC_URI="http://sf.net/projects/libwpd/files/${PN}/${P}/${P}.tar.xz"
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="|| ( MPL-2.0 LGPL-2.1 )"
SLOT="0"
IUSE="doc test"

RDEPEND="
	dev-libs/boost:=
	sys-libs/zlib[${MULTILIB_USEDEP}]
"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )
	test? ( dev-util/cppunit[${MULTILIB_USEDEP}] )
"

src_prepare() {
	[[ ${PV} = 9999 ]] && eautoreconf
}

multilib_src_configure() {
	ECONF_SOURCE=${S} \
	econf \
		--disable-static \
		--disable-werror \
		$(use_with doc docs) \
		$(use_enable test tests) \
		--docdir="${EPREFIX}/usr/share/doc/${PF}"
}

multilib_src_install_all() {
	prune_libtool_files --all
}
