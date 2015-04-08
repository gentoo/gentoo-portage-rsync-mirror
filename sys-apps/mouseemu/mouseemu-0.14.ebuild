# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/mouseemu/mouseemu-0.14.ebuild,v 1.2 2007/04/29 18:28:45 tove Exp $

inherit eutils

DESCRIPTION="Emulates scrollwheel, right- & left-click for one-button mice/touchpads"
HOMEPAGE="http://geekounet.org/powerbook/"
SRC_URI="http://geekounet.org/powerbook/files/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~ppc"
IUSE=""
DEPEND=""

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${PN}-0.13-fix.patch
}

src_compile() {
	echo `pwd`
	emake || die
}

src_install() {
	dosbin mouseemu
	dodoc README COPYING
	newinitd mouseemu.init.gentoo mouseemu
	insinto /etc
	doins mouseemu.conf
}

pkg_postinst() {
	einfo "For mouseemu to work you need uinput support in your kernel:"
	einfo "        CONFIG_INPUT_UINPUT=y"
	einfo "(Device Drivers->Input device support->Misc->User level driver support)"
	einfo "Don't forget to add mouseemu to your default runlevel:"
	einfo "        rc-update add mouseemu default"
	einfo "Configuration is in /etc/mouseemu.conf."
}
