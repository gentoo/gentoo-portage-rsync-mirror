# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/lxdvdrip/lxdvdrip-1.76.ebuild,v 1.1 2011/05/03 18:29:52 aballier Exp $

inherit eutils toolchain-funcs

DESCRIPTION="command line tool to automate the process of ripping and burning DVD"
SRC_URI="mirror://berlios/lxdvdrip/${P}.tgz"
HOMEPAGE="http://developer.berlios.de/projects/lxdvdrip/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="media-libs/libdvdread"
RDEPEND="${DEPEND}
	>=media-video/dvdauthor-0.6.9
	media-video/streamdvd
	media-video/mpgtx"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${PN}-1.76-makefile.patch"
	epatch "${FILESDIR}/${PN}-1.70-vamps-makefile.patch"
}

src_compile() {
	CC="$(tc-getCC)" emake || die "emake failed"
	cd "${S}/vamps"
	emake CC="$(tc-getCC)" || die "emake lxdvdip vamps failed"
}

src_install () {
	dobin lxdvdrip || die
	dobin lxac3scan || die
	dodoc doc-pak/Changelog* doc-pak/Credits doc-pak/Debugging.*
	dodoc doc-pak/lxdvdrip.conf* doc-pak/README* doc-pak/TODO
	doman lxdvdrip.1

	insinto /usr/share
	doins lxdvdrip.wav

	insinto /etc
	newins doc-pak/lxdvdrip.conf.EN lxdvdrip.conf

	cd "${S}/vamps"
	emake PREFIX="${D}/usr" install || die "make install failed for vamps!"
}
