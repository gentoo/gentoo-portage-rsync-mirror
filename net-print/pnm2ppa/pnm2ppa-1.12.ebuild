# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/pnm2ppa/pnm2ppa-1.12.ebuild,v 1.15 2009/07/18 18:24:17 ssuominen Exp $

EAPI=2
inherit flag-o-matic toolchain-funcs

DESCRIPTION="Print driver for Hp Deskjet 710, 712, 720, 722, 820, 1000 series"
HOMEPAGE="http://pnm2ppa.sourceforge.net"
SRC_URI="mirror://sourceforge/pnm2ppa/${P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

RDEPEND="app-text/enscript
	dev-util/dialog"
DEPEND="${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/${P}-gentoo.diff
}

src_compile() {
	tc-export CC
	append-flags -DNDEBUG -DLANG_EN

	emake || die "emake failed"

	cd ppa_protocol
	emake || die "emake failed"
}

src_install () {
	dodir /etc /usr/{bin,share/man/man1}

	emake BINDIR="${D}/usr/bin" CONFDIR="${D}/etc" \
		MANDIR="${D}/usr/share/man/man1" install \
		|| die "emake install failed"

	dobin utils/Linux/detect_ppa utils/Linux/test_ppa || die "dobin failed"

	insinto /usr/share/pnm2ppa
	doins -r lpd pdq || die "doins failed"
	exeinto /usr/share/pnm2ppa/lpd
	doexe lpd/lpdsetup || die "doexe failed"

	exeinto /usr/share/pnm2ppa/sample_scripts
	doexe sample_scripts/* || die "doexe failed"

	cd "${S}"/pdq
	exeinto /etc/pdq/drivers/ghostscript
	doexe gs-pnm2ppa || die "doexe failed"
	exeinto /etc/pdq/interfaces
	doexe dummy || die "doexe failed"

	cd "${S}"/docs/en
	dodoc CALIBRATION*txt COLOR*txt PPA*txt RELEASE* CREDITS README \
		TODO || die "dodoc failed"

	cd "${S}"/docs/en/sgml
	insinto /usr/share/doc/${PF}
	doins *.sgml || die "doins failed"

	cd "${S}"
	dohtml -r . || die "dohtml failed"
}

pkg_postinst() {
	elog "Now, you *must* edit /etc/pnm2ppa.conf and choose (at least)"
	elog "your printer model and papersize."
	echo ""
	elog "Run calibrate_ppa to calibrate color offsets."
	echo ""
	elog "Read the docs in /usr/share/pnm2ppa/ to configure the printer,"
	elog "configure lpr substitutes, cups, pdq, networking etc."
	echo ""
	elog "Note that lpr and pdq drivers *have* been installed, but if your"
	elog "config file management has /etc blocked (the default), they have"
	elog "been installed under different filenames. Read the appropriate"
	elog "Gentoo documentation for more info."
	echo ""
	elog "Note: lpr has been configured for default papersize letter"
}
