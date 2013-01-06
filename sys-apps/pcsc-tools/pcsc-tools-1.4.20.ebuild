# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcsc-tools/pcsc-tools-1.4.20.ebuild,v 1.1 2012/06/16 16:07:15 flameeyes Exp $

EAPI="4"

inherit eutils fdo-mime multilib toolchain-funcs

DESCRIPTION="PC/SC Architecture smartcard tools"
HOMEPAGE="http://ludovic.rousseau.free.fr/softwares/pcsc-tools/"
SRC_URI="http://ludovic.rousseau.free.fr/softwares/${PN}/${P}.tar.gz
	${SC_REV:+http://anonscm.debian.org/viewvc/pcsclite/trunk/pcsc-tools/smartcard_list.txt?revision=${SC_REV}&view=co -> ${PN}-smartcard_list-${SC_REV}.txt}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE="gtk network-cron"

RDEPEND=">=sys-apps/pcsc-lite-1.4.14"

DEPEND="${RDEPEND}
	virtual/pkgconfig"
RDEPEND="${RDEPEND}
	dev-perl/pcsc-perl
	gtk? ( dev-perl/gtk2-perl )"

src_prepare() {
	sed -i -e 's:-Wall -O2:${CFLAGS}:g' Makefile
}

src_compile() {
	tc-export CC
	# explicitly only build the pcsc_scan application, or the man
	# pages will be gzipped first, and then unpacked.
	emake pcsc_scan
}

src_install() {
	# install manually, makes it much easier since the Makefile
	# requires fiddling with
	dobin ATR_analysis scriptor pcsc_scan
	doman pcsc_scan.1 scriptor.1p ATR_analysis.1p

	dodoc README Changelog

	if use gtk; then
		domenu gscriptor.desktop
		dobin gscriptor
		doman gscriptor.1p
	fi

	if use network-cron ; then
		exeinto /etc/cron.monthly
		newexe "${FILESDIR}"/smartcard.cron update-smartcard_list
	fi

	insinto /usr/share/pcsc
	if [[ -n ${SC_REV} ]]; then
		newins "${WORKDIR}"/${PN}-smartcard_list-${SC_REV}.txt smartcard_list.txt
	else
		doins smartcard_list.txt
	fi
}

pkg_postinst() {
	use gtk && fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
