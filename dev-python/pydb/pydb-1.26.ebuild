# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pydb/pydb-1.26.ebuild,v 1.3 2011/12/24 13:21:05 grozin Exp $

EAPI=3

inherit elisp-common

DESCRIPTION="Extended python debugger"
HOMEPAGE="http://bashdb.sourceforge.net/pydb/"
SRC_URI="mirror://sourceforge/bashdb/${P}.tar.bz2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="emacs"

DEPEND=">=dev-lang/python-2.4.0
	virtual/emacs"
RDEPEND="${DEPEND}"

# This package uses not distutils but the usual
# ./configure; make; make install
# The default src_compile is OK

src_configure() {
	econf --with-lispdir="${SITELISP}/${PN}" \
		EMACS="$(use emacs && echo "${EMACS}" || echo no)"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc AUTHORS ChangeLog NEWS README THANKS TODO
}
