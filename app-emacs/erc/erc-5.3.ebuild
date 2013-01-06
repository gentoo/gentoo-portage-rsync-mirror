# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/erc/erc-5.3.ebuild,v 1.5 2010/05/22 15:42:48 ulm Exp $

inherit elisp

DESCRIPTION="The Emacs IRC Client"
HOMEPAGE="http://savannah.gnu.org/projects/erc/
	http://www.emacswiki.org/emacs/ERC"
SRC_URI="mirror://gnu/erc/${P}.tar.gz"

LICENSE="GPL-3 FDL-1.2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE=""

SITEFILE="50${PN}-gentoo.el"
ELISP_TEXINFO="${PN}.texi"
DOCS="AUTHORS ChangeLog* CREDITS HISTORY README servers.pl"

src_compile() {
	# force regeneration of autoload file by the proper Emacs version
	rm -f erc-auto.el
	emake || die "emake failed"
}
