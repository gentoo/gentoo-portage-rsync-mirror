# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/edb/edb-1.31.ebuild,v 1.2 2010/09/09 11:44:30 ulm Exp $

inherit elisp eutils

DESCRIPTION="EDB, The Emacs Database"
HOMEPAGE="http://www.gnuvola.org/software/edb/"
SRC_URI="http://www.gnuvola.org/software/edb/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64 ~ppc"
IUSE=""

ELISP_PATCHES="${P}-skram-path.patch"
SITEFILE="52${PN}-gentoo.el"

src_compile() {
	econf
	emake -j1 || die
}

src_install() {
	einstall sitelisp="${D}${SITELISP}" || die "einstall failed"
	elisp-site-file-install "${FILESDIR}/${SITEFILE}" \
		|| die "elisp-site-file-install failed"
	dodoc AUTHORS BUGS ChangeLog HACKING NEWS README THANKS TODO \
		doc/refcard.ps || die "dodoc failed"
	insinto /usr/share/doc/${PF}; doins -r examples
}
