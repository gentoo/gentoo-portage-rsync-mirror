# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/rudel/rudel-0.3_pre20110721.ebuild,v 1.3 2011/12/26 14:09:04 ulm Exp $

EAPI=4
NEED_EMACS=23

inherit elisp

DESCRIPTION="Collaborative editing environment for GNU Emacs"
HOMEPAGE="http://rudel.sourceforge.net/
	http://www.emacswiki.org/emacs/Rudel"
# snapshot of bzr://rudel.bzr.sourceforge.net/bzrroot/rudel/trunk
SRC_URI="mirror://gentoo/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="virtual/emacs-cedet"
DEPEND="${RDEPEND}
	app-arch/xz-utils"

S="${WORKDIR}/${PN}"
SITEFILE="60${PN}-gentoo.el"

src_compile() {
	${EMACS} ${EMACSFLAGS} -l rudel-compile.el || die
}

src_install() {
	local dir

	for dir in . adopted infinote jupiter obby socket telepathy tls \
		xmpp zeroconf
	do
		insinto "${SITELISP}/${PN}/${dir}"
		doins ${dir}/*.{el,elc}
	done

	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die

	insinto "${SITEETC}/${PN}"
	doins -r icons

	dodoc README INSTALL ChangeLog TODO doc/card.pdf
}

pkg_postinst() {
	elisp_pkg_postinst

	elog "Connections to Gobby servers require the gnutls-cli program"
	elog "(net-libs/gnutls)."
	elog "The Avahi daemon (net-dns/avahi) is required for automatic"
	elog "session discovery and advertising."
}
