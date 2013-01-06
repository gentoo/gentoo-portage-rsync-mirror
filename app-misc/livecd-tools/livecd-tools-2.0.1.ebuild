# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/livecd-tools/livecd-tools-2.0.1.ebuild,v 1.2 2011/08/29 15:21:59 armin76 Exp $

EAPI=4

EGIT_REPO_URI="git://git.overlays.gentoo.org/proj/livecd-tools.git"
[[ ${PV} == "9999" ]] && SCM_ECLASS="git-2"
inherit eutils $SCM_ECLASS
unset SCM_ECLASS

DESCRIPTION="Gentoo LiveCD tools for autoconfiguration of hardware"
HOMEPAGE="http://wolf31o2.org/projects/livecd-tools"
if [[ ${PV} != "9999" ]] ; then
	SRC_URI="mirror://gentoo/${P}.tar.bz2"
	KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ppc64 sparc x86"
fi

SLOT="0"
LICENSE="GPL-2"
IUSE=""

RDEPEND="dev-util/dialog
	>=sys-apps/baselayout-2
	>=sys-apps/openrc-0.8.2-r1
	sys-apps/pciutils
	sys-apps/gawk
	sys-apps/sed"

pkg_setup() {
		ewarn "This package is designed for use on the LiveCD only and will do"
		ewarn "unspeakably horrible and unexpected things on a normal system."
		ewarn "YOU HAVE BEEN WARNED!!!"
}

src_install() {
	doconfd conf.d/*
	doinitd init.d/*
	dosbin net-setup spind
	into /
	dobin bashlogin
	dosbin livecd-functions.sh
}
