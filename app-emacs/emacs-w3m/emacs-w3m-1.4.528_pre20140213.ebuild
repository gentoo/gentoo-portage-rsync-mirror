# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/emacs-w3m/emacs-w3m-1.4.528_pre20140213.ebuild,v 1.1 2014/02/25 18:06:57 ulm Exp $

EAPI=5

inherit readme.gentoo elisp autotools

DESCRIPTION="emacs-w3m is an interface program of w3m on Emacs"
HOMEPAGE="http://emacs-w3m.namazu.org/"
SRC_URI="http://dev.gentoo.org/~ulm/distfiles/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="linguas_ja"

DEPEND="virtual/w3m"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"
SITEFILE="70${PN}-gentoo.el"

src_prepare() {
	eautoreconf
}

src_configure() {
	default
}

src_compile() {
	emake all-en $(use linguas_ja && echo all-ja)
}

src_install() {
	emake lispdir="${ED}${SITELISP}/${PN}" \
		infodir="${ED}/usr/share/info" \
		ICONDIR="${ED}${SITEETC}/${PN}" \
		install-en $(use linguas_ja && echo install-ja) install-icons

	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	dodoc ChangeLog* NEWS README
	use linguas_ja && dodoc BUGS.ja NEWS.ja README.ja

	DOC_CONTENTS="If you want to use the shimbun library, please emerge
		app-emacs/apel and app-emacs/flim."
	readme.gentoo_create_doc
}
