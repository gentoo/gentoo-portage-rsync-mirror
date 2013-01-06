# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/twittering-mode/twittering-mode-9999.ebuild,v 1.2 2012/03/13 14:47:58 naota Exp $

EAPI=4

inherit elisp elisp-common eutils

if [ "${PV}" = "9999" ]; then
	EGIT_REPO_URI="git://github.com/hayamiz/twittering-mode.git"
	inherit git-2
	SRC_URI=""
	KEYWORDS=""
else
	SRC_URI="mirror://sourceforge/twmode/${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
	RESTRICT="test"
fi

DESCRIPTION="Emacs major mode for Twitter."
HOMEPAGE="http://twmode.sourceforge.net/"

LICENSE="GPL-2"
SLOT="0"
IUSE="doc"

DEPEND=""
RDEPEND="app-crypt/gnupg"

src_compile() {
	elisp-compile twittering-mode.el || die
	use doc && emake -C doc/manual
}

src_test() {
	emake check
}

src_install() {
	use doc && dodoc doc/manual/twmode/twmode.html
	elisp-install ${PN} twittering-mode.el *.elc || die
}
