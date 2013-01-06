# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-drivers/afb-ucode/afb-ucode-1.3.11.ebuild,v 1.2 2012/02/14 17:19:50 tove Exp $

inherit multilib

DESCRIPTION="Binary blob microcode for Elite3D framebuffers to use X, required by xf86-video-sunffb"
HOMEPAGE="none"
SRC_URI="http://dlc.sun.com/osol/sparc-gfx/downloads/${PN}.tar.bz2
	mirror://gentoo/${PN}.tar.bz2"
IUSE=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="-* sparc"

RDEPEND="${DEPEND}
	x11-misc/afbinit"

S="${WORKDIR}/${PN}"

src_install() {
	insinto /usr/$(get_libdir)
	doins afb.ucode
}
