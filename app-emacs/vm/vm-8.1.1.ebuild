# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/vm/vm-8.1.1.ebuild,v 1.4 2012/07/29 17:14:56 armin76 Exp $

inherit elisp eutils

MY_PV="${PV/_/-}"
MY_P="${PN}-${MY_PV}"
DESCRIPTION="The VM mail reader for Emacs"
HOMEPAGE="http://www.nongnu.org/viewmail/"
SRC_URI="http://launchpad.net/vm/${PV%.*}.x/${MY_PV}/+download/${MY_P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="bbdb ssl"

DEPEND="bbdb? ( app-emacs/bbdb )"
RDEPEND="!app-emacs/u-vm-color
	${DEPEND}
	ssl? ( net-misc/stunnel )"

S="${WORKDIR}/${MY_P}"
SITEFILE="50${PN}-gentoo-8.0.el"

src_unpack() {
	unpack ${A}
	cd "${S}"

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
	emake -j1 || die "emake failed"
}

src_install() {
	emake -j1 DESTDIR="${D}" install || die "emake install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	dodoc CHANGES NEWS README TODO example.vm || die "dodoc failed"
}
