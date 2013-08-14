# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/netifrc/netifrc-9999.ebuild,v 1.1 2013/08/14 06:37:32 williamh Exp $

EAPI=5

inherit eutils

DESCRIPTION="Gentoo Network Interface Management Scripts"
HOMEPAGE="http://www.gentoo.org/proj/en/base/openrc/"

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/gentoo-oldnet.git"
	inherit git-2
else
	SRC_URI="http://dev.gentoo.org/~williamh/dist/${P}.tar.bz2"
	KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
fi

LICENSE="BSD-2"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND=">=sys-apps/openrc-0.12
!<sys-apps/openrc-0.12"

src_prepare() {
	sed -i 's:0444:0644:' mk/sys.mk || die
	sed -i "/^DIR/s:/${PN}:/${PF}:" doc/Makefile || die #241342

	if [[ ${PV} == "9999" ]] ; then
		local ver="git-${EGIT_VERSION:0:6}"
		sed -i "/^GITVER[[:space:]]*=/s:=.*:=${ver}:" mk/git.mk || die
	fi

	# Allow user patches to be applied without modifying the ebuild
	epatch_user
}

src_compile() {
	MAKE_ARGS="${MAKE_ARGS}
		LIBEXECDIR=${EPREFIX}/lib/${PN}"

	use prefix && MAKE_ARGS="${MAKE_ARGS} MKPREFIX=yes PREFIX=${EPREFIX}"

	emake ${MAKE_ARGS} all
}

src_install() {
	emake ${MAKE_ARGS} DESTDIR="${D}" install
}
