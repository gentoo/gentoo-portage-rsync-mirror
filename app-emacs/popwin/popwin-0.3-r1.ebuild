# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/popwin/popwin-0.3-r1.ebuild,v 1.2 2011/10/21 19:19:58 ulm Exp $

EAPI=3
NEED_EMACS=22

inherit elisp eutils

DESCRIPTION="Popup window manager for Emacs"
HOMEPAGE="https://github.com/m2ym/popwin-el/"
SRC_URI="https://github.com/m2ym/popwin-el/tarball/v${PV} -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SITEFILE="50${PN}-gentoo.el"
DOCS="README.markdown"
ELISP_PATCHES="${P}-emacs24.patch"

src_unpack() {
	unpack ${A}
	mv m2ym-popwin-el-* ${P} || die
}
