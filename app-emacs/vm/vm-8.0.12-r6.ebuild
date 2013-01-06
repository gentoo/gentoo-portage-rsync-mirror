# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/vm/vm-8.0.12-r6.ebuild,v 1.7 2012/07/29 17:14:56 armin76 Exp $

inherit elisp eutils

DESCRIPTION="The VM mail reader for Emacs"
HOMEPAGE="http://www.nongnu.org/viewmail/"
SRC_URI="http://download.savannah.nongnu.org/releases/viewmail/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE="bbdb ssl"

DEPEND="bbdb? ( app-emacs/bbdb )"
RDEPEND="${DEPEND}
	ssl? ( net-misc/stunnel )"

SITEFILE="50${PN}-gentoo-8.0.el"

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-autoload-vm-pine.patch" #246185
	epatch "${FILESDIR}/${P}-supercite-yank-1.patch" #256886
	epatch "${FILESDIR}/${P}-folder-corruption.patch" #284668
	epatch "${FILESDIR}/${P}-emacs-23.patch"
	epatch "${FILESDIR}/${P}-charset-displayable.patch"

	if ! use bbdb; then
		elog "Excluding vm-pcrisis.el since the \"bbdb\" USE flag is not set."
		epatch "${FILESDIR}/vm-8.0-no-pcrisis.patch"
	fi
}

src_compile() {
	econf \
		--with-emacs="emacs" \
		--with-pixmapdir="${SITEETC}/${PN}" \
		$(use bbdb && echo "--with-other-dirs=${SITELISP}/bbdb")
	emake || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	dodoc NEWS README TODO example.vm || die "dodoc failed"
}
