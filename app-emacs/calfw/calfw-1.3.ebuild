# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/calfw/calfw-1.3.ebuild,v 1.1 2011/10/10 08:31:25 naota Exp $

EAPI=3
NEED_EMACS=22

inherit elisp eutils

DESCRIPTION="A calendar framework for Emacs"
HOMEPAGE="https://github.com/kiwanami/emacs-calfw"
SRC_URI="https://github.com/kiwanami/emacs-calfw/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="howm"

DEPEND="howm? ( app-emacs/howm )"
RDEPEND="${DEPEND}"

SITEFILE="50${PN}-gentoo.el"

src_unpack() {
	unpack ${A}
	mv kiwanami-emacs-calfw-* ${P} || die
}

src_prepare() {
	use howm || rm -f calfw-howm.el
}
