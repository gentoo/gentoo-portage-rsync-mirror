# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/cloog/cloog-9999.ebuild,v 1.3 2014/11/04 03:36:19 vapier Exp $

EAPI="5"

inherit eutils multilib-minimal

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="git://repo.or.cz/cloog.git"
	inherit autotools git-2
else
	KEYWORDS="~alpha ~amd64 ~arm ~arm64 ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd"
	SRC_URI="http://www.bastoul.net/cloog/pages/download/${P}.tar.gz"
fi

DESCRIPTION="A loop generator for scanning polyhedra"
HOMEPAGE="http://www.bastoul.net/cloog/"

LICENSE="LGPL-2.1"
SLOT="0/4"
IUSE="static-libs"

RDEPEND=">=dev-libs/gmp-5.1.3-r1[${MULTILIB_USEDEP}]
	>=dev-libs/isl-0.12.2:0/10[${MULTILIB_USEDEP}]
	!<dev-libs/cloog-ppl-0.15.10"
DEPEND="${DEPEND}
	virtual/pkgconfig"

DOCS=( README )

src_prepare() {
	if [[ ${PV} == "9999" ]] ; then
		./get_submodules.sh
		eautoreconf -i
	else
		# m4/ax_create_pkgconfig_info.m4 includes LDFLAGS
		# sed to avoid eautoreconf
		sed -i -e '/Libs:/s:@LDFLAGS@ ::' configure || die
	fi
}

multilib_src_configure() {
	ECONF_SOURCE="${S}" econf \
		--with-gmp=system \
		--with-isl=system \
		--with-osl=no \
		$(use_enable static-libs static)
}

multilib_src_install_all() {
	einstalldocs
	prune_libtool_files
}
