# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/gnuserv/gnuserv-3.12.8-r1.ebuild,v 1.1 2014/02/15 12:54:45 ulm Exp $

EAPI=5

inherit elisp multilib

DESCRIPTION="Attach to an already running Emacs"
HOMEPAGE="http://meltin.net/hacks/emacs/"
SRC_URI="http://meltin.net/hacks/emacs/src/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-linux ~ppc-macos"
IUSE="X"

DEPEND="X? ( x11-libs/libXau )"
RDEPEND="${DEPEND}
	!app-editors/xemacs
	!app-emacs/gnuserv-programs"

SITEFILE="50${PN}-gentoo.el"

src_configure() {
	econf $(use_enable X xauth) \
		--x-includes="${EPREFIX}"/usr/include \
		--x-libraries="${EPREFIX}"/usr/$(get_libdir)
}

src_compile() {
	default
}

src_install() {
	emake -j1 \
		prefix="${ED}"/usr \
		man1dir="${ED}"/usr/share/man/man1 \
		install

	elisp-install ${PN} *.el *.elc
	elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	dodoc ChangeLog README README.orig
}
