# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/crossdev/crossdev-20120721.ebuild,v 1.2 2012/08/20 02:50:07 vapier Exp $

EAPI="4"

if [[ ${PV} == "99999999" ]] ; then
	EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/crossdev.git"
	inherit git-2
	SRC_URI=""
	#KEYWORDS=""
else
	SRC_URI="mirror://gentoo/${P}.tar.xz
		http://dev.gentoo.org/~vapier/dist/${P}.tar.xz"
	KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
fi

DESCRIPTION="Gentoo Cross-toolchain generator"
HOMEPAGE="http://www.gentoo.org/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

RDEPEND=">=sys-apps/portage-2.1
	app-shells/bash
	!sys-devel/crossdev-wrappers"
DEPEND="app-arch/xz-utils"

src_install() {
	default
	if [[ "${PV}" == "99999999" ]] ; then
		sed -i "s:@CDEVPV@:${EGIT_VERSION}:" "${ED}"/usr/bin/crossdev || die
	fi
}
