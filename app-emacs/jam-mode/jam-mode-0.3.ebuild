# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/jam-mode/jam-mode-0.3.ebuild,v 1.4 2014/04/19 11:58:40 ago Exp $

EAPI=5

inherit elisp

DESCRIPTION="An Emacs major mode for editing Jam files"
HOMEPAGE="https://web.archive.org/web/20100211015821/http://www.tenfoot.org.uk/index.html"
# taken from http://www.tenfoot.org.uk/emacs/${PN}.el
SRC_URI="http://dev.gentoo.org/~ulm/distfiles/${P}.el.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="alpha amd64 x86"

SITEFILE="50${PN}-gentoo.el"
