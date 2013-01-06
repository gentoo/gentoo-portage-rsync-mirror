# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/distel/distel-4.03.ebuild,v 1.2 2009/02/20 18:22:43 ulm Exp $

EAPI=2

inherit elisp eutils

DESCRIPTION="Distributed Emacs Lisp for Erlang"
HOMEPAGE="http://fresh.homeunix.net/~luke/distel/"
SRC_URI="http://distel.googlecode.com/files/${P}.tgz"

# "New BSD License" according to http://code.google.com/p/distel/
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND=">=dev-lang/erlang-11.2.5[emacs]"
RDEPEND="${DEPEND}"

SITEFILE="50${PN}-gentoo.el"

src_prepare() {
	epatch "${FILESDIR}/${P}-fix-ebin-path.patch"
}

src_compile() {
	emake base info || die "emake failed"
	cd elisp
	elisp-compile *.el || die
}

src_install() {
	emake prefix="${D}"/usr \
		ELISP_DIR="${D}${SITELISP}/${PN}" install \
		|| die "emake install failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die
	doinfo doc/distel.info || die "doinfo failed"
	dohtml doc/distel/*.html || die "dohtml failed"
	dodoc AUTHORS ChangeLog NEWS README* || die "dodoc failed"
	if use doc; then
		dodoc doc/gorrie02distel.pdf || die "dodoc failed"
	fi
}
