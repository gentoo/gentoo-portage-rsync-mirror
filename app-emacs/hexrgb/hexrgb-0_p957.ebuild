# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/hexrgb/hexrgb-0_p957.ebuild,v 1.3 2014/04/12 09:38:02 ago Exp $

EAPI=5

inherit elisp

DESCRIPTION="Functions to manipulate colors, including RGB hex strings"
HOMEPAGE="http://www.emacswiki.org/emacs/hexrgb.el"
SRC_URI="http://dev.gentoo.org/~ulm/distfiles/${P}.el.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 x86"

SITEFILE="50${PN}-gentoo.el"
