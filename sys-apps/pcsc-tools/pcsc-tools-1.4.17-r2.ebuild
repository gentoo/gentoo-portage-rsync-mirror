# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/pcsc-tools/pcsc-tools-1.4.17-r2.ebuild,v 1.2 2012/05/04 09:17:29 jdhore Exp $

EAPI="3"

SMARTCARD_DATE=20101010

inherit eutils fdo-mime multilib toolchain-funcs

DESCRIPTION="PC/SC Architecture smartcard tools"
HOMEPAGE="http://ludovic.rousseau.free.fr/softwares/pcsc-tools/"
SRC_URI="http://ludovic.rousseau.free.fr/softwares/${PN}/${P}.tar.gz
	mirror://gentoo/${PN}-smartcard_list-${SMARTCARD_DATE}.txt.bz2"

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
	emake pcsc_scan || die
}

src_install() {
	# install manually, makes it much easier since the Makefile
	# requires fiddling with
	dobin ATR_analysis scriptor pcsc_scan || die
	doman pcsc_scan.1 scriptor.1p ATR_analysis.1p || die

	dodoc README Changelog || die

	if use gtk; then
		domenu gscriptor.desktop || die
		dobin gscriptor || die
		doman gscriptor.1p || die
	fi

	if use network-cron ; then
		exeinto /etc/cron.monthly
		newexe "${FILESDIR}"/smartcard.cron update-smartcard_list \
			|| die "Failed to install update cronjob"
	fi

	insinto /usr/share/pcsc
	newins "${WORKDIR}"/${PN}-smartcard_list-${SMARTCARD_DATE}.txt smartcard_list.txt || die
}

pkg_postinst() {
	use gtk && fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
