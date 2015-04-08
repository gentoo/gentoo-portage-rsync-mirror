# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/hexrgb/hexrgb-0_p957.ebuild,v 1.5 2014/05/14 14:21:15 ago Exp $

EAPI=5

inherit elisp

DESCRIPTION="Functions to manipulate colors, including RGB hex strings"
HOMEPAGE="http://www.emacswiki.org/emacs/hexrgb.el"
SRC_URI="http://dev.gentoo.org/~ulm/distfiles/${P}.el.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"

SITEFILE="50${PN}-gentoo.el"
