# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/prime-el/prime-el-1.5.1.3.ebuild,v 1.9 2012/10/07 16:11:25 armin76 Exp $

EAPI=4

inherit elisp

MY_P="${P/_p/.}"
DESCRIPTION="PRIME Client for Emacs"
HOMEPAGE="http://taiyaki.org/prime/"
SRC_URI="http://prime.sourceforge.jp/src/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ppc64 x86"
IUSE=""

S="${WORKDIR}/${MY_P}"
SITEFILE="50${PN}-gentoo.el"

DEPEND="app-emacs/apel
	app-emacs/mell
	dev-libs/suikyo"
RDEPEND="${DEPEND}
	>=app-i18n/prime-0.8.6"

src_configure() {
	econf --with-prime-initdir=/usr/share/emacs/site-lisp \
		--with-prime-docdir=/usr/share/doc/${PF}
}

src_compile() {
	default
}

src_install() {
	emake DESTDIR="${D}" install install-etc

	elisp-site-file-install "${FILESDIR}/${SITEFILE}" || die

	dodoc AUTHORS ChangeLog README
	mv "${D}"/usr/share/doc/${PF}/{emacs,html} || die
}
