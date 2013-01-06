# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/inform/inform-6.31.1.ebuild,v 1.5 2012/10/04 15:25:03 ottxor Exp $

EAPI=4

DESCRIPTION="design system for interactive fiction"
HOMEPAGE="http://www.inform-fiction.org/"
SRC_URI="http://mirror.ifarchive.org/if-archive/infocom/compilers/inform6/source/${P}.tar.gz"

LICENSE="Inform"
SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos"
IUSE="emacs"
PDEPEND="emacs? ( app-emacs/inform-mode )"

src_install() {
	default
	dodoc VERSION
	docinto tutorial
	dodoc tutor/README tutor/*.txt tutor/*.inf
	mv "${ED}"/usr/share/${PN}/manual "${ED}"/usr/share/doc/${PF}/html
	rmdir "${ED}"/usr/share/inform/{include,module}
}
