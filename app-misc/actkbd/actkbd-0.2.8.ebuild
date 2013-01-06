# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/actkbd/actkbd-0.2.8.ebuild,v 1.5 2011/03/04 08:12:18 tomka Exp $

inherit linux-info eutils toolchain-funcs

DESCRIPTION="A keyboard shortcut daemon"
HOMEPAGE="http://users.softlab.ece.ntua.gr/~thkala/projects/actkbd/"
SRC_URI="http://users.softlab.ece.ntua.gr/~thkala/projects/actkbd/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND=""
RDEPEND=""

CONFIG_CHECK="~INPUT_EVDEV"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}"/${PN}-0.2.7-amd64.patch
}

src_compile() {
	emake CFLAGS="${CFLAGS}" CC="$(tc-getCC)" || die "emake failed"
}

src_install() {
	dobin actkbd || die "dobin failed"
	dodoc AUTHORS ChangeLog FAQ README TODO
	docinto samples
	dodoc samples/{actkbd.conf,udev.rules}
}

pkg_postinst() {
	elog
	elog "actkbd currently needs the event interface from 2.6 kernels to work. Add"
	elog "evdev to /etc/modules.autoload.d/kernel-2.6 to have it loaded during boot."
	elog "System-wide configuration file is /etc/actkbd.conf, but you can use the -c"
	elog "option to specify a custom configuration file. Use actkbd.conf from"
	elog "/usr/share/doc/${PF}/samples as a template. We don't install it by default,"
	elog "because it contains some dangerous examples. You may also need to supply"
	elog "the -d option to use the right /dev/input/event* device."
	elog
}
